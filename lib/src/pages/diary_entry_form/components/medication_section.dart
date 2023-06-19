import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_entry_form/view_models/diary_entry_view_model.dart';
import 'package:moodify_app/src/widgets/fetch_notifier_builder.dart';
import 'package:provider/provider.dart';

import '../../../widgets/moodify_button.dart';
import 'new_medication_dialog.dart';
import 'taken_medication_card.dart';

class MedicationSection extends StatelessWidget {
  const MedicationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<DiaryEntryViewModel>().medications;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'MEDICAÇÃO',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            FetchNotifierBuilder(
              notifier: notifier,
              onSuccess: (medications) {
                if (medications.isNotEmpty) {
                  return TextButton(
                    onPressed: () => _maybeAddMedication(context),
                    child: const Text('ADICIONAR'),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        FetchNotifierBuilder(
          notifier: notifier,
          onLoading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: CircularProgressIndicator(),
          ),
          onSuccess: (medications) => Column(
            children: [
              medications.isNotEmpty
                  ? const SizedBox(height: 8)
                  : const SizedBox(height: 16),
              medications.isEmpty
                  ? MoodifyFilledButton(
                      label: 'Adicionar medicação',
                      icon: Icons.add,
                      onPressed: () => _maybeAddMedication(context),
                    )
                  : TakenMedicationsCard(medications),
            ],
          ),
        ),
      ],
    );
  }

  void _maybeAddMedication(BuildContext context) async {
    showNewMedicationDialog(context).then((medication) {
      if (medication != null) {
        context.read<DiaryEntryViewModel>().medications.add(medication);
      }
    });
  }
}
