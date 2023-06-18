import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/taken_medication.dart';
import '../notifiers/medication_notifier.dart';

class TakenMedicationsCard extends StatelessWidget {
  final List<TakenMedication> medications;

  const TakenMedicationsCard(this.medications, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: medications.map((e) => _MedicationListItem(e)).toList(),
      ),
    );
  }
}

class _MedicationListItem extends StatefulWidget {
  final TakenMedication medication;

  const _MedicationListItem(this.medication);

  @override
  State<_MedicationListItem> createState() => _MedicationListItemState();
}

class _MedicationListItemState extends State<_MedicationListItem> {
  @override
  Widget build(BuildContext context) {
    final medicationsNotifier = context.read<MedicationsNotifier>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.medication.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                widget.medication.dose.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Row(
            children: [
              _buildButton(
                Icons.remove,
                () => medicationsNotifier.decrementTabletsTaken(
                  widget.medication.id!,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                widget.medication.tabletsTaken.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 16),
              _buildButton(
                Icons.add,
                () => medicationsNotifier.incrementTabletsTaken(
                  widget.medication.id!,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
