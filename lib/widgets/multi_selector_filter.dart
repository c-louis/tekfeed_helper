import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class MultiSelectorFilter extends StatelessWidget {
  final String name;
  final List<String> options;
  final Function(List<String>) onChanged;
  final List<String> selectedValues;

  const MultiSelectorFilter({required this.name, required this.options, required this.onChanged, required this.selectedValues});

  @override
  Widget build(BuildContext context) {
    return DropDownMultiSelect(
      options: options,
      selectedValues: selectedValues,
      onChanged: onChanged,
      whenEmpty: '$name...',
    );

  }
}