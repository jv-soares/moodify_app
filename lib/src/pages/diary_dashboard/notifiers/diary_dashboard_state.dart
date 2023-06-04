part of 'diary_dashboard_notifier.dart';

abstract class DiaryDashboardState {}

class LoadingDiary extends DiaryDashboardState {}

class Loaded extends DiaryDashboardState {
  final List<EpisodeEntry> entries;

  EpisodeEntry get oldestEntry => entries.last;

  EpisodeEntry get newestEntry => entries.first;

  set selectedEntry(EpisodeEntry? entry) => _selectedEntry = entry;
  EpisodeEntry? _selectedEntry;
  EpisodeEntry? get selectedEntry {
    if (_selectedEntry != null) return _selectedEntry;
    if (entries.isNotEmpty) return entries.first;
    return null;
  }

  Loaded(this.entries);
}

class Error extends DiaryDashboardState {}
