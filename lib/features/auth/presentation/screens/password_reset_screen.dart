import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:the_holics/core/theme/app_theme.dart';
import 'package:the_holics/core/constants/app_constants.dart';
import 'package:the_holics/shared/widgets/holics_buttons.dart';
import 'package:the_holics/shared/widgets/common_widgets.dart';
import 'package:the_holics/shared/providers/providers.dart';

class PasswordResetScreen extends ConsumerStatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PasswordResetScreen> createState() =>
      _PasswordResetScreenState();
}

class _PasswordResetScreenState extends ConsumerState<PasswordResetScreen> {
  late TextEditingController _emailController;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    if (_emailController.text.isEmpty) {
      setState(() => _errorMessage = 'Please enter your email');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final authService = ref.read(authServiceProvider);
      await authService.sendPasswordResetEmail(_emailController.text.trim());

      setState(() =>
          _successMessage =
              'Password reset link sent to ${_emailController.text}');
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Reset Password'),
        backgroundColor: AppTheme.darkBg,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forgot your password?',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your email address and we\'ll send you a link to reset your password.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
            const SizedBox(height: 32),

            // Email field
            HolicsTextField(
              label: 'Email',
              placeholder: AppStrings.emailPlaceholder,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),

            // Error message
            if (_errorMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.errorRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.errorRed),
                ),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: AppTheme.errorRed,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Success message
            if (_successMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.successGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.successGreen),
                ),
                child: Text(
                  _successMessage!,
                  style: const TextStyle(
                    color: AppTheme.successGreen,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Send reset button
            HolicsButton(
              label: AppStrings.sendReset,
              isLoading: _isLoading,
              onPressed: _handleReset,
            ),
            const SizedBox(height: 16),

            // Back to login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Remember your password?',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: AppTheme.bodyHolicsOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
