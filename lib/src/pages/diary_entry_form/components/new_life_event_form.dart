import 'package:flutter/material.dart';

import '../../../models/life_event.dart';
import '../../../utils/field_validator.dart';
import '../../../widgets/moodify_text_form_field.dart';
import 'form_slider.dart';

class NewLifeEventForm extends StatefulWidget {
  final LifeEvent? lifeEvent;

  const NewLifeEventForm({super.key, this.lifeEvent});

  @override
  State<NewLifeEventForm> createState() => NewLifeEventFormState();
}

class NewLifeEventFormState extends State<NewLifeEventForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  int _impactRating = 0;

  bool get isValid => _formKey.currentState!.validate();

  bool get isEmpty => _descriptionController.text.isEmpty;

  @override
  void initState() {
    super.initState();
    if (widget.lifeEvent != null) _edit(widget.lifeEvent!);
  }

  @override
  void didUpdateWidget(covariant NewLifeEventForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.lifeEvent != null) _edit(widget.lifeEvent!);
  }

  LifeEvent save() {
    return LifeEvent(
      description: _descriptionController.text,
      impactRating: _impactRating,
    );
  }

  void _edit(LifeEvent lifeEvent) {
    _descriptionController.text = lifeEvent.description;
    _impactRating = lifeEvent.impactRating;
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
            controller: _descriptionController,
            validator: FieldValidator.isNotEmpty,
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
                value: _impactRating,
                min: -4,
                max: 4,
                showLabel: true,
                showDivisions: true,
                onChanged: (value) {
                  setState(() => _impactRating = value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
