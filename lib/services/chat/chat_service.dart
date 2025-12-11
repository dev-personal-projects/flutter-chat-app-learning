import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //instance of FirebaseFirestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Gets a real-time stream of all users in the chat application.
  ///
  /// Returns a [Stream] that emits a [List] of user data maps.
  /// Each map in the list represents a user and contains:
  /// - `String` keys (e.g., 'name', 'email', 'profilePicture', 'uid')
  /// - `dynamic` values (can be String, int, bool, etc.)
  ///
  /// The stream updates in real-time whenever user data changes in Firestore,
  /// allowing the UI to automatically reflect changes without manual refresh.
  ///
  /// Example usage:
  /// ```dart
  /// StreamBuilder<List<Map<String, dynamic>>>(
  ///   stream: chatService.getUserStream(),
  ///   builder: (context, snapshot) {
  ///     if (snapshot.hasData) {
  ///       final users = snapshot.data!;
  ///       return ListView.builder(
  ///         itemCount: users.length,
  ///         itemBuilder: (context, index) {
  ///           final user = users[index];
  ///           return Text(user['name'] ?? 'Unknown');
  ///         },
  ///       );
  ///     }
  ///     return CircularProgressIndicator();
  ///   },
  /// )
  /// ```
  ///
  /// Return type: `Stream<List<Map<String, dynamic>>>`
  /// - `Stream`: Provides asynchronous data that updates over time
  /// - `List`: Collection of multiple user objects
  /// - `Map<String, dynamic>`: Each user is represented as a map with string keys and dynamic values
  Stream<List<Map<String, dynamic>>> getUserStream() {
    // Get current user ID reactively - check it each time the stream emits
    return _firestore.collection("users").snapshots().map((snapshot) {
      // Get current user ID each time the stream emits (reactive)
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;

      // Convert each document snapshot to a map of user data
      // Filter out the current user from the list
      final users = snapshot.docs.where((doc) {
        // Exclude current user and ensure document has data
        if (doc.id == currentUserId) return false;
        if (!doc.exists) return false;
        return true;
      }).map((doc) {
        final user = doc.data();
        // Ensure uid is included in the user data
        user['uid'] = doc.id;
        return user;
      }).toList();

      return users;
    });
  }

//send message

//get messages

//get message stream

//get message by id

//delete message
}
