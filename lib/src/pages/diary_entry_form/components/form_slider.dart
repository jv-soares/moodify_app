import 'package:flutter/material.dart';

class FormSlider extends StatelessWidget {
  final int value;
  final String label;
  final double min;
  final double max;
  final String? description;
  final void Function(int)? onChanged;
  final bool showLabel;
  final bool showDivisions;
  final String? minLabel;
  final String? maxLabel;

  const FormSlider({
    super.key,
    required this.value,
    required this.label,
    required this.min,
    required this.max,
    this.description,
    this.onChanged,
    this.showLabel = false,
    this.showDivisions = false,
    this.minLabel,
    this.maxLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        sliderTheme: theme.sliderTheme
            .copyWith(showValueIndicator: ShowValueIndicator.always),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: theme.textTheme.labelLarge,
          ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 16),
              child: Text(
                description!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ),
          Slider(
            value: value.toDouble(),
            min: min,
            max: max,
            divisions: showDivisions ? (max - min).toInt() : null,
            label: showLabel ? value.toInt().toString() : null,
            onChanged: (newValue) => onChanged?.call(newValue.toInt()),
          ),
          if (minLabel != null && maxLabel != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  minLabel!,
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: theme.colorScheme.outline),
                ),
                Text(
                  maxLabel!,
                  textAlign: TextAlign.end,
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: theme.colorScheme.outline),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
