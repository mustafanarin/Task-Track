import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/product/extensions/assets/json_extension.dart';
import 'package:todo_app/product/navigate/app_router.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    if (!context.mounted) return;
   context.router.replace(const WelcomeRoute());
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(JsonItems.loot.path()),
            // Icon(
            //   Icons.check_circle_outline,
            //   size: 100,
            //   color: Colors.blue,
            // ),
            // SizedBox(height: 24),
            // Text(
            //   'Todo App',
            //   style: TextStyle(
            //     fontSize: 24,
            //     color: Colors.black,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
