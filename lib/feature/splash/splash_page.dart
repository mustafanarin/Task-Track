import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/feature/authentication/welcome_page.dart';

class SplashPage extends StatefulWidget {
    SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Lottie.asset(
                'assets/json/loot.json',
                controller: _controller,
                repeat: true,
                reverse: false,
                onLoaded: (composition) {
          _controller
            ..duration = composition.duration * 1 // Bu, animasyonu 2 kat yavaşlatır
            ..repeat(max: 1,);
                },
              ),
        ),
      ),
      nextScreen: WelcomePage(),
      animationDuration: Duration(milliseconds: 2000),
      duration: 1800,
      backgroundColor: Colors.white,
      centered: true,
      //duration: 5000,

      );
  }
}