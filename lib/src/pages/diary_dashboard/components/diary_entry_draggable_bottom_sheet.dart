import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodify_app/src/app.dart';
import 'package:moodify_app/src/models/life_event.dart';
import 'package:moodify_app/src/models/symptom.dart';
import 'package:moodify_app/src/pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'package:moodify_app/src/utils/string_x.dart';
import 'package:moodify_app/src/widgets/life_event_container.dart';
import 'package:moodify_app/src/widgets/moodify_draggable_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../models/diary_entry.dart';
import '../../../models/taken_medication.dart';
import '../../../widgets/moodify_info_chip.dart';
import '../../../widgets/moodify_primary_container.dart';

class DiaryEntryDraggableBottomSheet extends StatelessWidget {
  const DiaryEntryDraggableBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    const chartHeight = 28 * 13;
    final screenHeight = MediaQuery.of(context).size.height;
    return MoodifyDraggableBottomSheet(
      initialChildSize: chartHeight / screenHeight,
      minChildSize: chartHeight / screenHeight,
      content: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final notifier = context.watch<DiaryDashboardNotifier>();
    if (notifier.state is LoadingDiary) {
      return Container(
        margin: const EdgeInsets.only(top: 100),
        child: const CircularProgressIndicator(),
      );
    } else if (notifier.state is Loaded) {
      final entry = notifier.selectedEntry!.diaryEntry!;
      return Column(
        children: [
          _Header(entry),
          if (entry.lifeEvent != null) _LifeEventSection(entry.lifeEvent!),
          if (entry.medications.isNotEmpty)
            _MedicationsSection(entry.medications),
          if (entry.observations != '' && entry.observations != null)
            _ObservationsSection(entry.observations!),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}

class _Header extends StatelessWidget {
  final DiaryEntry entry;

  const _Header(this.entry);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              entry.episode.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.diaryForm,
                  arguments: entry,
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              child: const Text('EDITAR'),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Text(
              DateFormat.MMMMEEEEd().format(entry.createdAt).capitalize(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            MoodifyInfoChip(
              Icons.bedtime_outlined,
              '${entry.hoursOfSleep} horas',
            ),
            MoodifyInfoChip(Icons.mood, entry.moodRating.toString()),
            ...entry.symptoms
                .map((e) => MoodifyInfoChip(e.icon, e.localizedName))
                .toList(),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _LifeEventSection extends StatelessWidget {
  final LifeEvent lifeEvent;

  const _LifeEventSection(this.lifeEvent);

  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      label: 'Acontecimento',
      child: LifeEventContainer(lifeEvent),
    );
  }
}

class _MedicationsSection extends StatelessWidget {
  final List<TakenMedication> medications;

  const _MedicationsSection(this.medications);

  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      label: 'Medicamentos',
      child: MoodifyPrimaryContainer(
        padding: EdgeInsets.zero,
        child: Column(
          children: medications.map(_MedicationListItem.new).toList(),
        ),
      ),
    );
  }
}

class _MedicationListItem extends StatelessWidget {
  final TakenMedication medication;

  const _MedicationListItem(this.medication, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medication.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              Text(
                '${medication.dose.value.toInt()} ${medication.dose.unitOfMeasurement.name}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Center(
              child: Text(
                medication.tabletsTaken.toString(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ObservationsSection extends StatelessWidget {
  final String observations;

  const _ObservationsSection(this.observations);

  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      label: 'Observações',
      child: MoodifyPrimaryContainer(
        width: double.infinity,
        child: Text(
          observations,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  final String label;
  final Widget child;

  const _SectionContainer({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
