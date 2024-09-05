import 'package:flutter/material.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/constants/project_strings.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: ProjectStrings.appName1,
            style: context
                .textTheme()
                .titleLarge
                ?.copyWith(color: ProjectColors.black),
            children: [
          TextSpan(
              text: ProjectStrings.appName2,
              style: context.textTheme().titleLarge)
        ]));
  }
}
