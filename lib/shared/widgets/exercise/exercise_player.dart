import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:the_holics/core/theme/app_theme.dart';

class ExercisePlayer extends StatelessWidget {
  final String animationName;
  final double aspectRatio;
  final bool repeat;

  const ExercisePlayer({
    super.key,
    required this.animationName,
    this.aspectRatio = 1,
    this.repeat = true,
  });

  @override
  Widget build(BuildContext context) {
    final shouldAnimate =
        TickerMode.of(context) && !Scrollable.recommendDeferredLoadingForContext(context);

    return RepaintBoundary(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Lottie.asset(
          'assets/animations/$animationName.json',
          fit: BoxFit.contain,
          repeat: repeat,
          animate: shouldAnimate,
          delegates: LottieDelegates(
            values: [
              // Keep default colors unless explicitly overridden for performance stability.
            ],
          ),
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppTheme.surfaceCard,
              alignment: Alignment.center,
              child: const Icon(
                Icons.fitness_center,
                color: AppTheme.textSecondary,
                size: 28,
              ),
            );
          },
        ),
      ),
    );
  }
}
