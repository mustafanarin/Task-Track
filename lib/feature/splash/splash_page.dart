import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/product/extensions/assets/json_extension.dart';
import 'package:todo_app/product/navigate/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (!mounted) return;

    final authService = ref.read(authServiceProvider);
    final currentUser = await authService.getCurrentUser();

    if (currentUser != null) {
      context.router.replace(const TabbarRoute());
    } else {
      context.router.replace(const WelcomeRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(JsonItems.lottie.path()),
          ],
        ),
      ),
    );
  }
}
