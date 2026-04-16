// Route constants
abstract class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String passwordReset = '/password-reset';
  static const String home = '/home';
  static const String bodyHolics = '/body-holics';
  static const String bodyHolicsWorkouts = '$bodyHolics/workouts';
  static const String bodyHolicsNutrition = '$bodyHolics/nutrition';
  static const String skinHolics = '/skin-holics';
  static const String skinHolicsBooking = '$skinHolics/booking';
  static const String skinHolicsGallery = '$skinHolics/gallery';
  static const String profile = '/profile';
  static const String admin = '/admin';
  static const String adminMembers = '$admin/members';
  static const String adminSubscriptions = '$admin/subscriptions';
  static const String adminAppointments = '$admin/appointments';
  static const String adminWorkouts = '$admin/workouts';
  static const String adminServices = '$admin/services';
  static const String adminSpecialists = '$admin/specialists';
  static const String adminSettings = '$admin/settings';
}

// Route guards are handled in main.dart GoRouter redirect logic
// This allows access to Riverpod providers at runtime
