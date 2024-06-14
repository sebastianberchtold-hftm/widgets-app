import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  OutlinedButtonWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text('OutlinedButton'),
    );
  }
}
