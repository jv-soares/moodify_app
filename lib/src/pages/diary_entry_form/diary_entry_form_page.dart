import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodify_app/src/pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'package:moodify_app/src/pages/diary_entry_form/components/form_slider.dart';
import 'package:moodify_app/src/utils/date_time_utils.dart';
import 'package:provider/provider.dart';

import '../../models/symptom.dart';
import 'components/descriptive_form_slider.dart';
import 'components/descriptive_values.dart';
import 'components/life_event_section.dart';
import 'components/medication_section.dart';
import 'components/observation_section.dart';
import 'components/symptom_checker.dart';
import 'notifiers/diary_entry_form_notifier.dart';
import 'view_models/diary_entry_view_model.dart';

class DiaryEntryFormPage extends StatefulWidget {
  const DiaryEntryFormPage({super.key});

  @override
  State<DiaryEntryFormPage> createState() => _DiaryEntryFormPageState();
}

class _DiaryEntryFormPageState extends State<DiaryEntryFormPage> {
  DateTime _selectedDate = DateTime.now();
  final _notifier = DiaryEntryFormNotifier();
  final _viewModel = DiaryEntryViewModel();

  DateTime get _today => DateTime.now();

  @override
  void initState() {
    super.initState();
    _notifier.addListener(_navigateWhenSaved);
  }

  void _navigateWhenSaved() {
    if (_notifier.value is Saved) Navigator.of(context).pop();
  }

  String _getFormattedDate() {
    final yesterday = _today.subtract(const Duration(days: 1));
    if (DateTimeUtils.compareDayOfYear(_selectedDate, _today)) {
      return 'Hoje';
    } else if (DateTimeUtils.compareDayOfYear(_selectedDate, yesterday)) {
      return 'Ontem';
    }
    return DateFormat.MMMMd().format(_selectedDate);
  }

  void _selectDate() async {
    final notifier = context.read<DiaryDashboardNotifier>();
    final date = await showDatePicker(
      context: context,
      initialDate: notifier.addableDays.first,
      firstDate: _today.subtract(const Duration(days: 7)),
      lastDate: _today,
      selectableDayPredicate: notifier.canAddEntryAt,
    );
    if (date != null) {
      setState(() => _selectedDate = date);
      _viewModel.createdAt = _selectedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getFormattedDate()),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _selectDate,
            icon: const Icon(Icons.edit_calendar),
          ),
        ],
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
            return FloatingActionButton.extended(
              onPressed: () => _notifier.save(_viewModel),
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
              DescriptiveFormSlider(
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
                min: 0,
                max: 100,
                initialValue: _viewModel.moodRating.toDouble(),
                showLabel: true,
                onChanged: (value) {
                  _viewModel.moodRating = value;
                },
              ),
              _formSpacing,
              FormSlider(
                label: 'Quantas horas você dormiu?',
                min: 0,
                max: 10,
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
    _notifier.removeListener(_navigateWhenSaved);
    _notifier.dispose();
    super.dispose();
  }
}
