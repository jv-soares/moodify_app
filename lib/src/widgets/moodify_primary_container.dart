import 'package:flutter/material.dart';

class MoodifyPrimaryContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const MoodifyPrimaryContainer({
    required this.child,
    this.width,
    this.borderRadius,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
