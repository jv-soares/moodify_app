import 'package:flutter/material.dart';

import '../../model/symptom.dart';
import 'components/descriptive_values.dart';
import 'components/form_slider.dart';
import 'components/life_event_section.dart';
import 'components/medication_section.dart';
import 'components/observation_section.dart';
import 'components/symptom_checker.dart';
import 'notifiers/daily_entry_form_notifier.dart';
import 'view_models/diary_entry_view_model.dart';

class DailyEntryFormPage extends StatefulWidget {
  const DailyEntryFormPage({super.key});

  @override
  State<DailyEntryFormPage> createState() => _DailyEntryFormPageState();
}

class _DailyEntryFormPageState extends State<DailyEntryFormPage> {
  final _notifier = DailyEntryFormNotifier();
  final _viewModel = DiaryEntryViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro diário'),
      ),
      floatingActionButton: ValueListenableBuilder(
          valueListenable: _notifier,
          builder: (context, value, _) {
            if (value is Loading) {
              return const FloatingActionButton(
                onPressed: null,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
              );
            } else {
              return FloatingActionButton(
                onPressed: () => _notifier.save(_viewModel),
                child: const Icon(Icons.check),
              );
            }
          }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              FormSlider(
                label: 'Como você se sente?',
                values: functionalImpairment,
                initialValue: _viewModel.functionalImpairment.toDouble(),
                onChanged: (value) {
                  _viewModel.functionalImpairment = value;
                },
              ),
              _formSpacing,
              FormSlider(
                label: 'Como está seu humor?',
                values: mood,
                initialValue: _viewModel.moodRating.toDouble(),
                onChanged: (value) {
                  _viewModel.moodRating = value;
                },
              ),
              _formSpacing,
              FormSlider(
                label: 'Quantas horas você dormiu?',
                values: List.generate(11, (index) => DescriptiveValue(index)),
                onChanged: (value) {
                  _viewModel.hoursOfSleep = value;
                },
                showLabel: true,
              ),
              _formSpacing,
              SymptomChecker(
                symptoms: Symptom.values,
                onSymptomsChanged: (symptoms) {
                  _viewModel.symptoms = symptoms;
                },
              ),
              _formSpacing,
              MedicationSection(
                onChanged: (value) {
                  _viewModel.medications = value;
                },
              ),
              _formSpacing,
              LifeEventSection(
                onChanged: (value) {
                  _viewModel.lifeEvent = value;
                },
              ),
              _formSpacing,
              ObservationSection(
                onChanged: (value) {
                  _viewModel.observations = value;
                },
              ),
              _formSpacing,
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get _formSpacing => const SizedBox(height: 48);

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }
}
