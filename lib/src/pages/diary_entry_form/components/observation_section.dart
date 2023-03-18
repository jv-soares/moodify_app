import 'package:flutter/material.dart';
import '../../../widgets/moodify_text_field.dart';

class ObservationSection extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const ObservationSection({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'OBSERVAÇÕES',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 16),
        MoodifyTextField(onChanged: onChanged),
      ],
    );
  }
}
