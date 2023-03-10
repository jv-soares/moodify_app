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
            final valueString = e.isNegative ? '$e' : '+$e';
            return ButtonSegment(value: e, label: Text(valueString));
          }).toList(),
          selected: {notifier.value.impactRating},
        ),
      ],
    );
  }
}
