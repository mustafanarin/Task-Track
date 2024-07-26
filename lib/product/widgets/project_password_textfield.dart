import 'package:flutter/material.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

class ProjectPasswordTextfield extends StatefulWidget {
  const ProjectPasswordTextfield({super.key, required this.hintText, required this.controller, required this.keyBoardType, this.validator,});
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final String? Function(String?)? validator;

  @override
  State<ProjectPasswordTextfield> createState() => _ProjectPasswordTextfieldState();
}

class _ProjectPasswordTextfieldState extends State<ProjectPasswordTextfield> {

  bool _obsecure = true;

  void _changeObsecure(){
    setState(() {
      _obsecure = !_obsecure;
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyBoardType,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: context.textTheme().titleSmall,
      obscureText: _obsecure,
      decoration: InputDecoration(
       hintText: widget.hintText,
        suffixIcon: IconButton(
          onPressed: (){
            _changeObsecure();
          },
          icon: AnimatedCrossFade(
            firstChild: const Icon(Icons.visibility_outlined),
            secondChild: const Icon(Icons.visibility_off_outlined),
            crossFadeState: _obsecure ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(seconds: 1),
          ),
        )
       ),
     );
  }
}