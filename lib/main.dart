import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/product/constants/project_strings.dart';
import 'package:todo_app/product/navigate/app_router.dart';
import 'package:todo_app/product/theme/light_theme.dart';
import 'package:todo_app/product/utility/initialize/application_start.dart';
import 'package:todo_app/service/push_notifications.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = AppRouter();
    // Start Notification Service
    ref.read(notificationServiceProvider).initialize();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: ProjectStrings.appName,
      theme: LightTheme().getThemeData(),
      routerConfig: appRouter.config(),
    );
  }
}
