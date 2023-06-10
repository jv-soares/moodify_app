import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_entry_form/components/new_life_event_dialog.dart';

import '../../../models/life_event.dart';
import '../../../widgets/moodify_button.dart';

class LifeEventSection extends StatefulWidget {
  final ValueChanged<LifeEvent> onChanged;

  const LifeEventSection({super.key, required this.onChanged});

  @override
  State<LifeEventSection> createState() => _LifeEventSectionState();
}

class _LifeEventSectionState extends State<LifeEventSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'ACONTECIMENTO',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 16),
        MoodifyFilledButton(
          label: 'Adicionar acontecimento',
          icon: Icons.add,
          onPressed: () {
            showNewLifeEventDialog(context);
          },
        ),
      ],
    );
  }
}
