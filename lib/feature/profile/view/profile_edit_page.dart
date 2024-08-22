import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/profile/provider/profile_provider.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/constants/project_strings.dart';
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
    final profileViewModel = ref.watch(profileProvider.notifier);
    final isLoading = useState<bool>(false);

    return isLoading.value
        ? Container(
            color: ProjectColors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(ProjectStrings.profileEditAppbar,
                  style: TextStyle(color: Colors.black)),
            ),
            body: Padding(
              padding: context.paddingHorizontalMedium,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Spacer(flex: 1),
                    profileEditEnum.isName
                        ? _TextfieldName(tfController: tfController)
                        : _TextFieldEmail(tfController: tfController),
                    const Spacer(flex: 19),
                    ProjectButton(
                      text: ProjectStrings.saveButtonText,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading.value = true;
                          if (profileEditEnum.isName) {
                            await profileViewModel
                                .updateUserName(tfController.text);
                            isLoading.value = false;
                            Fluttertoast.showToast(
                                msg: ProjectStrings
                                    .toastSuccessUpdateNameMessage,
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
                                    titleText: ProjectStrings
                                        .alertDialogVertificationQuestion,
                                    onPressedNO: () {
                                      context.maybePop();
                                    },
                                    onPressedYES: () {
                                      context.maybePop<bool>(true);
                                    },
                                  );
                                });
                            if (result is bool) {
                              await profileViewModel
                                  .updateUserEmail(tfController.text);
                              Fluttertoast.showToast(
                                  msg: ProjectStrings.toastUpdateEmail,
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
                    const Spacer(flex: 2)
                  ],
                ),
              ),
            ),
          );
  }
}

class _TextfieldName extends StatelessWidget {
  const _TextfieldName({
    required this.tfController,
  });

  final TextEditingController tfController;

  @override
  Widget build(BuildContext context) {
    return ProjectTextfield(
      hintText: ProjectStrings.enterName,
      controller: tfController,
      keyBoardType: TextInputType.name,
      validator: Validators().validateName,
      icon: Icons.person_outline,
    );
  }
}

class _TextFieldEmail extends StatelessWidget {
  const _TextFieldEmail({
    required this.tfController,
  });

  final TextEditingController tfController;

  @override
  Widget build(BuildContext context) {
    return ProjectTextfield(
      hintText: ProjectStrings.enterEmail,
      controller: tfController,
      keyBoardType: TextInputType.emailAddress,
      validator: Validators().validateEmail,
      icon: Icons.email_outlined,
    );
  }
}
