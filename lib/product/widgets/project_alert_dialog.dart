import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/product/constants/project_colors.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

class ProjectAlertDialog extends StatelessWidget {
  final String titleText;
  final void Function()? onPressedNO;
  final void Function()? onPressedYES;
  const ProjectAlertDialog({
    super.key,
    required this.titleText,
    required this.onPressedNO, 
    required this.onPressedYES,
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
            onPressed: onPressedNO,
            child: Text(
              noButtonText,
            )),
        TextButton( onPressed: onPressedYES,
            // onPressed: () {
            //   context.maybePop<bool>(true);
            // },
            child: Text(yesButtonText,))
      ],
    );
  }// TODO THEME KELEDİKTEN SONRA BURAYI DÜZENLE
}
