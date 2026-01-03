import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chatapp/services/auth/auth_exceptions.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw const AuthenticationFailedException();
    }
  }

  Future<UserCredential> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw const AuthenticationFailedException();
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const GoogleSignInCancelledException();
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthenticationFailedException(e.toString());
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
      // Best-effort cleanup across providers
      await _googleSignIn.signOut();
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
      case 'invalid-email':
        return const InvalidEmailException();
      case 'user-not-found':
        return const UserNotFoundException();
      case 'wrong-password':
        return const WrongPasswordException();
      case 'email-already-in-use':
        return const EmailAlreadyInUseException();
      case 'weak-password':
        return const WeakPasswordException();
      case 'account-exists-with-different-credential':
        return const AccountExistsWithDifferentCredentialException();
      default:
        return AuthenticationFailedException(e.message);
    }
  }
}
