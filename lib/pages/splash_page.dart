import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/components/whatsapp_logo.dart';
import 'package:chatapp/constant/app_colors.dart';
import 'package:chatapp/constant/app_typography.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/pages/sign_in_page.dart';
import 'package:chatapp/services/auth/auth_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2, milliseconds: 500));

    if (!mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    while (authProvider.status == AuthStatus.initial && mounted) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    if (!mounted) return;

    final isAuthenticated = authProvider.isAuthenticated;

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isAuthenticated ? const HomePage() : const SignInPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final Color backgroundColor =
        isDarkMode ? AppColors.darkBackground : AppColors.lightBackground;

    final Color textColor =
        isDarkMode ? AppColors.secondaryTeal200 : AppColors.secondaryTeal300;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            const Center(
              child: WhatsappLogo(size: 120.0),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'from',
                    style: AppTypography.bodySmall(
                      color: textColor.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'FACEBOOK',
                    style: AppTypography.labelLarge(
                      color: textColor,
                      fontWeight: AppTypography.fontWeightBold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
