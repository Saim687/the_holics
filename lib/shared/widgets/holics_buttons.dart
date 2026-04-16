import 'package:flutter/material.dart';
import 'package:the_holics/core/theme/app_theme.dart';

class HolicsButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isSecondary;
  final bool isSmall;

  const HolicsButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isSecondary = false,
    this.isSmall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    if (isSecondary) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size(isMobile ? double.infinity : 150, isSmall ? 44 : 56),
          side: const BorderSide(color: AppTheme.borderColor),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(label),
      );
    }

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(isMobile ? double.infinity : 150, isSmall ? 44 : 56),
        backgroundColor: AppTheme.bodyHolicsOrange,
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(label),
    );
  }
}

class HolicsPinkButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isSmall;

  const HolicsPinkButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isSmall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(isMobile ? double.infinity : 150, isSmall ? 44 : 56),
        backgroundColor: AppTheme.skinHolichPink,
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(label),
    );
  }
}
