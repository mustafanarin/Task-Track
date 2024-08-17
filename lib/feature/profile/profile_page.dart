import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/profile_edit_field.dart';
import 'package:todo_app/product/navigate/app_router.dart';

@RoutePage()
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Card(
                elevation: 4,
                color: ProjectColors.iris,
                child: ListTile(
                  leading: Icon(
                    Icons.person_outline,
                    color: ProjectColors.white,
                  ),
                  title: Text(
                    "Mustafa Narin",
                    style: TextStyle(color: ProjectColors.white),
                  ),
                  trailing: Icon(
                    Icons.arrow_outward,
                    color: ProjectColors.white,
                  ),
                  onTap: () => context.pushRoute(ProfileEditRoute(profileEditEnum: ProfileEditEnum.name)),
                ),
              ),
              Card(
                elevation: 4,
                color: ProjectColors.iris,
                child: ListTile(
                  leading: Icon(
                    Icons.person_outline,
                    color: ProjectColors.white,
                  ),
                  title: Text(
                    "mustafa.narin11gmail.com",
                    style: TextStyle(fontSize: 18, color: ProjectColors.white),
                  ),
                  trailing: Icon(
                    Icons.arrow_outward,
                    color: ProjectColors.white,
                  ),
                  onTap: () {
                    context.pushRoute(ProfileEditRoute(profileEditEnum: ProfileEditEnum.email));
                  },
                  //  onTap: ,
                ),
              ),
              const Card(
                elevation: 4,
                color: ProjectColors.iris,
                child: ListTile(
                  leading: Icon(
                    Icons.person_outline,
                    color: ProjectColors.white,
                  ),
                  title: Text(
                    "Çıkış Yap",
                    style: TextStyle(color: ProjectColors.white),
                  ),
                  trailing: Icon(
                    Icons.arrow_outward,
                    color: ProjectColors.white,
                  ),
                  //  onTap: ,
                ),
              ),
            ],
          ),
        ));
  }
}
