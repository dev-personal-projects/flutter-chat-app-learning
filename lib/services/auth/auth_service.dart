import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/services/auth/auth_exceptions.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> isAuthenticated() async {
    return _firebaseAuth.currentUser != null;
  }

  Future<String> sendOTP(String phoneNumber) async {
    try {
      final completer = Completer<String>();

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) {
          completer.complete(credential.verificationId);
        },
        verificationFailed: (e) {
          completer.completeError(e);
        },
        codeSent: (verificationId, _) {
          completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          if (!completer.isCompleted) {
            completer.complete(verificationId);
          }
        },
        timeout: const Duration(seconds: 60),
      );

      return await completer.future;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw const NetworkException();
    }
  }

  Future<UserCredential> verifyOTP({
    required String verificationId,
    required String code,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );
      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw const AuthenticationFailedException();
    }
  }

  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw const SignOutException();
    }
  }

  User? get currentUser => _firebaseAuth.currentUser;

  AuthException _handleAuthException(FirebaseAuthException e) {
    final errorMessage = e.message ?? '';

    if (errorMessage.contains('BILLING_NOT_ENABLED') ||
        errorMessage.contains('billing') &&
            errorMessage.contains('not enabled')) {
      return const BillingNotEnabledException();
    }

    switch (e.code) {
      case 'invalid-phone-number':
        return const InvalidPhoneNumberException();
      case 'too-many-requests':
        return const TooManyAttemptsException();
      case 'invalid-verification-code':
        return const InvalidOTPException();
      case 'session-expired':
        return const OTPExpiredException();
      case 'quota-exceeded':
        return const QuotaExceededException();
      case 'network-request-failed':
        return const NetworkException();
      default:
        return AuthenticationFailedException(e.message);
    }
  }
}
