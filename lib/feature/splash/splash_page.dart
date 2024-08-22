import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/feature/authentication/views/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
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
                ..duration =
                    composition.duration * 1 // animasyonu yavaşlatır
                ..repeat(
                  max: 1,
                );
            },
          ),
        ),
      ),
      nextScreen: const WelcomePage(),
      animationDuration: const Duration(milliseconds: 2000),
      duration: 1800,
      backgroundColor: Colors.white,
      centered: true,
      //duration: 5000,
    );
  }
}
// class SplashPage extends StatefulWidget {
//   final Widget signedInWidget;
//   final Widget signedOutWidget;

//   const SplashPage(
//       {super.key, required this.signedInWidget, required this.signedOutWidget});

//   @override
//   _FirebaseSplashScreenState createState() => _FirebaseSplashScreenState();
// }

// class _FirebaseSplashScreenState extends State<SplashPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );
//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     );

//     _controller.forward();
//     _initializeFirebaseAndCheckAuth();
//   }

//   Future<void> _initializeFirebaseAndCheckAuth() async {
//     try {
//       await Firebase.initializeApp();
//       await Future.delayed(const Duration(seconds: 2));
//       User? user = FirebaseAuth.instance.currentUser;
//       setState(() {
//         _isInitialized = true;
//       });
//       if (user != null) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (_) => widget.signedInWidget),
//         );
//       } else {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (_) => widget.signedOutWidget),
//         );
//       }
//     } catch (e) {
//       print('Firebase initialization error: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FadeTransition(
//           opacity: _animation,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//              Lottie.asset(
//                  'assets/json/loot.json',),
//               const SizedBox(height: 20),
//               if (!_isInitialized) const CircularProgressIndicator(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
