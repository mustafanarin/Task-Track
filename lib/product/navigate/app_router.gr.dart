// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [ProfileEditPage]
class ProfileEditRoute extends PageRouteInfo<ProfileEditRouteArgs> {
  ProfileEditRoute({
    required ProfileEditEnum profileEditEnum,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileEditRoute.name,
          args: ProfileEditRouteArgs(
            profileEditEnum: profileEditEnum,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileEditRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileEditRouteArgs>();
      return ProfileEditPage(
        args.profileEditEnum,
        key: args.key,
      );
    },
  );
}

class ProfileEditRouteArgs {
  const ProfileEditRouteArgs({
    required this.profileEditEnum,
    this.key,
  });

  final ProfileEditEnum profileEditEnum;

  final Key? key;

  @override
  String toString() {
    return 'ProfileEditRouteArgs{profileEditEnum: $profileEditEnum, key: $key}';
  }
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterPage();
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    Key? key,
    required Widget signedInWidget,
    required Widget signedOutWidget,
    List<PageRouteInfo>? children,
  }) : super(
          SplashRoute.name,
          args: SplashRouteArgs(
            key: key,
            signedInWidget: signedInWidget,
            signedOutWidget: signedOutWidget,
          ),
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SplashRouteArgs>();
      return SplashPage(
        key: args.key,
        signedInWidget: args.signedInWidget,
        signedOutWidget: args.signedOutWidget,
      );
    },
  );
}

class SplashRouteArgs {
  const SplashRouteArgs({
    this.key,
    required this.signedInWidget,
    required this.signedOutWidget,
  });

  final Key? key;

  final Widget signedInWidget;

  final Widget signedOutWidget;

  @override
  String toString() {
    return 'SplashRouteArgs{key: $key, signedInWidget: $signedInWidget, signedOutWidget: $signedOutWidget}';
  }
}

/// generated route for
/// [TabbarPage]
class TabbarRoute extends PageRouteInfo<void> {
  const TabbarRoute({List<PageRouteInfo>? children})
      : super(
          TabbarRoute.name,
          initialChildren: children,
        );

  static const String name = 'TabbarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TabbarPage();
    },
  );
}

/// generated route for
/// [TaskAddPage]
class TaskAddRoute extends PageRouteInfo<void> {
  const TaskAddRoute({List<PageRouteInfo>? children})
      : super(
          TaskAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'TaskAddRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TaskAddPage();
    },
  );
}

/// generated route for
/// [TaskDetailPage]
class TaskDetailRoute extends PageRouteInfo<TaskDetailRouteArgs> {
  TaskDetailRoute({
    required TaskModel model,
    required CategoryId category,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          TaskDetailRoute.name,
          args: TaskDetailRouteArgs(
            model: model,
            category: category,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'TaskDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TaskDetailRouteArgs>();
      return TaskDetailPage(
        args.model,
        args.category,
        key: args.key,
      );
    },
  );
}

class TaskDetailRouteArgs {
  const TaskDetailRouteArgs({
    required this.model,
    required this.category,
    this.key,
  });

  final TaskModel model;

  final CategoryId category;

  final Key? key;

  @override
  String toString() {
    return 'TaskDetailRouteArgs{model: $model, category: $category, key: $key}';
  }
}

/// generated route for
/// [TaskEditPage]
class TaskEditRoute extends PageRouteInfo<TaskEditRouteArgs> {
  TaskEditRoute({
    required TaskModel model,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          TaskEditRoute.name,
          args: TaskEditRouteArgs(
            model: model,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'TaskEditRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TaskEditRouteArgs>();
      return TaskEditPage(
        args.model,
        key: args.key,
      );
    },
  );
}

class TaskEditRouteArgs {
  const TaskEditRouteArgs({
    required this.model,
    this.key,
  });

  final TaskModel model;

  final Key? key;

  @override
  String toString() {
    return 'TaskEditRouteArgs{model: $model, key: $key}';
  }
}

/// generated route for
/// [TaskListPage]
class TaskListRoute extends PageRouteInfo<TaskListRouteArgs> {
  TaskListRoute({
    required int categoryId,
    required CategoryId category,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          TaskListRoute.name,
          args: TaskListRouteArgs(
            categoryId: categoryId,
            category: category,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'TaskListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TaskListRouteArgs>();
      return TaskListPage(
        args.categoryId,
        args.category,
        key: args.key,
      );
    },
  );
}

class TaskListRouteArgs {
  const TaskListRouteArgs({
    required this.categoryId,
    required this.category,
    this.key,
  });

  final int categoryId;

  final CategoryId category;

  final Key? key;

  @override
  String toString() {
    return 'TaskListRouteArgs{categoryId: $categoryId, category: $category, key: $key}';
  }
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WelcomePage();
    },
  );
}
