import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/daily_entry_form/components/life_event_section.dart';
import 'package:provider/provider.dart';

import '../../../widgets/moodify_text_field.dart';

class LifeEventForm extends StatelessWidget {
  const LifeEventForm({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<LifeEventFormNotifier>();
    return Column(
      children: [
        MoodifyTextField(
          onChanged: notifier.onDescriptionChanged,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: 16),
        SegmentedButton(
          showSelectedIcon: false,
          onSelectionChanged: (p0) => notifier.onImpactRatingChanged(p0.single),
          segments: [
            ButtonSegment(value: -4, label: Text('-4')),
            ButtonSegment(value: -3, label: Text('-3')),
            ButtonSegment(value: -2, label: Text('-2')),
            ButtonSegment(value: -1, label: Text('-1')),
            ButtonSegment(value: 0, label: Text('0')),
            ButtonSegment(value: 1, label: Text('+1')),
            ButtonSegment(value: 2, label: Text('+2')),
            ButtonSegment(value: 3, label: Text('+3')),
            ButtonSegment(value: 4, label: Text('+4')),
          ],
          selected: {notifier.value.impactRating},
        ),
      ],
    );
  }
}
