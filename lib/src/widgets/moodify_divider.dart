import 'package:flutter/material.dart';

class MoodifyDivider extends StatelessWidget {
  final double horizontalMargin;

  const MoodifyDivider({super.key, this.horizontalMargin = 16});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: const Divider(),
    );
  }
}
