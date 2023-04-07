import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:moodify_app/src/repositories/diary_entry_repository.dart';
import 'package:moodify_app/src/utils/date_time_utils.dart';

import '../../../app_container.dart';
import '../../../models/diary_entry.dart';

part 'diary_dashboard_state.dart';

class DiaryDashboardNotifier extends ChangeNotifier {
  final _repository = AppContainer.get<DiaryEntryRepository>();

  EpisodeEntry? get selectedEntry => _selectedEntry;
  EpisodeEntry? _selectedEntry;

  DiaryDashboardState get state => _state;
  DiaryDashboardState _state = Initial();

  List<EpisodeEntry>? _allEpisodes;

  EpisodeEntry? get oldestEntry => _allEpisodes?.last;
  EpisodeEntry? get newestEntry => _allEpisodes?.first;

  StreamSubscription? _subscription;

  Future<void> initialize() async {
    _subscription = _repository.watchAll().listen((entries) {
      final newest = entries.first.createdAt;
      final oldest = entries.last.createdAt;
      final episodes = DateTimeUtils.generateList(newest, oldest).map((date) {
        final entryOrNull = entries.singleWhereOrNull(
          (e) => DateTimeUtils.compareDayOfYear(e.createdAt, date),
        );
        return EpisodeEntry(date, entryOrNull);
      }).toList();
      _allEpisodes = episodes;
      _state = Loaded(episodes);
      selectEntry(episodes.first);
    });
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
    resetIndicator();
  }

  int _indicatorIndex = 0;
  int _indicatorShadowIndex = 0;

  double _itemSize = 0;
  set itemSize(double size) => _itemSize = size;

  double get indicatorPosition => _indicatorIndex * _itemSize;

  int onItemFocus(int index) {
    _indicatorShadowIndex = index;
    return index + _indicatorIndex;
  }

  void onItemTap(int index) {
    _indicatorIndex = index - _indicatorShadowIndex;
    notifyListeners();
  }

  void moveIndicatorTo(int index) {
    _indicatorIndex = index;
    notifyListeners();
  }

  void resetIndicator() {
    _indicatorIndex = 0;
    _indicatorShadowIndex = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

class EpisodeEntry {
  final DateTime date;
  final DiaryEntry? diaryEntry;

  const EpisodeEntry(this.date, [this.diaryEntry]);

  bool get hasDiaryEntry => diaryEntry != null;
}
