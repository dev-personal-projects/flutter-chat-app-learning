import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCs5SbmEEPLlQLkVgAi1ZHBuQktrxlALMs',
    appId: '1:604006245237:android:3382e9175e3b53a729a93c',
    messagingSenderId: '604006245237',
    projectId: 'socialmediaapp-f53e8',
    storageBucket: 'socialmediaapp-f53e8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCs5SbmEEPLlQLkVgAi1ZHBuQktrxlALMs',
    appId: '1:604006245237:ios:3382e9175e3b53a729a93c',
    messagingSenderId: '604006245237',
    projectId: 'socialmediaapp-f53e8',
    storageBucket: 'socialmediaapp-f53e8.firebasestorage.app',
    iosBundleId: 'com.example.chatapp',
  );
}
