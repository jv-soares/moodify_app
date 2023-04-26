import 'package:flutter/material.dart';

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
      initialChildSize: .6,
      minChildSize: .6,
      content: Column(
        children: [
          StatisticsCards(entries: entries),
        ],
      ),
    );
  }
}
