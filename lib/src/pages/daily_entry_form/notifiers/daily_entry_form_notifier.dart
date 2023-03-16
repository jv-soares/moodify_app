import 'package:flutter/material.dart';

import '../view_models/diary_entry_view_model.dart';

part 'daily_entry_form_state.dart';

class DailyEntryFormNotifier extends ValueNotifier<DailyEntryFormState> {
  DailyEntryFormNotifier() : super(Initial());

  Future<void> save(DiaryEntryViewModel diaryEntry) async {
    value = Loading();
    await Future.delayed(const Duration(seconds: 1));
    value = Saved();
  }
}
