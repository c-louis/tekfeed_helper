import 'package:flutter/material.dart';

class Sorter extends StatelessWidget {
  final Function(double) onSliderUpdate;
  final Function(bool?) onCheckboxUpdate;
  final String label;
  final double sliderValue;
  final bool checkboxValue;
  MainAxisAlignment mainAxisAlignment;

  Sorter({
    required this.label,
    required this.sliderValue,
    required this.checkboxValue,
    required this.onSliderUpdate,
    required this.onCheckboxUpdate,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Text(label),
            Checkbox(
                value: checkboxValue,
                onChanged: onCheckboxUpdate
            ),
          ],
        ),
        if (checkboxValue)
          Slider(
            value: sliderValue,
            min: 0.0,
            max: 1.0,
            onChanged: onSliderUpdate,
          ),
      ],
    );
  }
}