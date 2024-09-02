import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/authentication/providers/login_provider.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/validators/validators.dart';
import 'package:todo_app/product/widgets/project_button.dart';
import 'package:todo_app/product/widgets/project_textfield.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

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
                "A password reset email has been sent to ${tfController.text}"),
          ),
        );
        context.mounted ? Navigator.of(context).pop() : null;
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text("Password reset email could not be sent: ${e.toString()}"),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Email",
                style: context.textTheme().titleMedium,
              ),
              SizedBox(height: 8),
              ProjectTextfield(
                controller: tfController,
                keyBoardType: TextInputType.emailAddress,
                validator: Validators().validateEmail,
                hintText: "Enter your email",
              ),
              SizedBox(height: 30),
              Stack(
                children: [
                  ProjectButton(
                    text: isLoading ? "" : "Send email",
                    onPressed: () async =>
                        isLoading ? null : await handleSendResetLink(),
                  ),
                  if (isLoading)
                    Center(
                      child: CircularProgressIndicator(
                        color: ProjectColors.white,
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
