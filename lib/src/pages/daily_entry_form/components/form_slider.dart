import 'package:flutter/material.dart';

class FormSlider extends StatefulWidget {
  final String label;
  final List<DescriptiveValue> values;
  final void Function(int)? onChanged;
  final bool showLabel;

  const FormSlider({
    super.key,
    required this.label,
    required this.values,
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

class DescriptiveValue {
  final int value;
  final String? description;

  DescriptiveValue(this.value, [this.description]);
}

final functionalImpairment = [
  DescriptiveValue(-4, 'Totalmente incapacitado'),
  DescriptiveValue(-3, 'Funcionando com muito esforço'),
  DescriptiveValue(-2, 'Funcionando com um pouco de esforço'),
  DescriptiveValue(-1, 'Consigo realizar qualquer atividade normalmente'),
  DescriptiveValue(0, 'Totalmente normal'),
  DescriptiveValue(
    1,
    'Mais energizado e mais produtivo\nConsigo realizar qualquer atividade normalmente',
  ),
  DescriptiveValue(
    2,
    'Com um pouco de dificuldade em realizar certas atividades',
  ),
  DescriptiveValue(3, 'Com muita dificuldade em realizar certas atividades'),
  DescriptiveValue(4, 'Totalmente incapacitado'),
];

final mood = [
  DescriptiveValue(-1, 'Mais depressivo que nunca'),
  DescriptiveValue(0, 'Equilibrado'),
  DescriptiveValue(1, 'Mais ativo que nunca'),
];
