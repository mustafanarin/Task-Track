import 'package:flutter/material.dart';

class ProjectDropdown extends StatelessWidget {
  final String labelText;
  final int? value;
  final List<int> itemValues;
  final ValueChanged<int?>? onChanged;
  final String Function(int)? itemBuilder;

  const ProjectDropdown({
    super.key,
    required this.labelText,
    required this.value,
    required this.itemValues,
    required this.onChanged,
    this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(labelText: labelText),
      value: value,
      items: itemValues.map((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(itemBuilder != null ? itemBuilder!(value) : '$value'),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
