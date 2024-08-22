import 'package:flutter/material.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

class ProjectButton extends StatelessWidget {
  const ProjectButton({super.key, required this.text, required this.onPressed});
  final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: context.dynamicWidht(1),
            height: context.dynamicHeight(0.07),
            child: ElevatedButton(
              onPressed: onPressed,
             child: Text(text,),
             ),
          );
  }
} //TODO THEME EKLEDİKTEN SONRA BURAYI DÜZENLE