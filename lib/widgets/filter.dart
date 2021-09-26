

import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  final String name;
  final Function(bool?) onChanged;
  final bool? value;
  final MainAxisAlignment mainAxisAlignment;

  Filter({
    required this.name,
    required this.onChanged,
    required this.value,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(name),
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

}