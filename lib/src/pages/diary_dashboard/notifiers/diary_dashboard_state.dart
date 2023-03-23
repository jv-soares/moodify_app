part of 'diary_dashboard_notifier.dart';

abstract class DiaryDashboardState {}

class Initial extends DiaryDashboardState {}

class Loading extends DiaryDashboardState {}

class Loaded extends DiaryDashboardState {
  final List<DiaryEntry> entries;

  Loaded(this.entries);
}

class Error extends DiaryDashboardState {}
