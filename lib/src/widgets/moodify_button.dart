import 'package:flutter/material.dart';

class MoodifyFilledButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const MoodifyFilledButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      label: Text(label),
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}
