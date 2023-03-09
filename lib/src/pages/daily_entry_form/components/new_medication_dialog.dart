import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/medication.dart';
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
  State<_NewMedicationDialog> createState() => NewMedicationDialogState();
}

class NewMedicationDialogState extends State<_NewMedicationDialog> {
  final _formKey = GlobalKey<NewMedicationFormState>();

  void closeWithMedication(Medication medication) {
    return Navigator.of(context).pop(medication);
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: this,
      child: Dialog.fullscreen(
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
                onPressed: () {
                  if (_formKey.currentState!.isValid) {
                    final medication = _formKey.currentState!.save();
                    closeWithMedication(medication);
                  }
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: NewMedicationForm(key: _formKey),
          ),
        ),
      ),
    );
  }
}
