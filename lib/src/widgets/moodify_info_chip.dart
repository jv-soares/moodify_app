import 'package:flutter/material.dart';

class MoodifyInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? foregroundColor;

  const MoodifyInfoChip(
    this.icon,
    this.label, {
    super.key,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final labelStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          color: primaryColor,
        );
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: foregroundColor ?? primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: foregroundColor ?? primaryColor,
            size: labelStyle!.fontSize! * labelStyle.height!,
          ),
          const SizedBox(width: 4),
          Text(label, style: labelStyle.copyWith(color: foregroundColor)),
        ],
      ),
    );
  }
}
