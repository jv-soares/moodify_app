import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/medication.dart';
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

  NewMedicationFormState get _formState => _formKey.currentState!;

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
              onPressed: () {
                if (_formState.isEmpty) return Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (_) => _DiscardFormAlertDialog(),
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

class _DiscardFormAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Deseja descartar o formulário?'),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: const Text('Descartar'),
        ),
      ],
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    );
  }
}
