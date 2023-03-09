import 'package:flutter/material.dart';
import 'package:moodify_app/src/model/medication.dart';
import 'package:moodify_app/src/pages/components/new_medication_dialog.dart';
import 'package:moodify_app/src/pages/components/taken_medication_card.dart';

import '../../widgets/moodify_button.dart';

class MedicationSection extends StatefulWidget {
  const MedicationSection({super.key});

  @override
  State<MedicationSection> createState() => _MedicationSectionState();
}

class _MedicationSectionState extends State<MedicationSection> {
  final _medications = <Medication>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'MEDICAÇÃO',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            if (_medications.isNotEmpty)
              TextButton(
                onPressed: _maybeAddMedication,
                child: const Text('ADICIONAR'),
              ),
          ],
        ),
        _medications.isEmpty
            ? MoodifyFilledButton(
                label: 'Adicionar medicação',
                icon: Icons.add,
                onPressed: _maybeAddMedication,
              )
            : TakenMedicationsCard(medications: _medications),
      ],
    );
  }

  void _maybeAddMedication() async {
    final medication = await showNewMedicationDialog(context);
    if (medication != null) {
      setState(() => _medications.add(medication));
    }
  }
}
