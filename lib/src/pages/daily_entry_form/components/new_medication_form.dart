import 'package:flutter/material.dart';
import 'package:moodify_app/src/widgets/moodify_text_form_field.dart';

class NewMedicationForm extends StatelessWidget {
  const NewMedicationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MoodifyTextFormField(
            label: 'Nome',
            onChanged: (value) {},
          ),
          const SizedBox(height: 24),
          MoodifyTextFormField(
            label: 'Dose',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
