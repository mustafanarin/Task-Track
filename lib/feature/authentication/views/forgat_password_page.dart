import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/authentication/providers/login_provider.dart';
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

    Future<void> handleSendResetLink() async {
      if (!(formKey.currentState?.validate() ?? false)) return;

      try {
        await authProcesses.sendPasswordResetLink(tfController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${tfController.text} adresine şifre sıfırlama e-postası gönderildi."),
          ),
        );
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Şifre sıfırlama e-postası gönderilemedi: ${e.toString()}"),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Şifremi Unuttum"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Şifre sıfırlama bağlantısı almak için e-posta adresinizi girin"),
              SizedBox(height: 16),
              ProjectTextfield(
                controller: tfController,
                keyBoardType: TextInputType.emailAddress,
                validator: Validators().validateEmail,
                hintText: "E-posta adresinizi girin",
              ),
              SizedBox(height: 16),
              ProjectButton(
                text: "Email Gönder",
                onPressed: () async => await handleSendResetLink(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
