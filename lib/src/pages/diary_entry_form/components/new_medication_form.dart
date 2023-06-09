import 'package:flutter/material.dart';

import '../../../models/taken_medication.dart';
import '../../../widgets/moodify_dropdown_form_field.dart';
import '../../../widgets/moodify_text_form_field.dart';

class NewMedicationForm extends StatefulWidget {
  const NewMedicationForm({super.key});

  @override
  State<NewMedicationForm> createState() => NewMedicationFormState();
}

class NewMedicationFormState extends State<NewMedicationForm> {
  final _formKey = GlobalKey<FormState>();
  var _name = '';
  var _dose = 0.0;
  var _unitOfMeasurement = UnitOfMeasurement.g;

  bool get isEmpty => _name.isEmpty && _dose == 0;

  bool get isValid => _formKey.currentState!.validate();

  TakenMedication save() {
    return TakenMedication(
      name: _name,
      tabletsTaken: 1,
      dose: Dose(_dose, _unitOfMeasurement),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MoodifyTextFormField(
            label: 'Nome',
            onChanged: (value) => _name = value,
            validator: _emptyFieldValidator,
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 3,
                child: MoodifyTextFormField(
                  label: 'Dose',
                  onChanged: (value) => _dose = double.parse(value),
                  validator: _emptyFieldValidator,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MoodifyDropdownFormField(
                  value: _unitOfMeasurement,
                  items: UnitOfMeasurement.values,
                  onChanged: (value) {
                    setState(() => _unitOfMeasurement = value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? _emptyFieldValidator(String? text) {
    if (text == '') return 'Campo obrigatório';
    return null;
  }
}
