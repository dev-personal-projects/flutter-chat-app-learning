import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/auth/auth_exceptions.dart';

enum AuthStatus {
  initial,
  sendingOTP,
  otpSent,
  verifyingOTP,
  authenticated,
  unauthenticated,
  error,
}

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  AuthStatus _status = AuthStatus.initial;
  User? _user;
  String? _verificationId;
  AuthException? _error;

  AuthStatus get status => _status;
  User? get user => _user;
  String? get verificationId => _verificationId;
  AuthException? get error => _error;
  bool get isAuthenticated => _user != null;
  bool get isLoading =>
      _status == AuthStatus.sendingOTP || _status == AuthStatus.verifyingOTP;

  AuthProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final isAuth = await _authService.isAuthenticated();
      _user = _authService.currentUser;
      _status = isAuth ? AuthStatus.authenticated : AuthStatus.unauthenticated;
      notifyListeners();

      _authService.authStateChanges().listen((user) {
        _user = user;
        _status = user != null
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated;
        notifyListeners();
      });
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> sendOTP(String phoneNumber) async {
    try {
      _status = AuthStatus.sendingOTP;
      _error = null;
      notifyListeners();

      _verificationId = await _authService.sendOTP(phoneNumber);
      _status = AuthStatus.otpSent;
      notifyListeners();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> verifyOTP(String code) async {
    if (_verificationId == null) {
      _error =
          const AuthenticationFailedException('No verification ID available');
      _status = AuthStatus.error;
      notifyListeners();
      return;
    }

    try {
      _status = AuthStatus.verifyingOTP;
      _error = null;
      notifyListeners();

      await _authService.verifyOTP(
        verificationId: _verificationId!,
        code: code,
      );

      _user = _authService.currentUser;
      _status = AuthStatus.authenticated;
      _verificationId = null;
      notifyListeners();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> signOut() async {
    try {
      _error = null;
      await _authService.signOut();
      _user = null;
      _verificationId = null;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
    } catch (e) {
      _handleError(e);
    }
  }

  void clearError() {
    _error = null;
    if (_status == AuthStatus.error) {
      _status =
          _user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  void _handleError(dynamic error) {
    _error = error is AuthException
        ? error
        : AuthenticationFailedException(error.toString());
    _status = AuthStatus.error;
    notifyListeners();
  }
}
