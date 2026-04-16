import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_holics/shared/models/subscription_model.dart';
import 'package:the_holics/shared/providers/providers.dart';

final subscriptionProvider = StreamProvider.family<List<Subscription>, String>((ref, uid) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.subscriptionStream(uid);
});

final currentUserSubscriptionProvider = StreamProvider<Subscription?>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  if (uid == null) return Stream.value(null);
  return ref.watch(subscriptionProvider(uid)).when(
        data: (subscriptions) =>
            Stream.value(_pickCurrentSubscription(subscriptions)),
        loading: () => Stream.value(null),
        error: (error, stack) => Stream.error(error),
      );
});

final currentUserHasActiveSubscriptionProvider = StreamProvider<bool>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  if (uid == null) return Stream.value(false);
  return ref.watch(subscriptionProvider(uid)).when(
        data: (subscriptions) =>
            Stream.value(subscriptions.any((s) => s.isActive)),
        loading: () => Stream.value(false),
        error: (error, stack) => Stream.error(error),
      );
});

// All subscriptions for admin
final allSubscriptionsProvider = FutureProvider<List<Subscription>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getAllSubscriptions();
});

Subscription? _pickCurrentSubscription(List<Subscription> subscriptions) {
  if (subscriptions.isEmpty) return null;

  final sorted = [...subscriptions]
    ..sort((a, b) => b.endDate.compareTo(a.endDate));

  for (final subscription in sorted) {
    if (subscription.isActive) {
      return subscription;
    }
  }

  return sorted.first;
}
