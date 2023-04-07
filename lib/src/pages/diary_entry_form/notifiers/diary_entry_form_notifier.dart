import 'package:flutter/material.dart';

import '../../../app_container.dart';
import '../../../repositories/diary_entry_repository.dart';
import '../view_models/diary_entry_view_model.dart';

part 'diary_entry_form_state.dart';

class DiaryEntryFormNotifier extends ValueNotifier<DiaryEntryFormState> {
  final _repository = AppContainer.get<DiaryEntryRepository>();

  DiaryEntryFormNotifier() : super(Initial());

  Future<void> save(DiaryEntryViewModel diaryEntry) async {
    value = Loading();
    await _repository.create(diaryEntry.toModel());
    value = Saved();
  }
}
