import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyA-MaGC0e1oNQcRHEOGHtvuf5xi6p2w1M8",
      projectId: "cricscore-13e7c",
      storageBucket: "cricscore-13e7c.firebasestorage.app",
      appId: '1:16799941324:android:efed1ff166e9fcca98f869',
      messagingSenderId: '16799941324',
    ));
  } else {
    await Firebase.initializeApp();
  }
}
