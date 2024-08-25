import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

class ProjectTextfield extends HookWidget {
  const ProjectTextfield({
    Key? key,
    this.hintText,
    this.controller,
    required this.keyBoardType,
    required this.validator,
    this.icon,
    this.label,
    this.onChanged,
    this.decoration,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.isPassword = false,
  }) : super(key: key);

  final Widget? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyBoardType;
  final String? Function(String?)? validator;
  final IconData? icon;
  final void Function(String)? onChanged;
  final InputDecoration? decoration;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    final obscure = useState(true);

    void changeObscure() {
      obscure.value = !obscure.value;
    }
    
    final activeMaxLines = isPassword ? 1 : maxLines;

    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      maxLength: maxLength,
      keyboardType: keyBoardType,
      validator: validator,
      maxLines: activeMaxLines,
      minLines: minLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: context.textTheme().titleSmall,
      obscureText: isPassword ? obscure.value : false,
      decoration: (decoration ?? const InputDecoration()).copyWith(
        labelText: label != null ? (label as Text).data : null,
        hintText: hintText,
        suffixIcon: isPassword
            ? IconButton(
                onPressed: changeObscure,
                icon: AnimatedCrossFade(
                  firstChild: const Icon(Icons.visibility_outlined),
                  secondChild: const Icon(Icons.visibility_off_outlined),
                  crossFadeState: obscure.value
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(seconds: 1),
                ),
              )
            : Icon(icon),
      ),
    );
  }
}