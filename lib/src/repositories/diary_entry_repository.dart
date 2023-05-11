import 'dart:async';

import '../models/diary_entry.dart';

abstract class DiaryEntryRepository {
  Future<List<DiaryEntry>> readAll();
  Future<String> create(DiaryEntry entry);
}
