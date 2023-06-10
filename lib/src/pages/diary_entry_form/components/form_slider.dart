import 'package:flutter/material.dart';

class FormSlider extends StatefulWidget {
  final String label;
  final double min;
  final double max;
  final String? description;
  final double? initialValue;
  final void Function(int)? onChanged;
  final bool showLabel;
  final bool showDivisions;
  final String? minLabel;
  final String? maxLabel;

  const FormSlider({
    super.key,
    required this.label,
    required this.min,
    required this.max,
    this.description,
    this.initialValue,
    this.onChanged,
    this.showLabel = false,
    this.showDivisions = false,
    this.minLabel,
    this.maxLabel,
  });

  @override
  State<FormSlider> createState() => _FormSliderState();
}

class _FormSliderState extends State<FormSlider> {
  double _value = 8;

  @override
  void initState() {
    super.initState();
    _maybeSetInitialValue();
  }

  @override
  void didUpdateWidget(FormSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    _maybeSetInitialValue();
  }

  void _maybeSetInitialValue() {
    if (widget.initialValue != null) _value = widget.initialValue!;
  }

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
            widget.label.toUpperCase(),
            style: theme.textTheme.labelLarge,
          ),
          if (widget.description != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 16),
              child: Text(
                widget.description!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ),
          Slider(
            value: _value,
            min: widget.min,
            max: widget.max,
            divisions:
                widget.showDivisions ? (widget.max - widget.min).toInt() : null,
            label: widget.showLabel ? _value.toInt().toString() : null,
            onChanged: (newValue) {
              setState(() => _value = newValue);
              widget.onChanged?.call(_value.toInt());
            },
          ),
          if (widget.minLabel != null && widget.maxLabel != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.minLabel!,
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: theme.colorScheme.outline),
                ),
                Text(
                  widget.maxLabel!,
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
