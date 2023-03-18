part of 'diary_entry_form_notifier.dart';

abstract class DiaryEntryFormState {}

class Initial extends DiaryEntryFormState {}

class Loading extends DiaryEntryFormState {}

class Error extends DiaryEntryFormState {}

class Saved extends DiaryEntryFormState {}
