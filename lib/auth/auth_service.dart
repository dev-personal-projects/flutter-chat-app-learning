import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in method
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code == 'user-not-found'
          ? 'User not found'
          : 'Something went wrong');
    }
  }

  //signup method

  //sign out method
  Future<void> signOut() async {
    await _auth.signOut();
  }

  //errors
}
