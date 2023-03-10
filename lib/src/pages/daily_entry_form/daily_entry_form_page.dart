import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/daily_entry_form/components/medication_section.dart';

import '../../model/symptom.dart';
import 'components/form_slider.dart';
import 'components/symptom_checker.dart';

class DailyEntryFormPage extends StatelessWidget {
  const DailyEntryFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro diário'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              FormSlider(
                label: 'Como você se sente?',
                values: functionalImpairment,
                onChanged: (value) {},
              ),
              _formSpacing,
              FormSlider(
                label: 'Como está seu humor?',
                values: mood,
                onChanged: (value) {},
              ),
              _formSpacing,
              FormSlider(
                label: 'Quantas horas você dormiu?',
                values: List.generate(11, (index) => DescriptiveValue(index)),
                onChanged: (value) {},
                showLabel: true,
              ),
              _formSpacing,
              SymptomChecker(
                symptoms: Symptom.values,
                onSymptomsChanged: (symptoms) {},
              ),
              _formSpacing,
              MedicationSection(
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get _formSpacing => const SizedBox(height: 48);
}
