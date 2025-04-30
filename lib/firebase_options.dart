
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
    apiKey: 'AIzaSyDFxK9u-t2tTaPxLPtI87oWfhzTMTl0pWQ',
    appId: '1:855099095971:web:c8bb4441507de59ed27816',
    messagingSenderId: '855099095971',
    projectId: 'aimswasthya-4f879',
    authDomain: 'aimswasthya-4f879.firebaseapp.com',
    storageBucket: 'aimswasthya-4f879.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCaFBrLaqWqXNhjPzXEXXu71n7WAPShLCY',
    appId: '1:855099095971:android:c0576a8e0c813453d27816',
    messagingSenderId: '855099095971',
    projectId: 'aimswasthya-4f879',
    storageBucket: 'aimswasthya-4f879.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOrzOmoZfXIvKzZ3T_7vL3L_cvg0ydrWE',
    appId: '1:855099095971:ios:9a1fae78339464c8d27816',
    messagingSenderId: '855099095971',
    projectId: 'aimswasthya-4f879',
    storageBucket: 'aimswasthya-4f879.firebasestorage.app',
    iosBundleId: 'com.aimswasthya',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOrzOmoZfXIvKzZ3T_7vL3L_cvg0ydrWE',
    appId: '1:855099095971:ios:9a1fae78339464c8d27816',
    messagingSenderId: '855099095971',
    projectId: 'aimswasthya-4f879',
    storageBucket: 'aimswasthya-4f879.firebasestorage.app',
    iosBundleId: 'com.aimswasthya',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDFxK9u-t2tTaPxLPtI87oWfhzTMTl0pWQ',
    appId: '1:855099095971:web:f3349dc44f37642ad27816',
    messagingSenderId: '855099095971',
    projectId: 'aimswasthya-4f879',
    authDomain: 'aimswasthya-4f879.firebaseapp.com',
    storageBucket: 'aimswasthya-4f879.firebasestorage.app',
  );

}