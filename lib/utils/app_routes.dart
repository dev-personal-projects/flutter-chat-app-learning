import 'package:flutter/material.dart';
import 'package:chatapp/pages/phone_number_page.dart';
import 'package:chatapp/pages/otp_verification_page.dart';
import 'package:chatapp/pages/email_auth_page.dart';
import 'package:chatapp/pages/sign_in_page.dart';

/// Centralized route management for the application
///
/// This class provides:
/// - Route name constants (to avoid typos and ensure consistency)
/// - Route generation function (returns all app routes)
/// - Type-safe route navigation helpers
///
/// Benefits:
/// - Single source of truth for all routes
/// - Easy to maintain and update
/// - Prevents route name typos
/// - Better code organization
class AppRoutes {
  // Route name constants
  // Using static const to ensure they're compile-time constants
  static const String phoneNumber = '/phone-number';
  static const String otpVerification = '/otp-verification';
  static const String emailAuth = '/email-auth';
  static const String signIn = '/sign-in';

  // Private constructor to prevent instantiation
  // This is a utility class with only static members
  AppRoutes._();

  /// Generates all application routes
  ///
  /// Returns a Map of route names to route builders.
  /// This method is called in MaterialApp's routes parameter.
  ///
  /// Route builders handle:
  /// - Creating the appropriate page widget
  /// - Extracting and passing route arguments
  /// - Handling edge cases (missing arguments, etc.)
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      signIn: (context) => const SignInPage(),
      phoneNumber: (context) => const PhoneNumberPage(),
      otpVerification: (context) {
        // Extract phone number from route arguments
        final args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        final phoneNumber = args?['phoneNumber'] as String? ?? '';

        // Return OTP verification page with phone number
        return OTPVerificationPage(phoneNumber: phoneNumber);
      },
      emailAuth: (context) => const EmailAuthPage(),
    };
  }

  /// Helper method to navigate to phone number page
  ///
  /// Usage:
  /// ```dart
  /// AppRoutes.navigateToPhoneNumber(context);
  /// ```
  static void navigateToPhoneNumber(BuildContext context) {
    Navigator.pushNamed(context, phoneNumber);
  }

  static void navigateToSignIn(BuildContext context) {
    Navigator.pushNamed(context, signIn);
  }

  /// Helper method to navigate to OTP verification page
  ///
  /// Usage:
  /// ```dart
  /// AppRoutes.navigateToOTPVerification(context, phoneNumber: '+1234567890');
  /// ```
  static void navigateToOTPVerification(
    BuildContext context, {
    required String phoneNumber,
  }) {
    Navigator.pushNamed(
      context,
      otpVerification,
      arguments: {'phoneNumber': phoneNumber},
    );
  }

  /// Helper method to navigate to email auth page
  static void navigateToEmailAuth(BuildContext context) {
    Navigator.pushNamed(context, emailAuth);
  }
}
