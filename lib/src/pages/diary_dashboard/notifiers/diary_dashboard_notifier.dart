import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:moodify_app/src/diary_entries.dart';
import 'package:moodify_app/src/utils/date_time_utils.dart';

import '../../../models/diary_entry.dart';

part 'diary_dashboard_state.dart';

class DiaryDashboardNotifier extends ChangeNotifier {
  DiaryDashboardNotifier() {
    _loadEntries();
  }

  EpisodeEntry? get selectedEntry => _selectedEntry;
  EpisodeEntry? _selectedEntry;

  DiaryDashboardState get state => _state;
  DiaryDashboardState _state = Initial();

  void selectEntry(EpisodeEntry entry) {
    _selectedEntry = entry;
    notifyListeners();
  }

  void selectDateRange(DateTime start, DateTime end) {
    if (_state is! Loaded) return;
    final newEntries = (_state as Loaded)
        .entries
        .where((entry) => entry.date.isBetween(start, end))
        .toList();
    _state = Loaded(newEntries);
    notifyListeners();
    selectEntry(newEntries.first);
  }

  Future<void> _loadEntries() async {
    _state = Loading();
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    final sortedEntries = diaryEntries.sortedByCompare(
      (e) => e.createdAt,
      (a, b) => b.compareTo(a),
    )..removeWhere((element) => element.createdAt.day == 26);
    final oldest = sortedEntries.first.createdAt;
    final newest = sortedEntries.last.createdAt;
    final episodes = DateTimeUtils.generateList(oldest, newest).map((date) {
      final entryOrNull = sortedEntries.singleWhereOrNull(
        (e) => DateTimeUtils.compareDayOfYear(e.createdAt, date),
      );
      return EpisodeEntry(date, entryOrNull);
    }).toList();
    _state = Loaded(episodes);
    selectEntry(episodes.first);
  }
}

class EpisodeEntry {
  final DateTime date;
  final DiaryEntry? diaryEntry;

  const EpisodeEntry(this.date, [this.diaryEntry]);

  bool get hasDiaryEntry => diaryEntry != null;
}
