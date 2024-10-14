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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  // static const FirebaseOptions android = FirebaseOptions(
  //   apiKey: 'AIzaSyCOFAyzxuaioJqK-QqJEF6-Rkw_BC7JkGg',
  //   appId: '1:1268217098:ios:c5764d6f1013977f0e36f3',
  //   messagingSenderId: '1268217098',
  //   projectId: 'pictoapp-edcf7',
  //   storageBucket: 'pictoapp-edcf7.appspot.com',
  // );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOFAyzxuaioJqK-QqJEF6-Rkw_BC7JkGg',
    appId: '1:1268217098:ios:c5764d6f1013977f0e36f3',
    messagingSenderId: '1268217098',
    projectId: 'pictoapp-edcf7',
    storageBucket: 'pictoapp-edcf7.appspot.com',
    iosBundleId: 'com.example.pictoapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCOFAyzxuaioJqK-QqJEF6-Rkw_BC7JkGg',
    appId: '1:1268217098:ios:c5764d6f1013977f0e36f3',
    messagingSenderId: '1268217098',
    projectId: 'pictoapp-edcf7',
    storageBucket: 'pictoapp-edcf7.appspot.com',
    iosBundleId: 'com.example.pictoapp',
  );
}
