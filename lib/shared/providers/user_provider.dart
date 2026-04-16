import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_holics/shared/models/user_model.dart';
import 'package:the_holics/shared/providers/providers.dart';

final userProvider =
    StreamProvider.family<User?, String>((ref, uid) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.userStream(uid);
});

final currentUserProvider = StreamProvider<User?>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  if (uid == null) return Stream.value(null);
  return ref.watch(userProvider(uid)).when(
        data: (user) => Stream.value(user),
        loading: () => Stream.value(null),
        error: (error, stack) => Stream.error(error),
      );
});

// Computed provider for user role
final userRoleProvider = Provider<String?>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.maybeWhen(
    data: (user) => user?.role,
    orElse: () => null,
  );
});

// User list for admin
final allUsersProvider = FutureProvider<List<User>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getAllUsers();
});
