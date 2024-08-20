import 'package:flutter/material.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

class ProjectTextfield extends StatelessWidget {
  ProjectTextfield(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.keyBoardType,
      required this.validator,
      this.icon,
      this.label});
  final Widget? label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final String? Function(String?)? validator;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyBoardType,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: context.textTheme().titleSmall,
      decoration: InputDecoration(
          label: label, hintText: hintText, suffixIcon: Icon(icon)),
    );
  }
}
