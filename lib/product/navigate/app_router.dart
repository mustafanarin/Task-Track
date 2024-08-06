import 'package:auto_route/auto_route.dart';
import 'package:todo_app/feature/authentication/login_page.dart';
import 'package:todo_app/feature/authentication/register_page.dart';
import 'package:todo_app/feature/authentication/welcome_page.dart';
import 'package:todo_app/feature/home/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: WelcomeRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(
          page: HomeRoute.page,
        )
      ];
}
