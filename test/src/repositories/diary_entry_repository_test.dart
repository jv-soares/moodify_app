import 'package:flutter_test/flutter_test.dart';
import 'package:moodify_app/src/core/failures.dart';
import 'package:moodify_app/src/diary_entries.dart';
import 'package:moodify_app/src/repositories/diary_entry_repository.dart';
import 'package:moodify_app/src/repositories/temp_diary_entry_repository.dart';

void main() {
  late DiaryEntryRepository sut;

  setUp(() {
    sut = TempDiaryEntryRepository();
  });

  test('should create entry', () async {
    final entry = diaryEntries.first;

    final id = await sut.create(entry);

    expect(id, entry.id);
  });

  test('should not create entry if it has the same date', () async {
    final entry = diaryEntries.first;

    await sut.create(entry);

    expect(sut.create(entry), throwsA(isA<DuplicatedEntryFailure>()));
  });
}
