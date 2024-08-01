import 'package:flutter/material.dart';
import 'package:todo_app/product/navigate/app_router.dart';
import 'package:todo_app/product/theme/light_theme.dart';
import 'package:todo_app/product/utility/initialize/application_start.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: LightTheme().themeData,
      routerConfig: _appRouter.config(),
    );
  }
}
