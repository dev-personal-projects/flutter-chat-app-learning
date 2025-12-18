class AuthException implements Exception {
  final String message;
  final String? code;
  final bool isRetryable;

  const AuthException({
    required this.message,
    this.code,
    this.isRetryable = false,
  });

  @override
  String toString() => message;
}

class InvalidPhoneNumberException extends AuthException {
  const InvalidPhoneNumberException()
      : super(
          message: 'Invalid phone number format. Please check and try again.',
          code: 'invalid-phone-number',
          isRetryable: true,
        );
}

class NetworkException extends AuthException {
  const NetworkException()
      : super(
          message: 'Network error. Please check your connection and try again.',
          code: 'network-error',
          isRetryable: true,
        );
}

class InvalidOTPException extends AuthException {
  const InvalidOTPException()
      : super(
          message: 'Invalid verification code. Please try again.',
          code: 'invalid-verification-code',
          isRetryable: true,
        );
}

class OTPExpiredException extends AuthException {
  const OTPExpiredException()
      : super(
          message: 'Verification code has expired. Please request a new one.',
          code: 'session-expired',
          isRetryable: true,
        );
}

class TooManyAttemptsException extends AuthException {
  const TooManyAttemptsException()
      : super(
          message: 'Too many attempts. Please try again later.',
          code: 'too-many-requests',
          isRetryable: false,
        );
}

class QuotaExceededException extends AuthException {
  const QuotaExceededException()
      : super(
          message: 'SMS quota exceeded. Please try again later.',
          code: 'quota-exceeded',
          isRetryable: false,
        );
}

class AuthenticationFailedException extends AuthException {
  const AuthenticationFailedException([String? details])
      : super(
          message: details ?? 'Authentication failed. Please try again.',
          code: 'authentication-failed',
          isRetryable: true,
        );
}

class SignOutException extends AuthException {
  const SignOutException()
      : super(
          message: 'Failed to sign out. Please try again.',
          code: 'sign-out-failed',
          isRetryable: true,
        );
}

class BillingNotEnabledException extends AuthException {
  const BillingNotEnabledException()
      : super(
          message:
              'Phone authentication requires billing to be enabled in Firebase. Please enable billing in your Firebase Console.',
          code: 'billing-not-enabled',
          isRetryable: false,
        );
}
