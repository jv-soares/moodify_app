import 'package:flutter/material.dart';

class MoodifyDivider extends StatelessWidget {
  final double horizontalMargin;
  final double verticalMargin;
  final Color? color;

  const MoodifyDivider({
    super.key,
    this.verticalMargin = 0,
    this.horizontalMargin = 16,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: verticalMargin,
      ),
      child: Divider(
        color: color ?? Theme.of(context).colorScheme.outlineVariant,
      ),
    );
  }
}
