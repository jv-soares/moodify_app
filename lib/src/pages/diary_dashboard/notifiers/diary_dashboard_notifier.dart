import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moodify_app/src/services/diary_entry_service.dart';
import 'package:moodify_app/src/utils/date_time_utils.dart';

import '../../../app_container.dart';
import '../../../models/diary_entry.dart';

part 'diary_dashboard_state.dart';

class DiaryDashboardNotifier extends ChangeNotifier {
  final _service = AppContainer.get<DiaryEntryService>();

  DiaryDashboardNotifier() {
    initialize();
  }

  DiaryDashboardState get state => _state;
  DiaryDashboardState _state = LoadingDiary();

  List<EpisodeEntry>? _allEpisodes;

  EpisodeEntry? get oldestEntry => _allEpisodes?.last;
  EpisodeEntry? get newestEntry => _allEpisodes?.first;

  bool get isEmpty => _state is! Loaded || _allEpisodes == null;

  bool get notEnoughData => isEmpty || _allEpisodes!.length < 2;

  StreamSubscription? _subscription;

  bool canAddEntryAt(DateTime date) {
    if (_allEpisodes == null) return true;
    return addableDays.any((element) {
      return DateTimeUtils.compareDayOfYear(element, date);
    });
  }

  List<DateTime> get addableDays {
    final now = DateTime.now();
    final lastWeek = DateTimeUtils.generateList(
      now,
      now.subtract(const Duration(days: 7)),
    );
    if (_allEpisodes == null) return lastWeek;
    final allDates = _allEpisodes!
        .map((e) => e.diaryEntry?.createdAt)
        .whereNotNull()
        .toList();
    final addable = <DateTime>[];
    for (final day in lastWeek) {
      if (allDates.none((element) => element.isSameDayMonthAndYear(day))) {
        addable.add(day);
      }
    }
    return addable;
  }

  Future<void> initialize() async {
    _subscription =
        _service.watchAll().map(_transformDiaryEntry).listen((episodes) {
      _allEpisodes = episodes;
      _state = Loaded(episodes);
      if (_selectedEntry == null) {
        selectEntry(0);
      } else {
        selectEntry(_indicatorIndex);
      }
      notifyListeners();
    });
  }

  List<EpisodeEntry> _transformDiaryEntry(List<DiaryEntry> entries) {
    if (entries.isEmpty) return [];
    final newest = entries.first.createdAt;
    final oldest = entries.last.createdAt;
    return DateTimeUtils.generateList(newest, oldest).map((date) {
      final entryOrNull = entries.singleWhereOrNull(
        (e) => DateUtils.isSameDay(e.createdAt, date),
      );
      return EpisodeEntry(date, entryOrNull);
    }).toList();
  }

  EpisodeEntry? get selectedEntry => _selectedEntry;
  EpisodeEntry? _selectedEntry;

  void selectEntry(int index) {
    _selectedEntry = _filteredEpisodes[index];
    notifyListeners();
  }

  DateTime _start = DateTime.now().subtract(const Duration(days: 360));
  DateTime _end = DateTime.now();

  List<EpisodeEntry> get _filteredEpisodes => _allEpisodes!
      .where((entry) => entry.date.isBetween(_start, _end))
      .toList();

  void selectDateRange(DateTime start, DateTime end) {
    if (_allEpisodes == null) return;
    _start = start;
    _end = end;
    _state = Loaded(_filteredEpisodes);
    selectEntry(0);
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

class EpisodeEntry extends Equatable {
  final DateTime date;
  final DiaryEntry? diaryEntry;

  const EpisodeEntry(this.date, [this.diaryEntry]);

  bool get hasDiaryEntry => diaryEntry != null;

  @override
  List<Object?> get props => [date, diaryEntry];
}
