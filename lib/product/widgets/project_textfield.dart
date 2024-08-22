import 'package:flutter/material.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

class ProjectTextfield extends StatelessWidget {
  ProjectTextfield({
    super.key,
    this.hintText,
    this.controller,
    required this.keyBoardType,
    required this.validator,
    this.icon,
    this.label,
    this.onChanged,
    this.decoration,
    this.maxLenght, this.maxLines,
  });
  final Widget? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyBoardType;
  final String? Function(String?)? validator;
  final IconData? icon;
  final void Function(String)? onChanged;
  final InputDecoration? decoration;
  final int? maxLenght;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      maxLength: maxLenght,
      keyboardType: keyBoardType,
      validator: validator,
      maxLines: maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: context.textTheme().titleSmall,
      decoration: InputDecoration(
          label: label, hintText: hintText, suffixIcon: Icon(icon)),
    );
  }
}
