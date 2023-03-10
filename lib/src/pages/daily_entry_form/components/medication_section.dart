import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/medication.dart';
import '../../../widgets/moodify_button.dart';
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

  void _notifyOnChanged() => widget.onChanged(_medicationsNotifier.value);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _medicationsNotifier,
      child: ValueListenableBuilder(
          valueListenable: _medicationsNotifier,
          builder: (context, medications, _) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'MEDICAÇÃO',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    if (medications.isNotEmpty)
                      TextButton(
                        onPressed: _maybeAddMedication,
                        child: const Text('ADICIONAR'),
                      ),
                  ],
                ),
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
            );
          }),
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

class MedicationsNotifier extends ValueNotifier<List<Medication>> {
  MedicationsNotifier() : super([]);

  void add(Medication medication) {
    value = [...value, medication];
  }

  void remove(Medication medication) {
    value = value..remove(medication);
  }

  void incrementTabletsTaken(String medicationId) {
    final index = value.indexWhere((e) => e.id == medicationId);
    final medication = value[index];
    if (medication.tabletsTaken >= 10) return;
    _updateMedicationAt(index, medication.incrementedTablets());
  }

  void decrementTabletsTaken(String medicationId) {
    final index = value.indexWhere((e) => e.id == medicationId);
    final medication = value[index];
    if (medication.tabletsTaken <= 0) return;
    _updateMedicationAt(index, medication.decrementedTablets());
  }

  void _updateMedicationAt(int index, Medication medication) {
    value = [
      ...value
        ..removeAt(index)
        ..insert(index, medication)
    ];
  }

  bool get isEmpty => value.isEmpty;
}
