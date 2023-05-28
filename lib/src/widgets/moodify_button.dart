import 'package:flutter/material.dart';

class MoodifyFilledButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool horizontallyExpanded;

  const MoodifyFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.horizontallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: horizontallyExpanded ? double.infinity : null,
      child: icon != null
          ? FilledButton.icon(
              label: Text(label),
              icon: Icon(icon),
              onPressed: onPressed,
            )
          : FilledButton(
              onPressed: onPressed,
              child: Text(label),
            ),
    );
  }
}
