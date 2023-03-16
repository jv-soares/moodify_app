part of 'daily_entry_form_notifier.dart';

abstract class DailyEntryFormState {}

class Initial extends DailyEntryFormState {}

class Loading extends DailyEntryFormState {}

class Error extends DailyEntryFormState {}

class Saved extends DailyEntryFormState {}
