import 'package:flutter/material.dart';
import 'package:tekfeed_helper/main.dart';

class DropdownFilter<E> extends StatelessWidget {
  final Function(E?) onUpdate;
  final String name;
  final List<DropdownMenuItem<E>> items;
  final E? value;
  MainAxisAlignment mainAxisAlignment;

  DropdownFilter({
    required this.name,
    required this.items,
    required this.value,
    required this.onUpdate,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(name),
        DropdownButton<E>(
          hint: Text(name),
          items: items,
          value: value,
          onChanged: onUpdate,
        ),
      ],
    );
  }
}