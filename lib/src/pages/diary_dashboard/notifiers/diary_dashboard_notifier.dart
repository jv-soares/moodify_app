import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:moodify_app/src/diary_entries.dart';

import '../../../models/diary_entry.dart';

part 'diary_dashboard_state.dart';

class DiaryDashboardNotifier extends ChangeNotifier {
  DiaryDashboardNotifier() {
    _loadEntries();
  }

  DiaryEntry? get selectedEntry => _selectedEntry;
  DiaryEntry? _selectedEntry;

  List<DiaryEntry>? get _entries {
    if (_dashboardState is! Loaded) return null;
    return (_dashboardState as Loaded).entries;
  }

  DiaryEntry? get oldestEntry => _entries?.last;

  DiaryEntry? get newestEntry => _entries?.first;

  DiaryDashboardState get dashboardState => _dashboardState;
  DiaryDashboardState _dashboardState = Initial();

  void selectEntry(DiaryEntry entry) {
    _selectedEntry = entry;
    notifyListeners();
  }

  void selectDateRange(DateTime start, DateTime end) {
    print('selected from $start to $end');
  }

  Future<void> _loadEntries() async {
    _dashboardState = Loading();
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    final sortedEntries = diaryEntries.sortedByCompare(
      (e) => e.createdAt,
      (a, b) => b.compareTo(a),
    );
    _dashboardState = Loaded(sortedEntries);
    selectEntry(diaryEntries.first);
  }
}
