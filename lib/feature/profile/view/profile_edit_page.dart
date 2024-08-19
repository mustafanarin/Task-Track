import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/profile/viewmodel/profile_viewmodel.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/profile_edit_field.dart';
import 'package:todo_app/product/validators/validators.dart';
import 'package:todo_app/product/widgets/project_alert_dialog.dart';
import 'package:todo_app/product/widgets/project_button.dart';
import 'package:todo_app/product/widgets/project_textfield.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

@RoutePage()
class ProfileEditPage extends HookConsumerWidget {
  final ProfileEditEnum profileEditEnum;
  const ProfileEditPage(this.profileEditEnum, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tfController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final profileViewModel = ref.watch(profileViewModelProvider.notifier);
    final isLoading = useState<bool>(false);

    return isLoading.value ? Container(color: ProjectColors.white,child: Center(child: CircularProgressIndicator(),),) :Scaffold(
      appBar: AppBar(
        title: Text("Profile Edit", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: context.paddingHorizontalMedium,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Spacer(flex: 1),
              profileEditEnum.isName
                  ? ProjectTextfield(
                      hintText: "Adınızı giriniz",
                      controller: tfController,
                      keyBoardType: TextInputType.name,
                      validator: Validators().validateName,
                      icon: Icons.person_outline,
                    )
                  : ProjectTextfield(
                      hintText: "Emailinizi giriniz",
                      controller: tfController,
                      keyBoardType: TextInputType.emailAddress,
                      validator: Validators().validateEmail,
                      icon: Icons.email_outlined,
                    ),
              Spacer(flex: 19),
              ProjectButton(
                text: "Save",
                onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading.value = true;
                          if (profileEditEnum.isName) {
                            await profileViewModel
                                .updateUserName(tfController.text);
                            isLoading.value = false;
                            Fluttertoast.showToast(
                                msg: "Name updated successfully!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: ProjectColors.grey,
                                textColor: ProjectColors.white,
                                fontSize: 16.0);
                          } else {
                            final result = await showDialog(
                                context: context,
                                builder: (context) {
                                  return ProjectAlertDialog(
                                    titleText:
                                        "We will send you a verification link. Do you still want to do it?",
                                  );
                                });
                            if (result is bool) {
                              await profileViewModel
                                  .updateUserEmail(tfController.text);
                              Fluttertoast.showToast(
                                  msg: "Please check your email!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: ProjectColors.grey,
                                  textColor: ProjectColors.white,
                                  fontSize: 16.0);
                            }
                            isLoading.value = false;
                          }
                          context.mounted ? context.maybePop() : null;
                        }
                      },
              ),
              Spacer(flex: 2)
            ],
          ),
        ),
      ),
    );
  }
}
