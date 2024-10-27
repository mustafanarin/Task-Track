import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/feature/profile/provider/language_provider.dart';
class ProjectAlertDialog extends ConsumerWidget {
  final String titleText;
  
  const ProjectAlertDialog({
    super.key,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return AlertDialog(
      title: Text(titleText),
      actions: [
        ElevatedButton(
          onPressed: () => context.maybePop(),
          child: Text('noButtonText'.localize(ref)),
        ),
        TextButton(
          onPressed: () => context.maybePop<bool>(true),
          child: Text('yesButtonText'.localize(ref)),
        )
      ],
    );
  }
}