import 'package:flutter/material.dart';

import '../view_models/diary_entry_view_model.dart';

part 'diary_entry_form_state.dart';

class DiaryEntryFormNotifier extends ValueNotifier<DiaryEntryFormState> {
  DiaryEntryFormNotifier() : super(Initial());

  Future<void> save(DiaryEntryViewModel diaryEntry) async {
    value = Loading();
    await Future.delayed(const Duration(seconds: 1));
    value = Saved();
  }
}
