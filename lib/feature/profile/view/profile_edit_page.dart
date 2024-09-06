import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/profile/provider/profile_provider.dart';
import 'package:todo_app/feature/profile/provider/language_provider.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/profile_edit_field.dart';
import 'package:todo_app/product/validators/validators.dart';
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
    final profileRead = ref.read(profileProvider.notifier);
    final isLoading = useState<bool>(false);

    Future<void> updateName() async {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        try {
          await profileRead.updateUserName(tfController.text);
          Fluttertoast.showToast(
              msg: 'toastSuccessUpdateNameMessage'.localize(ref),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: ProjectColors.grey,
              textColor: ProjectColors.white,
              fontSize: 16.0);
          context.mounted ? context.maybePop() : null;
        } catch (error) {
          isLoading.value = false;
          Fluttertoast.showToast(
              msg:
                  "${"toastErrorUpdateNameMessage".localize(ref)} ${error.toString()}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: ProjectColors.grey,
              textColor: ProjectColors.white,
              fontSize: 16.0);
        }
      }
    }

    return isLoading.value
        ? Container(
            color: ProjectColors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('profileEditAppbar'.localize(ref),
                  style: TextStyle(color: Colors.black)),
            ),
            body: Padding(
              padding: context.paddingHorizontalMedium,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Spacer(flex: 1),
                    _TextfieldName(tfController: tfController),
                    Spacer(flex: 19),
                    ProjectButton(
                        text: 'saveButtonText'.localize(ref),
                        onPressed: updateName),
                    const Spacer(flex: 2)
                  ],
                ),
              ),
            ),
          );
  }
}

class _TextfieldName extends ConsumerWidget {
  const _TextfieldName({
    required this.tfController,
  });

  final TextEditingController tfController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProjectTextfield(
      hintText: 'enterName'.localize(ref),
      controller: tfController,
      keyBoardType: TextInputType.name,
      validator: Validators().validateName,
      icon: Icons.person_outline,
    );
  }
}
