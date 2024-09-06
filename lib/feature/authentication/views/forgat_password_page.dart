import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/authentication/providers/login_provider.dart';
import 'package:todo_app/feature/profile/provider/language_provider.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/validators/validators.dart';
import 'package:todo_app/product/widgets/project_button.dart';
import 'package:todo_app/product/widgets/project_textfield.dart';

class ForgatPasswordPage extends HookConsumerWidget {
  const ForgatPasswordPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tfController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final authProcesses = ref.read(loginProvider.notifier);
    final isLoading = ref.watch(loginProvider).isLoading;

    Future<void> handleSendResetLink() async {
      if (!(formKey.currentState?.validate() ?? false)) return;

      try {
        await authProcesses.sendPasswordResetLink(tfController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "${"successfulMessage".localize(ref)} ${tfController.text}"),
          ),
        );
        context.mounted ? Navigator.of(context).pop() : null;
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "${"failedMessage".localize(ref)} ${e.toString()}"),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('forgotPassword'.localize(ref)),
      ),
      body: Padding(
        padding: context.paddingHorizontalHeigh,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 40),
              _EmailText(),
              SizedBox(height: context.lowValue1),
              _TextFieldEmail(tfController: tfController),
              SizedBox(height: context.mediumValue),
              _SendEmailButton(
                isLoading: isLoading,
                onPressed: handleSendResetLink,
              ),
              Spacer(flex: 60),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailText extends ConsumerWidget {
  const _EmailText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      'emailText'.localize(ref),
      style: context.textTheme().titleMedium,
    );
  }
}

class _TextFieldEmail extends ConsumerWidget {
  const _TextFieldEmail({
    required this.tfController,
  });

  final TextEditingController tfController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProjectTextfield(
      controller: tfController,
      keyBoardType: TextInputType.emailAddress,
      validator: Validators().validateEmail,
      hintText: 'tfEmailHint'.localize(ref),
    );
  }
}

class _SendEmailButton extends ConsumerWidget {
  const _SendEmailButton({
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        ProjectButton(
          text: isLoading ? "" : 'buttonText'.localize(ref),
          onPressed: () async => isLoading ? null : await onPressed(),
        ),
        if (isLoading)
          Center(
            child: CircularProgressIndicator(
              color: ProjectColors.white,
            ),
          )
      ],
    );
  }
}
