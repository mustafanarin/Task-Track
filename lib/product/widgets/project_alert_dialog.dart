import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
      actions: [
        ElevatedButton(
            onPressed: () {
              context.maybePop();
            },
            child: Text(
              noButtonText,
            )),
        TextButton(
            onPressed: () {
              context.maybePop<bool>(true);
            },
            child: Text(
              yesButtonText,
            ))
      ],
    );
  }
}
