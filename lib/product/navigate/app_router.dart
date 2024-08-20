import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/feature/authentication/view/login_page.dart';
import 'package:todo_app/feature/authentication/view/register_page.dart';
import 'package:todo_app/feature/authentication/view/welcome_page.dart';
import 'package:todo_app/feature/home/model/task_model.dart';
import 'package:todo_app/feature/home/view/home_page.dart';
import 'package:todo_app/feature/home/view/task_add_page.dart';
import 'package:todo_app/feature/home/view/task_detail_page.dart';
import 'package:todo_app/feature/home/view/task_edit_page.dart';
import 'package:todo_app/feature/home/view/task_list_page.dart';
import 'package:todo_app/feature/profile/view/profile_edit_page.dart';
import 'package:todo_app/feature/profile/view/profile_page.dart';
import 'package:todo_app/feature/splash/splash_page.dart';
import 'package:todo_app/feature/tabbar/tabbar_page.dart';
import 'package:todo_app/product/constants/category_id_enum.dart';
import 'package:todo_app/product/extensions/profile_edit_field.dart';

part 'app_router.gr.dart';

//TODO: custom route override
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
        AutoRoute(page: TaskAddRoute.page),
        // CustomRoute(page: TaskListRoute.page,transitionsBuilder: TransitionsBuilders.zoomIn,opaque: false, durationInMilliseconds: 2000,),
        AutoRoute(
          page: TaskListRoute.page,
        ),
        AutoRoute(page: TaskDetailRoute.page),
        AutoRoute(page: TaskEditRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: ProfileEditRoute.page)
      ];
}
