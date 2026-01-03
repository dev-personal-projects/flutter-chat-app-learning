import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chatapp/components/google_sign_in_button.dart';
import 'package:chatapp/constant/app_colors.dart';
import 'package:chatapp/constant/app_typography.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/services/auth/auth_provider.dart';
import 'package:chatapp/utils/app_routes.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.clearError();

    await authProvider.signInWithGoogle();
    if (!context.mounted) return;

    if (authProvider.isAuthenticated) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;

    final authProvider = Provider.of<AuthProvider>(context);
    final isLoading = authProvider.isLoading;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Sign in',
          style: AppTypography.titleLarge(
            color: textColor,
            fontWeight: AppTypography.fontWeightBold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose a sign-in method',
                style: AppTypography.bodyMedium(
                  color: textColor.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: isLoading
                      ? null
                      : () => AppRoutes.navigateToPhoneNumber(context),
                  icon: const Icon(Icons.phone_iphone),
                  label: const Text('Continue with Phone'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () => AppRoutes.navigateToEmailAuth(context),
                  icon: const Icon(Icons.email_outlined),
                  label: const Text('Continue with Email'),
                ),
              ),
              const SizedBox(height: 12),
              GoogleSignInButton(
                isLoading:
                    authProvider.status == AuthStatus.signingInWithGoogle,
                onPressed: () => _handleGoogleSignIn(context),
              ),
              if (isLoading) ...[
                const SizedBox(height: 16),
                const Center(child: CircularProgressIndicator()),
              ],
              if (authProvider.error != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: colorScheme.error,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          authProvider.error!.message,
                          style: AppTypography.bodySmall(
                            color: colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
