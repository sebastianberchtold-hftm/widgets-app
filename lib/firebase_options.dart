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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCllESMrE1R3Z04-btneRZsBVWyapQkdPM',
    appId: '1:532331276793:web:6752433d95a7e2b240b528',
    messagingSenderId: '532331276793',
    projectId: 'blog-app-7daf2',
    authDomain: 'blog-app-7daf2.firebaseapp.com',
    storageBucket: 'blog-app-7daf2.appspot.com',
    measurementId: 'G-4BC9W7S1D0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDekGPiUDaV_KhbFtgaaL-0Ac9z64quEd8',
    appId: '1:532331276793:android:fc80de6934e1635e40b528',
    messagingSenderId: '532331276793',
    projectId: 'blog-app-7daf2',
    storageBucket: 'blog-app-7daf2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgZ4wxrAXUnd4BJIi-OxO7HjO-6_ICQcE',
    appId: '1:532331276793:ios:bc12aaef5494c55740b528',
    messagingSenderId: '532331276793',
    projectId: 'blog-app-7daf2',
    storageBucket: 'blog-app-7daf2.appspot.com',
    iosBundleId: 'com.example.uiControlsDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgZ4wxrAXUnd4BJIi-OxO7HjO-6_ICQcE',
    appId: '1:532331276793:ios:bc12aaef5494c55740b528',
    messagingSenderId: '532331276793',
    projectId: 'blog-app-7daf2',
    storageBucket: 'blog-app-7daf2.appspot.com',
    iosBundleId: 'com.example.uiControlsDemo',
  );
}
