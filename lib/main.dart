import 'package:flutter/material.dart';
import 'package:todo_app/feature/authentication/welcome_page.dart';
import 'package:todo_app/feature/splash/splash_page.dart';
import 'package:todo_app/product/theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: LightTheme().themeData,
      home: WelcomePage(),
    );
  }
}