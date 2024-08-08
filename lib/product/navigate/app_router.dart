import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/feature/authentication/login_page.dart';
import 'package:todo_app/feature/authentication/register_page.dart';
import 'package:todo_app/feature/authentication/welcome_page.dart';
import 'package:todo_app/feature/home/home_page.dart';
import 'package:todo_app/feature/home/task_add_page.dart';
import 'package:todo_app/feature/splash/splash_page.dart';
import 'package:todo_app/feature/tabbar/tabbar_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page),
    AutoRoute(page: WelcomeRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(
      page: HomeRoute.page,
    ),
    AutoRoute(page: TabbarRoute.page),
    AutoRoute(page: TaskAddRoute.page)
  ];
}
