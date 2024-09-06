import 'package:flutter/material.dart';

class ThemeSwitcher extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const ThemeSwitcher({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isDarkMode ? Icons.nightlight_round : Icons.wb_sunny),
      onPressed: () {
        onThemeChanged(!isDarkMode); // Toggle theme
      },
    );
  }
}
