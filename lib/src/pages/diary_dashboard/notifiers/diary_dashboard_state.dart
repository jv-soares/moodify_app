part of 'diary_dashboard_notifier.dart';

abstract class DiaryDashboardState {}

class Initial extends DiaryDashboardState {}

class Loading extends DiaryDashboardState {}

class Loaded extends DiaryDashboardState {
  final List<EpisodeEntry> entries;

  EpisodeEntry get oldestEntry => entries.last;

  EpisodeEntry get newestEntry => entries.first;

  set selectedEntry(EpisodeEntry entry) => _selectedEntry = entry;
  EpisodeEntry? _selectedEntry;
  EpisodeEntry get selectedEntry => _selectedEntry ?? entries.first;

  Loaded(this.entries);
}

class Error extends DiaryDashboardState {}
