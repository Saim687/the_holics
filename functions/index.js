const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { defineSecret } = require("firebase-functions/params");
const admin = require("firebase-admin");
const { Resend } = require("resend");

admin.initializeApp();

const RESEND_API_KEY = defineSecret("RESEND_API_KEY");
const OWNER_EMAIL = defineSecret("OWNER_EMAIL");
const FROM_EMAIL = defineSecret("FROM_EMAIL");

function formatDate(rawDate) {
  try {
    if (!rawDate) return "-";
    if (rawDate.toDate) return rawDate.toDate().toLocaleDateString("en-GB");
    if (rawDate._seconds) return new Date(rawDate._seconds * 1000).toLocaleDateString("en-GB");
    if (typeof rawDate === "string") return rawDate;
    return String(rawDate);
  } catch (_) {
    return "-";
  }
}

function inferName(email) {
  if (!email || typeof email !== "string") return "Customer";
  return email.split("@")[0].replace(/[._-]+/g, " ").trim() || "Customer";
}

async function resolveUserDetails(uid, appointmentData) {
  const result = {
    userName: appointmentData.userName || null,
    userEmail: appointmentData.userEmail || null,
  };

  try {
    const authUser = await admin.auth().getUser(uid);
    result.userEmail = result.userEmail || authUser.email || null;
    result.userName = result.userName || authUser.displayName || null;
  } catch (_) {
    // Ignore and continue with fallbacks
  }

  try {
    const userDoc = await admin.firestore().collection("users").doc(uid).get();
    if (userDoc.exists) {
      const userData = userDoc.data() || {};
      result.userName = result.userName || userData.name || null;
      result.userEmail = result.userEmail || userData.email || null;
    }
  } catch (_) {
    // Ignore and continue with fallbacks
  }

  if (!result.userName) {
    result.userName = inferName(result.userEmail);
  }

  return result;
}

async function resolveSpecialistName(specialistId) {
  if (!specialistId) return "-";

  try {
    const specialistDoc = await admin
      .firestore()
      .collection("specialists")
      .doc(specialistId)
      .get();

    if (specialistDoc.exists) {
      const specialistData = specialistDoc.data() || {};
      return specialistData.name || specialistId;
    }
  } catch (_) {
    // Ignore and fallback to id
  }

  return specialistId;
}

exports.emailOnBookingCreated = onDocumentCreated(
  {
    document: "users/{uid}/appointments/{appointmentId}",
    region: "us-central1",
    secrets: [RESEND_API_KEY, OWNER_EMAIL, FROM_EMAIL],
  },
  async (event) => {
    const snap = event.data;
    if (!snap) return;

    const data = snap.data();
    const { uid, appointmentId } = event.params;

    const resend = new Resend(RESEND_API_KEY.value());

    const userDetails = await resolveUserDetails(uid, data);
    const userEmail = userDetails.userEmail;
    const userName = userDetails.userName;

    const dateText = formatDate(data.date);
    const timeText = data.time || "-";
    const serviceText = data.service || "Consultation";
    const specialistText = await resolveSpecialistName(data.specialistId);
    const priceText = data.price != null ? String(data.price) : "-";

    const ownerHtml = `
      <h2>New Booking Received</h2>
      <p><b>Booking ID:</b> ${appointmentId}</p>
      <p><b>User:</b> ${userName}</p>
      <p><b>User Email:</b> ${userEmail || "-"}</p>
      <p><b>Service:</b> ${serviceText}</p>
      <p><b>Date:</b> ${dateText}</p>
      <p><b>Time:</b> ${timeText}</p>
      <p><b>Specialist:</b> ${specialistText}</p>
      <p><b>Price:</b> ${priceText}</p>
      <p><b>Status:</b> ${data.status || "confirmed"}</p>
      <hr/>
      <p>Project: the_holics</p>
    `;

    await resend.emails.send({
      from: FROM_EMAIL.value(),
      to: [OWNER_EMAIL.value()],
      subject: `New Booking: ${serviceText} (${dateText} ${timeText})`,
      html: ownerHtml,
    });

    if (userEmail) {
      const userHtml = `
        <h2>Booking Confirmed</h2>
        <p>Hi ${userName},</p>
        <p>Your booking has been confirmed.</p>
        <p><b>Service:</b> ${serviceText}</p>
        <p><b>Date:</b> ${dateText}</p>
        <p><b>Time:</b> ${timeText}</p>
        <p><b>Specialist:</b> ${specialistText}</p>
        <p><b>Booking ID:</b> ${appointmentId}</p>
        <p>Thank you for choosing Holics.</p>
      `;

      await resend.emails.send({
        from: FROM_EMAIL.value(),
        to: [userEmail],
        subject: "Your Holics booking is confirmed",
        html: userHtml,
      });
    }
  }
);
