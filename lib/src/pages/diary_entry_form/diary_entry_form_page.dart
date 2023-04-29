import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_entry_form/components/form_slider.dart';
import 'package:provider/provider.dart';

import '../../models/symptom.dart';
import 'components/life_event_section.dart';
import 'components/medication_section.dart';
import 'components/observation_section.dart';
import 'components/symptom_checker.dart';
import 'notifiers/diary_entry_form_notifier.dart';
import 'view_models/diary_entry_view_model.dart';

class DiaryEntryFormPage extends StatefulWidget {
  final VoidCallback onFormSaved;

  const DiaryEntryFormPage({super.key, required this.onFormSaved});

  @override
  State<DiaryEntryFormPage> createState() => _DiaryEntryFormPageState();
}

class _DiaryEntryFormPageState extends State<DiaryEntryFormPage> {
  final _notifier = DiaryEntryFormNotifier();

  @override
  void initState() {
    super.initState();
    _notifier.addListener(_navigateWhenSaved);
  }

  void _navigateWhenSaved() {
    if (_notifier.value is Saved) widget.onFormSaved();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<DiaryEntryViewModel>();
    return Scaffold(
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
            return FloatingActionButton.extended(
              onPressed: () => _notifier.save(viewModel),
              label: const Text('Salvar'),
              icon: const Icon(Icons.check),
            );
          }
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              FormSlider(
                label: 'Como está seu humor?',
                min: 0,
                max: 100,
                initialValue: viewModel.moodRating.toDouble(),
                showLabel: true,
                onChanged: (value) {
                  viewModel.moodRating = value;
                },
              ),
              _formSpacing,
              FormSlider(
                label: 'Quantas horas você dormiu?',
                min: 0,
                max: 10,
                showDivisions: true,
                onChanged: (value) {
                  viewModel.hoursOfSleep = value;
                },
                showLabel: true,
              ),
              _formSpacing,
              SymptomChecker(
                symptoms: Symptom.values,
                onSymptomsChanged: (symptoms) {
                  viewModel.symptoms = symptoms;
                },
              ),
              _formSpacing,
              MedicationSection(
                onChanged: (value) {
                  viewModel.medications = value;
                },
              ),
              _formSpacing,
              LifeEventSection(
                onChanged: (value) {
                  viewModel.lifeEvent = value;
                },
              ),
              _formSpacing,
              ObservationSection(
                onChanged: (value) {
                  viewModel.observations = value;
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
    _notifier.removeListener(_navigateWhenSaved);
    _notifier.dispose();
    super.dispose();
  }
}
