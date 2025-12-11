import 'package:firebase_auth/firebase_auth.dart';

/// Custom exception class for authentication errors with user-friendly messages
class AuthException implements Exception {
  final String message;
  final String? code;

  AuthException(this.message, {this.code});

  @override
  String toString() => message;
}

/// Helper class to convert FirebaseAuthException to user-friendly messages
class AuthErrorHandler {
  /// Converts FirebaseAuthException to a user-friendly error message
  static AuthException handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      // Sign in errors
      case 'user-not-found':
        return AuthException(
          'No account found with this email address. Please check your email or sign up.',
          code: e.code,
        );
      case 'wrong-password':
        return AuthException(
          'Incorrect password. Please try again or reset your password.',
          code: e.code,
        );
      case 'invalid-email':
        return AuthException(
          'The email address is not valid. Please check and try again.',
          code: e.code,
        );
      case 'user-disabled':
        return AuthException(
          'This account has been disabled. Please contact support.',
          code: e.code,
        );
      case 'too-many-requests':
        return AuthException(
          'Too many failed login attempts. Please try again later or reset your password.',
          code: e.code,
        );
      case 'operation-not-allowed':
        return AuthException(
          'This sign-in method is not enabled. Please contact support.',
          code: e.code,
        );

      // Sign up errors
      case 'email-already-in-use':
        return AuthException(
          'An account with this email already exists. Please sign in instead.',
          code: e.code,
        );
      case 'weak-password':
        return AuthException(
          'Password is too weak. Please use at least 6 characters.',
          code: e.code,
        );
      case 'invalid-credential':
        return AuthException(
          'The email or password is incorrect. Please check and try again.',
          code: e.code,
        );

      // Network errors
      case 'network-request-failed':
        return AuthException(
          'Network error. Please check your internet connection and try again.',
          code: e.code,
        );

      // Generic errors
      default:
        return AuthException(
          'An unexpected error occurred: ${e.message ?? "Please try again"}',
          code: e.code,
        );
    }
  }

  /// Handles generic exceptions and converts them to AuthException
  static AuthException handleException(dynamic e) {
    if (e is FirebaseAuthException) {
      return handleAuthException(e);
    } else if (e is AuthException) {
      return e;
    } else {
      return AuthException(
        'An unexpected error occurred. Please try again.',
      );
    }
  }
}
