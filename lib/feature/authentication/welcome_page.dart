import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/constants/project_strings.dart';
import 'package:todo_app/product/extensions/assets/png_extension.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';
import 'package:todo_app/product/navigate/app_router.dart';
import 'package:todo_app/product/widgets/project_button.dart';
import 'package:todo_app/product/widgets/transparent_button.dart';

@RoutePage()
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const _ImagePage(),
          const _CustomContainerAndAppName(),
          Expanded(
            flex: 50,
            child: Column(
              children: [
                const Spacer(flex: 5,),
                 const _DescriptionText(),
                const Spacer(flex: 10,),
                Padding(
                  padding: context.paddingHorizontalHeigh,
                  child: ProjectButton(text: ProjectStrings.loginButton, onPressed:(){
                    context.pushRoute(const LoginRoute());
                  }),
                ),
                const Spacer(flex: 8,),
                Padding(
                  padding: context.paddingHorizontalHeigh,
                  child: TransparentButton(text: ProjectStrings.registerButton, onPressed: (){
                    context.pushRoute(RegisterRoute());
                  }),
                ),
                const Spacer(flex: 15,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ImagePage extends StatelessWidget {
  const _ImagePage();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 50,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Image.asset(PngItems.woman_shopping.path(),fit: BoxFit.contain,)));
  }
}

class _CustomContainerAndAppName extends StatelessWidget {
  const _CustomContainerAndAppName();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ProjectColors.iris,width: 1.5)
      ),
      width: context.dynamicWidht(1),
      height: context.dynamicHeight(0.1),
      child:  Center(child: RichText(text: TextSpan(text: ProjectStrings.appName1,style: context.textTheme().titleLarge?.copyWith(color: ProjectColors.black),children: [TextSpan(text: ProjectStrings.appName2,style: context.textTheme().titleLarge)]))),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  const _DescriptionText();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingHorizontalMedium,
      child: Text(ProjectStrings.welcomeDescription,
              style: context.textTheme().titleMedium?.copyWith(
                color: ProjectColors.grey)),
    );
  }
}