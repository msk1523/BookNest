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
    apiKey: 'AIzaSyB08n6FuEpW64H6YE51P73s5n-JOvpcqrE',
    appId: '1:906994327000:web:df96c726658ad8cbbf66ad',
    messagingSenderId: '906994327000',
    projectId: 'booknest-f0476',
    authDomain: 'booknest-f0476.firebaseapp.com',
    storageBucket: 'booknest-f0476.firebasestorage.app',
    measurementId: 'G-1R5MVEVM2H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCK7gN0DNeHmrVDWL_qoPkVj084Ojfs2_I',
    appId: '1:906994327000:android:98b91ca3f9eba597bf66ad',
    messagingSenderId: '906994327000',
    projectId: 'booknest-f0476',
    storageBucket: 'booknest-f0476.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDqrn3XDgH7KMuJeBQLIhB5BsuVUxrjT8U',
    appId: '1:906994327000:ios:00e56e85edde044bbf66ad',
    messagingSenderId: '906994327000',
    projectId: 'booknest-f0476',
    storageBucket: 'booknest-f0476.firebasestorage.app',
    iosBundleId: 'com.example.boookie',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDqrn3XDgH7KMuJeBQLIhB5BsuVUxrjT8U',
    appId: '1:906994327000:ios:00e56e85edde044bbf66ad',
    messagingSenderId: '906994327000',
    projectId: 'booknest-f0476',
    storageBucket: 'booknest-f0476.firebasestorage.app',
    iosBundleId: 'com.example.boookie',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB08n6FuEpW64H6YE51P73s5n-JOvpcqrE',
    appId: '1:906994327000:web:eb8fd0a2b098c3a6bf66ad',
    messagingSenderId: '906994327000',
    projectId: 'booknest-f0476',
    authDomain: 'booknest-f0476.firebaseapp.com',
    storageBucket: 'booknest-f0476.firebasestorage.app',
    measurementId: 'G-V33M6LRBMQ',
  );
}
