import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/daily_entry_form/components/life_event_section.dart';
import 'package:moodify_app/src/utils/mirrored_integers_generator.dart';
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
          segments: MirroredIntegersGenerator.generate(length: 9).map((e) {
            return ButtonSegment(value: e, label: Text(_toFormattedString(e)));
          }).toList(),
          selected: {notifier.value.impactRating},
        ),
      ],
    );
  }

  String _toFormattedString(int value) {
    if (value.isNegative) {
      return '$value';
    } else if (value == 0) {
      return '$value';
    } else {
      return '+$value';
    }
  }
}
