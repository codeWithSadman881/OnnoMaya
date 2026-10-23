import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyCS3tEYl6SuoLDlV0Z_pri78t5H4mNIGAg",
    appId: '1:466214595850:web:fd8e762edd8ca7531b9ef3',
    messagingSenderId: '466214595850',
    projectId: 'onnomaya-c40b6',
    authDomain: 'onnomaya-c40b6.firebaseapp.com',
    storageBucket: 'onnomaya-c40b6.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyCS3tEYl6SuoLDlV0Z_pri78t5H4mNIGAg",
    appId: '1:466214595850:web:fd8e762edd8ca7531b9ef3',
    messagingSenderId: '466214595850',
    projectId: 'onnomaya-c40b6',
    storageBucket: 'onnomaya-c40b6.firebasestorage.app',
  );
}