import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_entry_form/components/new_life_event_dialog.dart';
import 'package:moodify_app/src/widgets/life_event_container.dart';
import 'package:provider/provider.dart';

import '../../../models/life_event.dart';
import '../../../widgets/moodify_button.dart';
import '../view_models/diary_entry_view_model.dart';

class LifeEventSection extends StatefulWidget {
  const LifeEventSection({super.key});

  @override
  State<LifeEventSection> createState() => _LifeEventSectionState();
}

class _LifeEventSectionState extends State<LifeEventSection> {
  LifeEvent? _lifeEvent;

  void _updateLifeEvent(LifeEvent? newLifeEvent) {
    setState(() => _lifeEvent = newLifeEvent);
    context.read<DiaryEntryViewModel>().lifeEvent = newLifeEvent;
  }

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
        _lifeEvent != null
            ? LifeEventContainer(
                _lifeEvent!,
                onEditPressed: () {
                  showNewLifeEventDialog(context, lifeEvent: _lifeEvent)
                      .then(_updateLifeEvent);
                },
                onDeletePressed: () {
                  setState(() => _lifeEvent = null);
                },
              )
            : MoodifyFilledButton(
                label: 'Adicionar acontecimento',
                icon: Icons.add,
                onPressed: () {
                  showNewLifeEventDialog(context).then(_updateLifeEvent);
                },
              ),
      ],
    );
  }
}
