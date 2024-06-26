// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: '',
    appId: '1:303465566385:web:54e9a077f9ad56e77b9290',
    messagingSenderId: '303465566385',
    projectId: 'fireconnect-2ada1',
    authDomain: 'fireconnect-2ada1.firebaseapp.com',
    storageBucket: 'fireconnect-2ada1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '',
    appId: '1:303465566385:android:ea45f827b066faf97b9290',
    messagingSenderId: '303465566385',
    projectId: 'fireconnect-2ada1',
    storageBucket: 'fireconnect-2ada1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '1:303465566385:ios:c0d54434e68fe8807b9290',
    messagingSenderId: '303465566385',
    projectId: 'fireconnect-2ada1',
    storageBucket: 'fireconnect-2ada1.appspot.com',
    iosBundleId: 'com.example.practise',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '',
    appId: '1:303465566385:ios:c0d54434e68fe8807b9290',
    messagingSenderId: '303465566385',
    projectId: 'fireconnect-2ada1',
    storageBucket: 'fireconnect-2ada1.appspot.com',
    iosBundleId: 'com.example.practise',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: '',
    appId: '1:303465566385:web:39f0ce1bb76b85517b9290',
    messagingSenderId: '303465566385',
    projectId: 'fireconnect-2ada1',
    authDomain: 'fireconnect-2ada1.firebaseapp.com',
    storageBucket: 'fireconnect-2ada1.appspot.com',
  );

}
