import 'package:flutter/material.dart';

import '../../model/medication.dart';

class TakenMedicationsCard extends StatelessWidget {
  final List<Medication> medications;

  const TakenMedicationsCard({super.key, required this.medications});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: medications
            .map((e) => _MedicationListItem(e, onAmountChanged: (amount) {}))
            .toList(),
      ),
    );
  }
}

class _MedicationListItem extends StatefulWidget {
  final Medication medication;
  final ValueChanged<int> onAmountChanged;

  const _MedicationListItem(
    this.medication, {
    required this.onAmountChanged,
  });

  @override
  State<_MedicationListItem> createState() => _MedicationListItemState();
}

class _MedicationListItemState extends State<_MedicationListItem> {
  int _amount = 0;

  @override
  Widget build(BuildContext context) {
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
                '${widget.medication.dose.value} ${widget.medication.dose.unitOfMeasurement}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Row(
            children: [
              _buildButton(Icons.remove, () {
                if (_amount > 0) setState(() => _amount--);
              }),
              const SizedBox(width: 16),
              Text(
                _amount.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 16),
              _buildButton(Icons.add, () => setState(() => _amount++)),
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
