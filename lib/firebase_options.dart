import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'dart:io' show Platform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (Platform.isAndroid) {
      return android;
    } else if (Platform.isIOS) {
      return ios;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  // Get these values from your google-services.json (Android)
  // Update with your actual Firebase project credentials
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_2713VMLc_F4KIda2Zicf2hv18boHxc0',
    appId: '1:207477043010:android:2f0cf0ce2f7a02ed8322db',
    messagingSenderId: '207477043010',
    projectId: 'esprots-7a3ce',
    storageBucket: 'esprots-7a3ce.firebasestorage.app',
  );

  // Get these values from your GoogleService-Info.plist (iOS)
  // Update with your actual Firebase project credentials
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_2713VMLc_F4KIda2Zicf2hv18boHxc0',
    appId: '1:207477043010:ios:2f0cf0ce2f7a02ed8322db',
    messagingSenderId: '207477043010',
    projectId: 'esprots-7a3ce',
    storageBucket: 'esprots-7a3ce.firebasestorage.app',
    iosBundleId: 'com.example.esports',
  );
}
