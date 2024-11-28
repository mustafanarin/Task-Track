import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/firebase_options.dart'; 

@immutable
final class ApplicationStart {
  static Future<void> init() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();

      // Check if Firebase is started
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.android,
        );
      } else {
        Firebase.app(); // Use existing instance
      }

      // Set device orientation preferences
      await _setPreferredOrientations();
    } catch (e) {
      debugPrint('Initialization Error: $e');
      rethrow;
    }
  }

  static Future<void> _setPreferredOrientations() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}