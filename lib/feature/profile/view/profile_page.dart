import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/profile/viewmodel/profile_viewmodel.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/profile_edit_field.dart';
import 'package:todo_app/product/navigate/app_router.dart';
import 'package:todo_app/product/widgets/project_alert_dialog.dart';

@RoutePage()
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Profile"),
      ),
      body: profileState.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text("User not logged in",style: TextStyle(color: Colors.black),));
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Card(
                  elevation: 4,
                  color: ProjectColors.iris,
                  child: ListTile(
                    leading: Icon(Icons.person_outline, color: ProjectColors.white),
                    title: Text(user.name ?? "", style: TextStyle(color: ProjectColors.white)),
                    trailing: Icon(Icons.arrow_outward, color: ProjectColors.white),
                    onTap: () => context.pushRoute(ProfileEditRoute(profileEditEnum: ProfileEditEnum.name)),
                  ),
                ),
                Card(
                  elevation: 4,
                  color: ProjectColors.iris,
                  child: ListTile(
                    leading: Icon(Icons.email_outlined, color: ProjectColors.white),
                    title: Text(user.email ?? "", style: TextStyle(fontSize: 18, color: ProjectColors.white)),
                    trailing: Icon(Icons.arrow_outward, color: ProjectColors.white),
                    onTap: () => context.pushRoute(ProfileEditRoute(profileEditEnum: ProfileEditEnum.email)),
                  ),
                ),
                Card(
                  elevation: 4,
                  color: ProjectColors.iris,
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app, color: ProjectColors.white),
                    title: Text("Çıkış Yap", style: TextStyle(color: ProjectColors.white)),
                    trailing: Icon(Icons.arrow_outward, color: ProjectColors.white),
                    onTap: () async {
                      final result = await showDialog(context: context, builder: (context){
                        return ProjectAlertDialog(titleText: "Çıkmak istediğine emin misin?");
                      });
                      if(result is bool){
                        ref.read(profileViewModelProvider.notifier).logout();
                        context.mounted ? context.router.replaceAll([const LoginRoute()]) : null;
                      }
                    },
                  ),
                ),
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