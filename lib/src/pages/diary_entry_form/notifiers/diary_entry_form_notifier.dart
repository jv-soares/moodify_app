import 'package:flutter/material.dart';
import 'package:moodify_app/src/services/diary_entry_service.dart';

import '../../../app_container.dart';
import '../view_models/diary_entry_view_model.dart';

part 'diary_entry_form_state.dart';

class DiaryEntryFormNotifier extends ValueNotifier<DiaryEntryFormState> {
  final _service = AppContainer.get<DiaryEntryService>();

  DiaryEntryFormNotifier() : super(Initial());

  Future<void> save(DiaryEntryViewModel diaryEntry) async {
    value = Loading();
    await _service.create(diaryEntry.toModel());
    value = Saved();
  }
}
