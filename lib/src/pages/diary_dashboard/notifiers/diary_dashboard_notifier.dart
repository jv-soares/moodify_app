import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:moodify_app/src/diary_entries.dart';

import '../../../models/diary_entry.dart';

part 'diary_dashboard_state.dart';

class DiaryDashboardNotifier extends ChangeNotifier {
  DiaryDashboardNotifier() {
    _loadEntries();
  }

  DiaryEntry get selectedEntry => _selectedEntry;
  late DiaryEntry _selectedEntry;

  DiaryDashboardState get dashboardState => _dashboardState;
  DiaryDashboardState _dashboardState = Initial();

  void selectEntry(DiaryEntry entry) {
    _selectedEntry = entry;
    notifyListeners();
  }

  Future<void> _loadEntries() async {
    _dashboardState = Loading();
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    final sortedEntries = diaryEntries.sortedByCompare(
      (e) => e.createdAt,
      (a, b) => b.compareTo(a),
    );
    _dashboardState = Loaded(sortedEntries..addAll(diaryEntries));
    selectEntry(diaryEntries.first);
  }
}
