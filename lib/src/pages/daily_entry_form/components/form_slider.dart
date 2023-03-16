import 'package:flutter/material.dart';

import 'descriptive_values.dart';

class FormSlider extends StatefulWidget {
  final String label;
  final List<DescriptiveValue> values;
  final double? initialValue;
  final void Function(int)? onChanged;
  final bool showLabel;

  const FormSlider({
    super.key,
    required this.label,
    required this.values,
    this.initialValue,
    this.onChanged,
    this.showLabel = false,
  });

  @override
  State<FormSlider> createState() => _FormSliderState();
}

class _FormSliderState extends State<FormSlider> {
  double _value = 0;

  String? get _description {
    return widget.values
        .singleWhere((e) => e.value == _value.toInt())
        .description;
  }

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
    if (widget.initialValue != null) {
      _value = widget.initialValue!.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Slider(
          value: _value,
          min: widget.values.first.value.toDouble(),
          max: widget.values.last.value.toDouble(),
          divisions: widget.values.length - 1,
          label: widget.showLabel ? _value.toInt().toString() : null,
          onChanged: (newValue) {
            setState(() => _value = newValue);
            widget.onChanged?.call(_value.toInt());
          },
        ),
        if (_description != null)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(_description!),
          ),
      ],
    );
  }
}
