import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/components/country_selector.dart';
import 'package:chatapp/components/phone_number_input.dart';
import 'package:chatapp/constant/app_colors.dart';
import 'package:chatapp/constant/app_typography.dart';
import 'package:chatapp/services/auth/auth_provider.dart';
import 'package:chatapp/services/auth/auth_exceptions.dart';
import 'package:chatapp/utils/app_routes.dart';
import 'package:chatapp/utils/phone_formatter.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController _phoneController = TextEditingController();
  Country _selectedCountry = Country.parse('US');
  bool _isPhoneValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhoneNumber);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _validatePhoneNumber() {
    final isValid = PhoneFormatter.isValidPhoneNumber(
      _phoneController.text,
      _selectedCountry,
    );
    if (_isPhoneValid != isValid) {
      setState(() {
        _isPhoneValid = isValid;
      });
    }
  }

  void _onCountrySelected(Country country) {
    setState(() {
      _selectedCountry = country;
    });
    _validatePhoneNumber();
  }

  Future<void> _handleDone() async {
    final formattedPhone = PhoneFormatter.formatPhoneNumber(
      _phoneController.text,
      _selectedCountry,
    );
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.sendOTP(formattedPhone);
      if (!mounted) return;
      AppRoutes.navigateToOTPVerification(context, phoneNumber: formattedPhone);
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Theme.of(context).colorScheme.error,
          action: e.code == 'billing-not-enabled'
              ? SnackBarAction(
                  label: 'Use Email',
                  textColor: Colors.white,
                  onPressed: () => AppRoutes.navigateToEmailAuth(context),
                )
              : (e.isRetryable
                  ? SnackBarAction(
                      label: 'Retry',
                      textColor: Colors.white,
                      onPressed: () => _handleDone(),
                    )
                  : null),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: ${e.toString()}'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
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
    final canSubmit = _isPhoneValid && !isLoading;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Phone number',
          style: AppTypography.titleLarge(
            color: textColor,
            fontWeight: AppTypography.fontWeightBold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: canSubmit ? _handleDone : null,
            child: Text(
              'Done',
              style: AppTypography.bodyLarge(
                color: canSubmit
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.3),
                fontWeight: AppTypography.fontWeightMedium,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please confirm your country code and enter your phone number',
                style: AppTypography.bodyMedium(
                  color: textColor.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 24),
              CountrySelector(
                country: _selectedCountry,
                onCountrySelected: _onCountrySelected,
              ),
              const SizedBox(height: 16),
              PhoneNumberInput(
                controller: _phoneController,
                country: _selectedCountry,
                autofocus: true,
                placeholder: 'phone number',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: colorScheme.onSurface.withValues(alpha: 0.15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR',
                      style: AppTypography.labelMedium(
                        color: textColor.withValues(alpha: 0.6),
                        fontWeight: AppTypography.fontWeightSemiBold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: colorScheme.onSurface.withValues(alpha: 0.15),
                    ),
                  ),
                ],
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
              if (isLoading) ...[
                const SizedBox(height: 24),
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
