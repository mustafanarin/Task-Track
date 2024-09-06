import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/profile/provider/language_provider.dart';
import 'package:todo_app/feature/profile/provider/profile_provider.dart';
import 'package:todo_app/feature/profile/state/profile_state.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/profile_edit_field.dart';
import 'package:todo_app/product/navigate/app_router.dart';
import 'package:todo_app/product/widgets/project_alert_dialog.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/service/push_notifications.dart';

@RoutePage()
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final profileRead = ref.read(profileProvider.notifier);

    Future<void> handleLogout(BuildContext context) async {
      try {
        await profileRead.logout();
        if (context.mounted) {
          context.router.replaceAll([const LoginRoute()]);
          ref.read(notificationServiceProvider).showNotification(
                'logOutNotificationTitle'.localize(ref),
                'logOutNotificationDescription'.localize(ref),
              );
        }
      } catch (e) {
        print("ERROR: ${e.toString()}");
        Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ProjectColors.grey,
          textColor: ProjectColors.white,
          fontSize: 16.0,
        );
      }
    }

    return profileState.isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('profileAppbar'.localize(ref)),
              actions: [_SelectAppLanguage()],
            ),
            body: Padding(
              padding: context.paddingAllLow1,
              child: ListView(
                children: [
                  _UserNameCard(profileState: profileState),
                  _EmailCard(profileState: profileState),
                  _LogOutCard(handleLogout: () => handleLogout(context))
                ],
              ),
            ));
  }
}

class _SelectAppLanguage extends ConsumerWidget {
  const _SelectAppLanguage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.language),
      onSelected: (String languageCode) {
        ref.read(languageProvider.notifier).changeLanguage(languageCode);
        Fluttertoast.showToast(
            msg: "appLanguage".localize(ref),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ProjectColors.grey,
            textColor: ProjectColors.white,
            fontSize: 16.0);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'tr',
          child: Text('Türkçe'),
        ),
        PopupMenuItem<String>(
          value: 'en',
          child: Text('English'),
        ),
      ],
    );
  }
}

class _UserNameCard extends ConsumerWidget {
  const _UserNameCard({
    required this.profileState,
  });

  final ProfileState profileState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 4,
      color: ProjectColors.iris,
      child: ListTile(
        leading: const Icon(Icons.person_outline, color: ProjectColors.white),
        title: Text(profileState.user.name ?? "",
            style: context
                .textTheme()
                .titleMedium
                ?.copyWith(color: ProjectColors.white)),
        trailing: const Icon(Icons.arrow_outward, color: ProjectColors.white),
        onTap: () => context
            .pushRoute(ProfileEditRoute(profileEditEnum: ProfileEditEnum.name)),
      ),
    );
  }
}

class _EmailCard extends ConsumerWidget {
  const _EmailCard({
    required this.profileState,
  });

  final ProfileState profileState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 4,
      color: ProjectColors.iris,
      child: ListTile(
        leading: const Icon(Icons.email_outlined, color: ProjectColors.white),
        title: Text(profileState.user.email ?? "",
            style: context
                .textTheme()
                .titleMedium
                ?.copyWith(color: ProjectColors.white)),
      ),
    );
  }
}

class _LogOutCard extends ConsumerWidget {
  const _LogOutCard({
    required this.handleLogout,
  });

  final VoidCallback handleLogout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 4,
      color: ProjectColors.iris,
      child: ListTile(
        leading: const Icon(Icons.exit_to_app, color: ProjectColors.white),
        title: Text('logoutApp'.localize(ref),
            style: context
                .textTheme()
                .titleMedium
                ?.copyWith(color: ProjectColors.white)),
        trailing: const Icon(Icons.arrow_outward, color: ProjectColors.white),
        onTap: () async {
          final result = await showDialog(
              context: context,
              builder: (context1) {
                return ProjectAlertDialog(
                  titleText: 'logOutQuestionText'.localize(ref),
                );
              });
          if (result is bool && result) {
            handleLogout();
          }
        },
      ),
    );
  }
}
