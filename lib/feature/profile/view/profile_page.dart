import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/authentication/model/user_model.dart';
import 'package:todo_app/feature/profile/provider/profile_provider.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/constants/project_strings.dart';
import 'package:todo_app/product/extensions/profile_edit_field.dart';
import 'package:todo_app/product/navigate/app_router.dart';
import 'package:todo_app/product/widgets/project_alert_dialog.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

@RoutePage()
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(ProjectStrings.profileAppbar),
      ),
      body: profileState.when(
        data: (user) {
          if (user == null) {
            return const Center(
                child: Text("User not logged in",
              // ProjectStrings.userIsNull,
              style: TextStyle(color: Colors.black),
            ));
          }
          return Padding(
            padding: context.paddingAllLow1,
            child: ListView(
              children: [
                _ListTileUserName(
                  user: user,
                ),
                _ListTileEmail(
                  user: user,
                ),
                _ListTileLogOut(ref),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text("Error: $error")),
      ),
    );
  }
}

class _ListTileUserName extends StatelessWidget {
  const _ListTileUserName({
    required this.user,
  });
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: ProjectColors.iris,
      child: ListTile(
        leading: const Icon(Icons.person_outline, color: ProjectColors.white),
        title: Text(user.name ?? "",
            style: const TextStyle(color: ProjectColors.white)),
        trailing: const Icon(Icons.arrow_outward, color: ProjectColors.white),
        onTap: () => context
            .pushRoute(ProfileEditRoute(profileEditEnum: ProfileEditEnum.name)),
      ),
    );
  }
}

class _ListTileEmail extends StatelessWidget {
  const _ListTileEmail({required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: ProjectColors.iris,
      child: ListTile(
        leading: const Icon(Icons.email_outlined, color: ProjectColors.white),
        title: Text(user.email ?? "",
            style: const TextStyle(fontSize: 18, color: ProjectColors.white)),
        trailing: const Icon(Icons.arrow_outward, color: ProjectColors.white),
        onTap: () => context.pushRoute(
            ProfileEditRoute(profileEditEnum: ProfileEditEnum.email)),
      ),
    );
  }
}

class _ListTileLogOut extends StatelessWidget {
  const _ListTileLogOut(this.ref);
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: ProjectColors.iris,
      child: ListTile(
        leading: const Icon(Icons.exit_to_app, color: ProjectColors.white),
        title: const Text(ProjectStrings.logoutApp,
            style: TextStyle(color: ProjectColors.white)),
        trailing: const Icon(Icons.arrow_outward, color: ProjectColors.white),
        onTap: () async {
          final result = await showDialog(
              context: context,
              builder: (context1) {
                return ProjectAlertDialog(
                  titleText: ProjectStrings.logOutQuestionText,
                  onPressedNO: () {
                    context.maybePop();
                  },
                  onPressedYES: () {
                    context.maybePop<bool>(true);
                  },
                );
              });
          if (result is bool) {
            try {
              await ref.read(profileProvider.notifier).logout();
              context.mounted ?
              context.router.replaceAll([const LoginRoute()]) : null;
            } catch (e) {
              print("ERRRRRROR: ${e.toString()}");
              Fluttertoast.showToast(
                  msg: e.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: ProjectColors.grey,
                  textColor: ProjectColors.white,
                  fontSize: 16.0);
            }
          }
        },
      ),
    );
  }
}
