import 'package:flutter/material.dart';

import '../../model/medication.dart';
import 'new_medication_form.dart';

Future<Medication?> showNewMedicationDialog(BuildContext context) {
  return showDialog<Medication>(
    context: context,
    builder: (_) => const _NewMedicationDialog(),
  );
}

class _NewMedicationDialog extends StatefulWidget {
  const _NewMedicationDialog();

  @override
  State<_NewMedicationDialog> createState() => _NewMedicationDialogState();
}

class _NewMedicationDialogState extends State<_NewMedicationDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Novo medicamento'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: Navigator.of(context).pop,
          ),
          actions: [
            TextButton(
              child: const Text('Salvar'),
              onPressed: () => Navigator.of(context).pop(medication),
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: NewMedicationForm(),
        ),
      ),
    );
  }
}

final medication = Medication(
  id: '1',
  name: 'Omeprazol',
  tabletsTaken: 0,
  dose: Dose(300, 'mg'),
);
