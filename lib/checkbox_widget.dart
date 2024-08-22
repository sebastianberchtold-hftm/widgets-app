import 'package:flutter/material.dart';

class CheckboxWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  CheckboxWidget({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text('Checkbox'),
      ],
    );
  }
}
