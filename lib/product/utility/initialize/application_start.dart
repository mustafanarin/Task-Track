import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/firebase_options.dart'; 

@immutable
class ApplicationStart {
  const ApplicationStart._();

  static Future<void> init() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.android,
      );

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
