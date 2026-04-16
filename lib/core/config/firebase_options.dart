import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return web;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxxxxxxxxxxxx', // Replace with your Firebase API key
    appId: '1:123456789012:android:abcdefghijklmnop',
    messagingSenderId: '123456789012',
    projectId: 'the-holics',
    databaseURL: 'https://the-holics.firebaseio.com',
    storageBucket: 'the-holics.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDxxxxxxxxxxxx', // Replace with your Firebase API key
    appId: '1:123456789012:ios:abcdefghijklmnop',
    messagingSenderId: '123456789012',
    projectId: 'the-holics',
    databaseURL: 'https://the-holics.firebaseio.com',
    storageBucket: 'the-holics.appspot.com',
    iosBundleId: 'com.example.theHolics',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDxxxxxxxxxxxx', // Replace with your Firebase API key
    appId: '1:123456789012:macos:abcdefghijklmnop',
    messagingSenderId: '123456789012',
    projectId: 'the-holics',
    databaseURL: 'https://the-holics.firebaseio.com',
    storageBucket: 'the-holics.appspot.com',
    iosBundleId: 'com.example.theHolics',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDxxxxxxxxxxxx', // Replace with your Firebase API key
    appId: '1:123456789012:web:abcdefghijklmnop',
    messagingSenderId: '123456789012',
    projectId: 'the-holics',
    authDomain: 'the-holics.firebaseapp.com',
    databaseURL: 'https://the-holics.firebaseio.com',
    storageBucket: 'the-holics.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDxxxxxxxxxxxx', // Replace with your Firebase API key
    appId: '1:123456789012:windows:abcdefghijklmnop',
    messagingSenderId: '123456789012',
    projectId: 'the-holics',
    authDomain: 'the-holics.firebaseapp.com',
    databaseURL: 'https://the-holics.firebaseio.com',
    storageBucket: 'the-holics.appspot.com',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyDxxxxxxxxxxxx', // Replace with your Firebase API key
    appId: '1:123456789012:linux:abcdefghijklmnop',
    messagingSenderId: '123456789012',
    projectId: 'the-holics',
    authDomain: 'the-holics.firebaseapp.com',
    databaseURL: 'https://the-holics.firebaseio.com',
    storageBucket: 'the-holics.appspot.com',
  );
}
