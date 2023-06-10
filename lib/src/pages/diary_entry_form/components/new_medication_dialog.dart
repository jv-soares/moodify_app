import 'package:flutter/material.dart';
import 'package:moodify_app/src/widgets/discard_form_alert_dialog.dart';
import 'package:provider/provider.dart';

import '../../../models/taken_medication.dart';
import 'new_medication_form.dart';

Future<TakenMedication?> showNewMedicationDialog(BuildContext context) {
  return showDialog<TakenMedication>(
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

  NewMedicationFormState get _formState => _formKey.currentState!;

  void closeWithMedication(TakenMedication medication) {
    return Navigator.of(context).pop(medication);
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: this,
      child: Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Novo medicamento'),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                if (_formState.isEmpty) return Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (_) => const DiscardFormAlertDialog(),
                );
              },
            ),
            actions: [
              TextButton(
                child: const Text('Salvar'),
                onPressed: () {
                  if (_formState.isValid) {
                    closeWithMedication(_formState.save());
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
