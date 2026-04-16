import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:the_holics/core/theme/app_theme.dart';
import 'package:the_holics/shared/providers/providers.dart';
import 'package:the_holics/shared/providers/content_provider.dart';
import 'package:the_holics/shared/providers/subscription_provider.dart';

class BodyHolicsNutritionScreen extends ConsumerWidget {
  const BodyHolicsNutritionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(currentUserIdProvider);
    final firestore = ref.watch(firestoreServiceProvider);
    final hasActiveSubscriptionAsync =
        ref.watch(currentUserHasActiveSubscriptionProvider);

    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: const Text('Body Holics Nutrition'),
        backgroundColor: AppTheme.darkBg,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -90,
            right: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.bodyHolicsOrange.withOpacity(0.10),
              ),
            ),
          ),
          Positioned(
            bottom: -130,
            left: -90,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.skinHolichPink.withOpacity(0.06),
              ),
            ),
          ),
          uid == null
          ? const Center(
              child: Text(
                'Please sign in first.',
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            )
          : StreamBuilder<Map<String, dynamic>?>(
              stream: firestore.userSubscriptionRequestStream(uid),
              builder: (context, subSnap) {
                final requestStatus =
                    (subSnap.data?['status']?.toString().toLowerCase() ?? 'inactive');
                final isActive = hasActiveSubscriptionAsync.maybeWhen(
                  data: (isActive) => isActive,
                  orElse: () => false,
                );

                if (!isActive) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: _StaggerReveal(
                        delayFactor: 0.10,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceCard,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppTheme.borderColor),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.lock, color: AppTheme.textSecondary, size: 40),
                              const Gap(12),
                              Text(
                                requestStatus == 'pending'
                                    ? 'Your subscription is pending admin approval.'
                                    : 'You need an active subscription to access nutrition plans.',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: AppTheme.textSecondary),
                              ),
                              const Gap(16),
                              ElevatedButton(
                                onPressed: () => context.pop(),
                                child: const Text('Back to Body Holics'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                final nutritionAsync = ref.watch(nutritionPlansProvider);
                return nutritionAsync.when(
                  data: (items) {
                    if (items.isEmpty) {
                      return const Center(
                        child: Text(
                          'No nutrition plans available yet.',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                      );
                    }

                    return ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _StaggerReveal(
                          delayFactor: 0.06,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF2A190D), Color(0xFF171717)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppTheme.bodyHolicsOrange.withOpacity(0.24),
                              ),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nutrition Hub',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                Gap(4),
                                Text(
                                  'Meal plans and dietary guidance to support your fitness goals.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(12),
                        ...items.asMap().entries.map((entry) {
                          final index = entry.key;
                          final n = entry.value;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: _StaggerReveal(
                              delayFactor: (0.10 + (index * 0.05)).clamp(0.10, 0.80),
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [AppTheme.surfaceCard, Color(0xFF1A1A1A)],
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: AppTheme.borderColor),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.restaurant,
                                            color: AppTheme.bodyHolicsOrange),
                                        Gap(8),
                                        Text(
                                          'Nutrition Plan',
                                          style: TextStyle(
                                            color: AppTheme.textSecondary,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(8),
                                    Text(
                                      n.title,
                                      style: const TextStyle(
                                        color: AppTheme.textPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Gap(6),
                                    Text(
                                      n.description,
                                      style: const TextStyle(
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(
                    child: Text(
                      e.toString(),
                      style: const TextStyle(color: AppTheme.textSecondary),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _StaggerReveal extends StatelessWidget {
  final Widget child;
  final double delayFactor;

  const _StaggerReveal({
    required this.child,
    required this.delayFactor,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      builder: (context, value, widgetChild) {
        final progress = Interval(delayFactor, 1.0, curve: Curves.easeOutCubic)
            .transform(value.clamp(0.0, 1.0));
        return Opacity(
          opacity: progress,
          child: Transform.translate(
            offset: Offset(0, (1 - progress) * 18),
            child: widgetChild,
          ),
        );
      },
      child: child,
    );
  }
}
