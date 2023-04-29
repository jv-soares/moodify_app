import 'package:flutter/material.dart';

class FormSlider extends StatefulWidget {
  final String label;
  final double min;
  final double max;
  final double? initialValue;
  final void Function(int)? onChanged;
  final bool showLabel;
  final bool showDivisions;

  const FormSlider({
    super.key,
    required this.label,
    required this.min,
    required this.max,
    this.initialValue,
    this.onChanged,
    this.showLabel = false,
    this.showDivisions = false,
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
    return Theme(
      data: Theme.of(context).copyWith(
        sliderTheme: Theme.of(context)
            .sliderTheme
            .copyWith(showValueIndicator: ShowValueIndicator.always),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge,
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
        ],
      ),
    );
  }
}
