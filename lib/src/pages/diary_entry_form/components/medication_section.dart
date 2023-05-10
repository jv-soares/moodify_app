import 'package:flutter/material.dart';
import 'package:moodify_app/src/widgets/fetch_notifier_builder.dart';
import 'package:provider/provider.dart';

import '../../../models/medication.dart';
import '../../../widgets/moodify_button.dart';
import '../notifiers/medication_notifier.dart';
import 'new_medication_dialog.dart';
import 'taken_medication_card.dart';

class MedicationSection extends StatefulWidget {
  final ValueChanged<List<Medication>> onChanged;

  const MedicationSection({super.key, required this.onChanged});

  @override
  State<MedicationSection> createState() => _MedicationSectionState();
}

class _MedicationSectionState extends State<MedicationSection> {
  final _medicationsNotifier = MedicationsNotifier();

  @override
  void initState() {
    super.initState();
    _medicationsNotifier.addListener(_notifyOnChanged);
  }

  void _notifyOnChanged() => widget.onChanged(_medicationsNotifier.data!);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _medicationsNotifier,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MEDICAÇÃO',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              FetchNotifierBuilder(
                notifier: _medicationsNotifier,
                onSuccess: (medications) {
                  if (medications.isNotEmpty) {
                    return TextButton(
                      onPressed: _maybeAddMedication,
                      child: const Text('ADICIONAR'),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          FetchNotifierBuilder(
            notifier: _medicationsNotifier,
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
                        onPressed: _maybeAddMedication,
                      )
                    : TakenMedicationsCard(medications),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _maybeAddMedication() async {
    final medication = await showNewMedicationDialog(context);
    if (medication != null) _medicationsNotifier.add(medication);
  }

  @override
  void dispose() {
    _medicationsNotifier.removeListener(_notifyOnChanged);
    _medicationsNotifier.dispose();
    super.dispose();
  }
}
