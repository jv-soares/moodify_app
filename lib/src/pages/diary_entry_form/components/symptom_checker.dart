import 'package:flutter/material.dart';

import '../../../models/symptom.dart';

class SymptomChecker extends StatefulWidget {
  final Set<Symptom> symptoms;
  final void Function(Set<Symptom>) onSymptomsChanged;

  const SymptomChecker({
    super.key,
    required this.symptoms,
    required this.onSymptomsChanged,
  });

  @override
  State<SymptomChecker> createState() => _SymptomCheckerState();
}

class _SymptomCheckerState extends State<SymptomChecker> {
  final _selectedSymptoms = <Symptom>{};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SINTOMAS',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: widget.symptoms
                .map((e) => _SymptomChip(
                      e,
                      onTap: (isSelected) {
                        setState(() {
                          isSelected
                              ? _selectedSymptoms.add(e)
                              : _selectedSymptoms.remove(e);
                        });
                        widget.onSymptomsChanged(_selectedSymptoms);
                      },
                      isSelected: _isSymptomSelected(e),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  bool _isSymptomSelected(Symptom symptom) {
    return _selectedSymptoms.contains(symptom);
  }
}

class _SymptomChip extends StatelessWidget {
  final Symptom symptom;
  final ValueChanged<bool> onTap;
  final bool isSelected;

  const _SymptomChip(
    this.symptom, {
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    return FilterChip(
      label: Text(symptom.toLocalizedString()),
      onSelected: (isSelected) => onTap(isSelected),
      selected: isSelected,
      selectedColor: primaryColor,
      labelStyle: isSelected
          ? theme.textTheme.labelLarge
              ?.copyWith(color: theme.colorScheme.onPrimary)
          : theme.textTheme.labelLarge?.copyWith(color: primaryColor),
      side: BorderSide(width: 1, color: primaryColor),
      checkmarkColor: theme.colorScheme.onPrimary,
    );
  }
}

extension on Symptom {
  String toLocalizedString() {
    switch (this) {
      case Symptom.anxiety:
        return 'Ansiedade';
      case Symptom.menstruation:
        return 'Menstruação';
      case Symptom.dysphoricMania:
        return 'Mania disfórica';
      case Symptom.panicAttack:
        return 'Crise de pânico';
    }
  }
}
