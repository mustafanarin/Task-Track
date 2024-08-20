import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

class ProjectAlertDialog extends StatelessWidget {
  final String titleText;
  const ProjectAlertDialog({
    super.key,
    required this.titleText,
  });

  final String noButtonText = "No";
  final String yesButtonText = "Yes";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        titleText,
      ),
      titleTextStyle: context.textTheme().titleMedium,
      actions: [
        ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: ProjectColors.iris),
            onPressed: () {
              context.maybePop();
            },
            child: Text(
              noButtonText,
              style: const TextStyle(color: ProjectColors.white),
            )),
        TextButton(
            onPressed: () {
              context.maybePop<bool>(true);
            },
            child: Text(yesButtonText,
                style: const TextStyle(color: Colors.black)))
      ],
    );
  }
}
