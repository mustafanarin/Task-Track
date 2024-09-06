import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/feature/authentication/providers/login_provider.dart';
import 'package:todo_app/feature/authentication/views/forgat_password_page.dart';
import 'package:todo_app/feature/profile/provider/language_provider.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/assets/png_extension.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/navigate/app_router.dart';
import 'package:todo_app/product/validators/validators.dart';
import 'package:todo_app/product/widgets/project_button.dart';
import 'package:todo_app/product/widgets/project_textfield.dart';
import 'package:todo_app/product/widgets/transparent_button.dart';

@RoutePage()
class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final authWatch = ref.watch(loginProvider);
    final authProcesses = ref.read(loginProvider.notifier);

    Future<void> handleLogin() async {
      try {
        if (!(formKey.currentState?.validate() ?? false)) return;

        await authProcesses.login(
            emailController.text, passwordController.text);

        if (!context.mounted) return;
        context.router.replaceAll([const TabbarRoute()]);
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("loginError".localize(ref)),
          ),
        );
      }
    }

    Future<void> handleGoogleLogin() async {
      try {
        await ref.read(loginProvider.notifier).signInWithGoogle();

        if (context.mounted) {
          context.router.replaceAll([const TabbarRoute()]);
        } 
      } catch (e) {
        print("Error during Google login: $e");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("tryAgainMessage".localize(ref)),
            ),
          );
        }
      }
    }

    return authWatch.isLoading
        ? _CircularProgressIndicator()
        : Scaffold(
            appBar: _CustomAppbar(
              height: context.dynamicHeight(0.3),
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    const Divider(
                      color: ProjectColors.black,
                      thickness: 1.5,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: context.paddingHorizontalHeigh,
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: context.lowValue1),
                                _EmailText(),
                                SizedBox(height: context.lowValue1),
                                _TextfieldEmail(
                                    emailController: emailController),
                                SizedBox(height: context.lowValue1),
                                _PasswordText(),
                                SizedBox(height: context.lowValue1),
                                _TextfieldPassword(
                                    passwordController: passwordController),
                                _ForgotPaswordButton(),
                                _LoginButton(
                                  onPressed: handleLogin,
                                ),
                                SizedBox(height: context.lowValue2),
                                const _OrDivider(),
                                SizedBox(height: context.lowValue2),
                                _LoginWithGoogleButton(
                                    onPressed: handleGoogleLogin),
                                SizedBox(height: context.lowValue2),
                                _GoRegisterRow(),
                                SizedBox(height: context.highValue)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                if (authWatch.isLoading) _CirculerProgesIndicator()
              ],
            ),
          );
  }
}

class _CirculerProgesIndicator extends StatelessWidget {
  const _CirculerProgesIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Spacer(
            flex: 2,
          ),
          CircularProgressIndicator(),
          Spacer(
            flex: 3,
          )
        ],
      ),
    );
  }
}

class _CircularProgressIndicator extends StatelessWidget {
  const _CircularProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProjectColors.white,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _EmailText extends ConsumerWidget {
  const _EmailText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return ProjectTextfield(
      hintText: "tfEmailHint".localize(ref),
      controller: emailController,
      keyBoardType: TextInputType.emailAddress,
      validator: Validators().validateEmail,
      icon: Icons.person_outline_outlined,
    );
  }
}

class _PasswordText extends ConsumerWidget {
  const _PasswordText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return ProjectTextfield(
        isPassword: true,
        hintText: "tfPasswordHint".localize(ref),
        controller: passwordController,
        keyBoardType: TextInputType.visiblePassword,
        validator: Validators().validatePassword);
  }
}

class _ForgotPaswordButton extends ConsumerWidget {
  const _ForgotPaswordButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
        alignment: Alignment.topRight,
        child: TextButton(
          child: Text("forgatPasswordBtn".localize(ref),
              style: context.textTheme().titleSmall),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ForgatPasswordPage()));
          },
        ));
  }
}

class _LoginButton extends ConsumerWidget {
  const _LoginButton({
    required this.onPressed,
  });
  final Future<void> Function() onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProjectButton(
        text: "loginButton".localize(ref),
        onPressed: () async => await onPressed());
  }
}

class _LoginWithGoogleButton extends ConsumerWidget {
  const _LoginWithGoogleButton({
    required this.onPressed,
  });

  final Future<void> Function() onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TransparentButton(
        stringIcon: PngItems.google_icon.path(),
        text: "loginWithGoogle".localize(ref),
        onPressed: () async => await onPressed());
  }
}

class _GoRegisterRow extends ConsumerWidget {
  const _GoRegisterRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "haventAccont".localize(ref),
          style: context.textTheme().titleMedium,
        ),
        TextButton(
            onPressed: () => context.pushRoute(const RegisterRoute()),
            child: Text(
              "registerButton".localize(ref),
              style: context
                  .textTheme()
                  .titleMedium
                  ?.copyWith(color: ProjectColors.iris),
            ))
      ],
    );
  }
}

class _CustomAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const _CustomAppbar({
    required this.height,
  });
  final double height;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      toolbarHeight: height,
      leading: Padding(
        padding:
            EdgeInsets.only(top: context.mediumValue, right: context.lowValue1),
        child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  context.router.replaceAll([const WelcomeRoute()]);
                },
                icon: const Icon(Icons.arrow_back_outlined))),
      ),
      title: SizedBox(
        height: context.dynamicHeight(0.28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: context.dynamicHeight(0.20),
                width: context.dynamicHeight(0.20),
                child: Image.asset(
                  PngItems.man_working.path(),
                  fit: BoxFit.contain,
                )),
            Text("loginButton".localize(ref),
                style: context.textTheme().titleLarge),
            Text(
              "appBarSuptitle".localize(ref),
              textAlign: TextAlign.center,
              style: context
                  .textTheme()
                  .titleSmall
                  ?.copyWith(color: ProjectColors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _OrDivider extends ConsumerWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            color: Colors.black,
            thickness: 1,
            indent: 50,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "divderOrText".localize(ref),
            style: context.textTheme().titleMedium,
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.black,
            thickness: 1,
            endIndent: 50,
          ),
        ),
      ],
    );
  }
}
