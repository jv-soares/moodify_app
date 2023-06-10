import 'package:flutter/material.dart';

class DiscardFormAlertDialog extends StatelessWidget {
  const DiscardFormAlertDialog({super.key});

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
