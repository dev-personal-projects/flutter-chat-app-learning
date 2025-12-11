import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/services/auth/auth_exceptions.dart';

class AuthService {
  //instance of FirebaseAuth and FirebaseFirestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign in method
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Update user data in the background (non-blocking)
      // Use merge: true to preserve existing fields like name, profilePicture, createdAt
      // Don't await this to avoid blocking the auth state change
      _firestore.collection("users").doc(userCredential.user?.uid).set({
        'uid': userCredential.user?.uid,
        'email': email,
        'lastActive': DateTime.now(),
        'status': 'online',
        'lastSeen': DateTime.now(),
      }, SetOptions(merge: true)).catchError((error) {
        // Log error but don't block login
        print('Error updating user data: $error');
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Convert FirebaseAuthException to user-friendly AuthException
      throw AuthErrorHandler.handleAuthException(e);
    } catch (e) {
      // Handle any other unexpected errors
      throw AuthErrorHandler.handleException(e);
    }
  }

  //signup method
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //save user info in a separate doc
      await _firestore.collection("users").doc(userCredential.user?.uid).set({
        'uid': userCredential.user?.uid,
        'email': email,
        'createdAt': DateTime.now(),
        'lastActive': DateTime.now(),
        'profilePicture': '',
        'name': '',
        'status': 'online',
        'lastSeen': DateTime.now(),
        'role': 'user',
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Convert FirebaseAuthException to user-friendly AuthException
      throw AuthErrorHandler.handleAuthException(e);
    } catch (e) {
      // Handle any other unexpected errors
      throw AuthErrorHandler.handleException(e);
    }
  }

  //sign out method
  Future<void> signOut() async {
    await _auth.signOut();
  }

  //errors
}
