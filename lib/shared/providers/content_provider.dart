import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_holics/shared/models/appointment_model.dart';
import 'package:the_holics/shared/models/workout_model.dart';
import 'package:the_holics/shared/models/skin_models.dart';
import 'package:the_holics/shared/providers/providers.dart';

// Appointments
final userAppointmentsProvider = StreamProvider.family<List<Appointment>, String>((ref, uid) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.userAppointmentsStream(uid);
});

final currentUserAppointmentsProvider = StreamProvider<List<Appointment>>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  if (uid == null) return Stream.value([]);
  return ref.watch(userAppointmentsProvider(uid)).when(
        data: (appointments) => Stream.value(appointments),
        loading: () => Stream.value([]),
        error: (error, stack) => Stream.error(error),
      );
});

final allAppointmentsProvider = FutureProvider<List<Appointment>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getAllAppointments();
});

// Workouts
final workoutsProvider = StreamProvider<List<Workout>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.workoutsStream();
});

// Nutrition Plans
final nutritionPlansProvider = StreamProvider<List<NutritionPlan>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.nutritionPlansStream();
});

// Skin Services
final skinServicesProvider = StreamProvider<List<SkinService>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.skinServicesStream();
});

// Specialists
final specialistsProvider = StreamProvider<List<Specialist>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.specialistsStream();
});
