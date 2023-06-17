import 'package:flutter/material.dart';

import '../../../models/life_event.dart';
import '../../../widgets/discard_form_alert_dialog.dart';
import 'new_life_event_form.dart';

Future<LifeEvent?> showNewLifeEventDialog(
  BuildContext context, {
  LifeEvent? lifeEvent,
}) {
  return showDialog(
    context: context,
    builder: (_) => _NewLifeEventDialog(lifeEvent),
  );
}

class _NewLifeEventDialog extends StatefulWidget {
  final LifeEvent? lifeEvent;

  const _NewLifeEventDialog([this.lifeEvent]);

  @override
  State<_NewLifeEventDialog> createState() => _NewLifeEventDialogState();
}

class _NewLifeEventDialogState extends State<_NewLifeEventDialog> {
  final _formKey = GlobalKey<NewLifeEventFormState>();

  NewLifeEventFormState get _formState => _formKey.currentState!;

  bool get isEditing => widget.lifeEvent != null;

  void closeWithLifeEvent(LifeEvent lifeEvent) {
    return Navigator.of(context).pop(lifeEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            isEditing ? 'Editar acontecimento' : 'Novo acontecimento',
          ),
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
          child: NewLifeEventForm(key: _formKey, lifeEvent: widget.lifeEvent),
        ),
      ),
    );
  }
}
