import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:moodify_app/src/repositories/diary_entry_repository.dart';
import 'package:moodify_app/src/utils/date_time_utils.dart';

import '../../../models/diary_entry.dart';

part 'diary_dashboard_state.dart';

class DiaryDashboardNotifier extends ChangeNotifier {
  final _repository = TempDiaryEntryRepository();

  EpisodeEntry? get selectedEntry => _selectedEntry;
  EpisodeEntry? _selectedEntry;

  DiaryDashboardState get state => _state;
  DiaryDashboardState _state = Initial();

  List<EpisodeEntry>? _allEpisodes;

  EpisodeEntry? get oldestEntry => _allEpisodes?.first;
  EpisodeEntry? get newestEntry => _allEpisodes?.last;

  Future<void> initialize() async {
    final entries = await _repository.readAll();
    final newest = entries.first.createdAt;
    final oldest = entries.last.createdAt;
    final episodes = DateTimeUtils.generateList(oldest, newest).map((date) {
      final entryOrNull = entries.singleWhereOrNull(
        (e) => DateTimeUtils.compareDayOfYear(e.createdAt, date),
      );
      return EpisodeEntry(date, entryOrNull);
    }).toList();
    _allEpisodes = episodes;
    _state = Loaded(episodes);
    selectEntry(episodes.first);
  }

  void selectEntry(EpisodeEntry entry) {
    _selectedEntry = entry;
    notifyListeners();
  }

  void selectDateRange(DateTime start, DateTime end) {
    if (_allEpisodes == null) return;
    final newEntries = _allEpisodes!
        .where((entry) => entry.date.isBetween(start, end))
        .toList();
    _state = Loaded(newEntries);
    notifyListeners();
    selectEntry(newEntries.first);
  }
}

class EpisodeEntry {
  final DateTime date;
  final DiaryEntry? diaryEntry;

  const EpisodeEntry(this.date, [this.diaryEntry]);

  bool get hasDiaryEntry => diaryEntry != null;
}
