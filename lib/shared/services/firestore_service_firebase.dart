import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_holics/shared/models/user_model.dart';
import 'package:the_holics/shared/models/subscription_model.dart';
import 'package:the_holics/shared/models/appointment_model.dart';
import 'package:the_holics/shared/models/workout_model.dart';
import 'package:the_holics/shared/models/skin_models.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // === USERS ===
  Future<void> createUser(String uid, User user) async {
    try {
      await _firestore.collection('users').doc(uid).set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getUser(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return User.fromJson(doc.data()!, uid);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
    } catch (e) {
      rethrow;
    }
  }

  Stream<User?> watchUser(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) {
      if (doc.exists) {
        return User.fromJson(doc.data()!, uid);
      }
      return null;
    });
  }

  // === SUBSCRIPTIONS ===
  Future<void> createSubscription(String uid, Subscription subscription) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('subscriptions')
          .add(subscription.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Subscription>> getSubscriptions(String uid) async {
    try {
      final docs = await _firestore
          .collection('users')
          .doc(uid)
          .collection('subscriptions')
          .get();
      return docs.docs
          .map((doc) => Subscription.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // === APPOINTMENTS ===
  Future<void> createAppointment(String uid, Appointment appointment) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('appointments')
          .add(appointment.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Appointment>> getAppointments(String uid) async {
    try {
      final docs = await _firestore
          .collection('users')
          .doc(uid)
          .collection('appointments')
          .get();
      return docs.docs
          .map((doc) => Appointment.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateAppointment(
      String uid, String appointmentId, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('appointments')
          .doc(appointmentId)
          .update(data);
    } catch (e) {
      rethrow;
    }
  }

  // === WORKOUTS ===
  Future<void> createWorkout(String uid, Workout workout) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('workouts')
          .add(workout.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Workout>> getWorkouts(String uid) async {
    try {
      final docs = await _firestore
          .collection('users')
          .doc(uid)
          .collection('workouts')
          .get();
      return docs.docs
          .map((doc) => Workout.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // === SKIN CONSULTATIONS ===
  Future<void> createSkinConsultation(
      String uid, SkinConsultation consultation) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('skin_consultations')
          .add(consultation.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SkinConsultation>> getSkinConsultations(String uid) async {
    try {
      final docs = await _firestore
          .collection('users')
          .doc(uid)
          .collection('skin_consultations')
          .get();
      return docs.docs
          .map((doc) => SkinConsultation.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // === SKIN ROUTINES ===
  Future<void> createSkinRoutine(String uid, SkinRoutine routine) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('skin_routines')
          .add(routine.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SkinRoutine>> getSkinRoutines(String uid) async {
    try {
      final docs = await _firestore
          .collection('users')
          .doc(uid)
          .collection('skin_routines')
          .get();
      return docs.docs
          .map((doc) => SkinRoutine.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // === GOALS ===
  Future<void> createGoal(String uid, Map<String, dynamic> goal) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('goals')
          .add(goal);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getGoals(String uid) async {
    try {
      final docs = await _firestore
          .collection('users')
          .doc(uid)
          .collection('goals')
          .get();
      return docs.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
