import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/components/otp_input.dart';
import 'package:chatapp/constant/app_colors.dart';
import 'package:chatapp/constant/app_typography.dart';
import 'package:chatapp/services/auth/auth_provider.dart';
import 'package:chatapp/services/auth/auth_exceptions.dart';
import 'package:chatapp/pages/home_page.dart';

class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OTPVerificationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  bool _isVerifying = false;
  int _resendCooldown = 0;
  Timer? _cooldownTimer;

  @override
  void initState() {
    super.initState();
    _startResendCooldown();
  }

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    super.dispose();
  }

  void _startResendCooldown() {
    setState(() {
      _resendCooldown = 60;
    });
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _resendCooldown--;
      });
      if (_resendCooldown <= 0) {
        timer.cancel();
      }
    });
  }

  Future<void> _handleOTPComplete(String code) async {
    if (_isVerifying) return;
    setState(() {
      _isVerifying = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.verifyOTP(code);
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() {
        _isVerifying = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Theme.of(context).colorScheme.error,
          action: e.isRetryable
              ? SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: () {},
                )
              : null,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isVerifying = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: ${e.toString()}'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  Future<void> _handleResendOTP() async {
    if (_resendCooldown > 0) return;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.sendOTP(widget.phoneNumber);
      if (!mounted) return;
      _startResendCooldown();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New code sent successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  String _formatPhoneForDisplay(String phone) {
    final withoutPlus = phone.replaceFirst('+', '');
    if (withoutPlus.length > 3) {
      final countryCode = withoutPlus.substring(0, 1);
      final number = withoutPlus.substring(1);
      return '+$countryCode $number';
    }
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final authProvider = Provider.of<AuthProvider>(context);
    final isLoading = authProvider.isLoading || _isVerifying;
    final canResend = _resendCooldown == 0 && !isLoading;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Enter verification code',
          style: AppTypography.titleLarge(
            color: textColor,
            fontWeight: AppTypography.fontWeightBold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We\'ve sent a verification code to',
                style: AppTypography.bodyMedium(
                  color: textColor.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _formatPhoneForDisplay(widget.phoneNumber),
                style: AppTypography.bodyLarge(
                  color: textColor,
                  fontWeight: AppTypography.fontWeightMedium,
                ),
              ),
              const SizedBox(height: 32),
              OTPInput(
                onCompleted: _handleOTPComplete,
                autofocus: true,
              ),
              const SizedBox(height: 32),
              if (isLoading) ...[
                const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 16),
              ],
              if (authProvider.error != null) ...[
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
                const SizedBox(height: 16),
              ],
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Didn\'t receive the code?',
                      style: AppTypography.bodyMedium(
                        color: textColor.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: canResend ? _handleResendOTP : null,
                      child: Text(
                        _resendCooldown > 0
                            ? 'Resend code in ${_resendCooldown}s'
                            : 'Resend code',
                        style: AppTypography.bodyLarge(
                          color: canResend
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.3),
                          fontWeight: AppTypography.fontWeightMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
