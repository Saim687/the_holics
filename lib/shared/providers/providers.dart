import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_holics/shared/services/auth_service.dart';
import 'package:the_holics/shared/services/firestore_service.dart';
import 'package:the_holics/shared/services/storage_service.dart';
import 'package:the_holics/shared/services/fcm_service.dart';

// Service providers
final authServiceProvider = Provider((ref) => AuthService());
final firestoreServiceProvider = Provider((ref) => FirestoreService());
final storageServiceProvider = Provider((ref) => StorageService());
final fcmServiceProvider = Provider((ref) => FCMService());

// Auth state stream
final authStateChangesProvider = StreamProvider((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

// Current user ID
final currentUserIdProvider = Provider((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.currentUser?.uid;
});
