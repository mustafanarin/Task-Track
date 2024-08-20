import 'package:flutter/material.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

class TransparentButton extends StatelessWidget {
  const TransparentButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.stringIcon,
  });
  final String text;
  final void Function() onPressed;
  final String? stringIcon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidht(1),
      height: context.dynamicHeight(0.07),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(width: 1))),
        label: Text(
          text,
          style: context.textTheme().titleMedium,
        ),
        icon: stringIcon == null
            ? null
            : Image.asset(
                stringIcon!,
                height: 25,
                width: 25,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
