import 'package:flutter/material.dart';

import '../../../models/life_event.dart';
import '../../../widgets/discard_form_alert_dialog.dart';
import 'new_life_event_form.dart';

Future<LifeEvent?> showNewLifeEventDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => const _NewLifeEventDialog(),
  );
}

class _NewLifeEventDialog extends StatefulWidget {
  const _NewLifeEventDialog();

  @override
  State<_NewLifeEventDialog> createState() => _NewLifeEventDialogState();
}

class _NewLifeEventDialogState extends State<_NewLifeEventDialog> {
  final _formKey = GlobalKey<NewLifeEventFormState>();

  NewLifeEventFormState get _formState => _formKey.currentState!;

  void closeWithLifeEvent(LifeEvent lifeEvent) {
    return Navigator.of(context).pop(lifeEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Novo acontecimento'),
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
                  closeWithLifeEvent(_formState.save());
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: NewLifeEventForm(key: _formKey),
        ),
      ),
    );
  }
}
