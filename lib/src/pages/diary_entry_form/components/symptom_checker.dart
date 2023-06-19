import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_entry_form/view_models/diary_entry_view_model.dart';
import 'package:provider/provider.dart';

import '../../../models/symptom.dart';

class SymptomChecker extends StatelessWidget {
  const SymptomChecker({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DiaryEntryViewModel>();
    final selected = viewModel.symptoms;
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
            children: Symptom.values
                .map((e) => _SymptomChip(
                      e,
                      onTap: (isSelected) {
                        if (isSelected) {
                          viewModel.update(symptoms: {...selected, e});
                        } else {
                          viewModel.update(symptoms: {...selected}..remove(e));
                        }
                      },
                      isSelected: selected.contains(e),
                    ))
                .toList(),
          ),
        ],
      ),
    );
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
      label: Text(symptom.localizedName),
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
