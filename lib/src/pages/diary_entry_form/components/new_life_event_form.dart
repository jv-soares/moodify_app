import 'package:flutter/material.dart';

import '../../../models/life_event.dart';
import '../../../utils/field_validator.dart';
import '../../../widgets/moodify_text_form_field.dart';
import 'form_slider.dart';

class NewLifeEventForm extends StatefulWidget {
  const NewLifeEventForm({super.key});

  @override
  State<NewLifeEventForm> createState() => NewLifeEventFormState();
}

class NewLifeEventFormState extends State<NewLifeEventForm> {
  final _formKey = GlobalKey<FormState>();
  String _description = '';
  int _impactRating = 0;

  bool get isValid => _formKey.currentState!.validate();

  bool get isEmpty => _description.isEmpty;

  LifeEvent save() {
    return LifeEvent(description: _description, impactRating: _impactRating);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MoodifyTextFormField(
            label: 'Descrição',
            isMultiline: true,
            validator: FieldValidator.isNotEmpty,
            onChanged: (value) {
              _description = value;
            },
          ),
          const SizedBox(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormSlider(
                label: 'NÍVEL DE IMPACTO',
                description:
                    'Avalie como este acontecimento impactou o seu humor no dia',
                minLabel: 'Extremamente\nnegativo',
                maxLabel: 'Extremamente\npositivo',
                initialValue: _impactRating.toDouble(),
                min: -4,
                max: 4,
                showLabel: true,
                showDivisions: true,
                onChanged: (value) {
                  _impactRating = value;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
