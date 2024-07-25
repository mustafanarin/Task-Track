import 'package:flutter/material.dart';
import 'package:todo_app/product/extensions/context_extensions.dart';

class TransparentButton extends StatelessWidget {
  const TransparentButton({super.key, required this.text, required this.onPressed});
  final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: context.dynamicWidht(1),
            height: context.dynamicHeight(0.07),
            child: ElevatedButton(
              onPressed: (){},
               style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(width: 1))
               ), 
               child: Text(text,style: context.textTheme().titleMedium,),
               ),
          );
  }
}