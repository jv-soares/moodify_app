import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodify_app/src/utils/string_x.dart';
import 'package:moodify_app/src/widgets/moodify_info_chip.dart';

import '../../../models/diary_entry.dart';
import '../../../widgets/moodify_draggable_bottom_sheet.dart';
import 'statistics_cards.dart';

class StatisticsDraggableBottomSheet extends StatelessWidget {
  final List<DiaryEntry> entries;

  const StatisticsDraggableBottomSheet({
    super.key,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return MoodifyDraggableBottomSheet(
      initialChildSize: .5,
      minChildSize: .5,
      content: Column(
        children: [
          StatisticsCards(entries: entries),
          const SizedBox(height: 48),
          ...entries.map(DiaryEntryListTile.new).toList(),
        ],
      ),
    );
  }
}

class DiaryEntryListTile extends StatelessWidget {
  final DiaryEntry entry;

  const DiaryEntryListTile(this.entry, {super.key});

  @override
  Widget build(BuildContext context) {
    final onBackgroundColor = Theme.of(context).colorScheme.onBackground;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.episode.name,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                DateFormat.MMMMEEEEd().format(entry.createdAt).capitalize(),
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: onBackgroundColor.withOpacity(.5)),
              ),
            ],
          ),
          Row(
            children: [
              MoodifyInfoChip(
                Icons.bedtime_outlined,
                '${entry.hoursOfSleep} h',
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              MoodifyInfoChip(
                Icons.mood,
                entry.moodRating.toString(),
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
