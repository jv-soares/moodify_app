import 'dart:async';

import '../models/diary_entry.dart';

abstract class DiaryEntryRepository {
  Stream<List<DiaryEntry>> watchAll();
  Future<List<DiaryEntry>> readAll();
  Future<String> create(DiaryEntry entry);
}
