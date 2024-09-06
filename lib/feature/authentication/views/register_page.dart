import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/authentication/providers/register_provider.dart';
import 'package:todo_app/feature/authentication/state/user_state.dart';
import 'package:todo_app/feature/profile/provider/language_provider.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/navigate/app_router.dart';
import 'package:todo_app/product/validators/validators.dart';
import 'package:todo_app/product/widgets/project_button.dart';
import 'package:todo_app/product/widgets/project_textfield.dart';

@RoutePage()
class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmController = useTextEditingController();
    final authwatch = ref.watch(registerProvider);

    final authPrecess = ref.read(registerProvider.notifier);

    Future<void> handleRegister() async {
      try {
        if (!(formKey.currentState?.validate() ?? false)) return;

        await authPrecess.register(
            nameController.text, emailController.text, passwordController.text);

        if (!context.mounted) return;
        context.router.replaceAll([const TabbarRoute()]);
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("registerError".localize(ref)),
          ),
        );
      }
    }

    return Scaffold(
      appBar: _CustomAppbar(
        height: context.dynamicHeight(0.12),
      ),
      body: Column(
        children: [
          _Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: context.paddingHorizontalHeigh,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.dynamicHeight(0.08)),
                      _UserNameText(),
                      SizedBox(height: context.lowValue1),
                      _TextfieldUserName(nameController: nameController),

                      SizedBox(height: context.lowValue1),
                      _EmailText(),
                      SizedBox(height: context.lowValue1),
                      _TextfieldEmail(emailController: emailController),

                      SizedBox(height: context.lowValue1),
                      PasswordText(),
                      SizedBox(height: context.lowValue1),
                      _TextfieldPassword(
                          passwordController: passwordController),

                      SizedBox(height: context.lowValue1),
                      _ConfirmText(),
                      SizedBox(height: context.lowValue1),
                      _TextfieldConfirm(
                          confirmController: confirmController,
                          passwordController: passwordController),

                      SizedBox(height: context.dynamicHeight(0.08)),
                      _RegisterButton(
                          authwatch: authwatch, onPressed: handleRegister),
                      SizedBox(height: context.highValue)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const _CustomAppbar({
    required this.height,
  });
  final double height;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return AppBar(
      toolbarHeight: context.dynamicHeight(0.12),
      centerTitle: true,
      title: SizedBox(
        height: context.dynamicHeight(0.10),
        child: Column(
          children: [
            SizedBox(
              height: context.mediumValue,
            ),
            Text(
              "registerButton".localize(ref),
              style: context.textTheme().titleLarge,
            ),
            Text(
              "supTitle".localize(ref),
              style: context
                  .textTheme()
                  .titleSmall
                  ?.copyWith(color: ProjectColors.grey),
            )
          ],
        ),
      ),
      leading: Padding(
        padding:
            EdgeInsets.only(top: context.mediumValue, right: context.lowValue1),
        child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () => context.maybePop(),
                icon: const Icon(Icons.arrow_back_outlined))),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: ProjectColors.black,
      thickness: 1.5,
    );
  }
}

class _UserNameText extends ConsumerWidget {
  const _UserNameText();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Text(
      "userName".localize(ref),
      style: context.textTheme().titleMedium,
    );
  }
}

class _TextfieldUserName extends ConsumerWidget {
  const _TextfieldUserName({
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ProjectTextfield(
        hintText: "tfUserNameHint".localize(ref),
        controller: nameController,
        keyBoardType: TextInputType.name,
        validator: Validators().validateName);
  }
}

class _EmailText extends ConsumerWidget {
  const _EmailText();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Text(
      "emailText".localize(ref),
      style: context.textTheme().titleMedium,
    );
  }
}

class _TextfieldEmail extends ConsumerWidget {
  const _TextfieldEmail({
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ProjectTextfield(
        hintText: "tfEmailHint".localize(ref),
        controller: emailController,
        keyBoardType: TextInputType.emailAddress,
        validator: Validators().validateEmail);
  }
}

class PasswordText extends ConsumerWidget {
  const PasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Text(
      "passwordText".localize(ref),
      style: context.textTheme().titleMedium,
    );
  }
}

class _TextfieldPassword extends ConsumerWidget {
  const _TextfieldPassword({
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ProjectTextfield(
      isPassword: true,
      hintText: "tfPasswordHint".localize(ref),
      controller: passwordController,
      keyBoardType: TextInputType.visiblePassword,
      validator: Validators().validatePassword,
    );
  }
}

class _ConfirmText extends ConsumerWidget {
  const _ConfirmText();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Text(
      "confirmText".localize(ref),
      style: context.textTheme().titleMedium,
    );
  }
}

class _TextfieldConfirm extends ConsumerWidget {
  const _TextfieldConfirm({
    required this.confirmController,
    required this.passwordController,
  });

  final TextEditingController confirmController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ProjectTextfield(
        isPassword: true,
        hintText: "tfConfirmHint".localize(ref),
        controller: confirmController,
        keyBoardType: TextInputType.visiblePassword,
        validator: (value) => Validators()
            .validateConfirmPassword(value, passwordController.text));
  }
}

class _RegisterButton extends ConsumerWidget {
  const _RegisterButton({
    required this.authwatch,
    required this.onPressed,
  });

  final UserState authwatch;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Stack(
      children: [
        ProjectButton(
            text: authwatch.isLoading ? "" : "registerButton".localize(ref),
            onPressed: () async =>
                authwatch.isLoading ? null : await onPressed()),
        if (authwatch.isLoading)
          Center(
              heightFactor: 1,
              child: CircularProgressIndicator(
                color: ProjectColors.white,
              )),
      ],
    );
  }
}
