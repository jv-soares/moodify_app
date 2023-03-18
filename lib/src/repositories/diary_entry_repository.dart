import '../core/failures.dart';
import '../models/diary_entry.dart';

abstract class DiaryEntryRepository {
  Future<DiaryEntry> read(String id);
  Future<String> create(DiaryEntry entry);
}

class TempDiaryEntryRepository implements DiaryEntryRepository {
  final _entries = <DiaryEntry>{};

  @override
  Future<String> create(DiaryEntry entry) async {
    _entries.add(entry);
    return entry.id;
  }

  @override
  Future<DiaryEntry> read(String id) async {
    return _entries.singleWhere(
      (element) => element.id == id,
      orElse: () => throw DiaryEntryNotFoundFailure(),
    );
  }
}
