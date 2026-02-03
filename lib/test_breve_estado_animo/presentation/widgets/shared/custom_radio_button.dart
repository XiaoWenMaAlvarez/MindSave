import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final String title;
  final int groupValue;
  final Function(int?) onChanged;
  final int minValue;
  final int maxValue;
  final List<String> labels;

  const CustomRadioButton({
    super.key,
    required this.title, 
    required this.groupValue, 
    required this.onChanged,
    required this.minValue,
    required this.maxValue,
    required this.labels
  });

  @override
  Widget build(BuildContext context) {
    return RadioGroup(
      groupValue: groupValue, 
      onChanged: onChanged,
      child: ExpansionTile(
        title: Text(title),
        children: [
          for (int i = minValue; i <= maxValue; i++)
            RadioListTile(
              title: Text('$i - ${labels[i]}'),
              value: i,
            ),
        ],
      ),
    );
  }
}