import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:moodify_app/src/models/diary_entry.dart';
import 'package:moodify_app/src/models/episode_severity.dart';
import 'package:moodify_app/src/repositories/diary_entry_repository.dart';
import 'package:moodify_app/src/services/diary_entry_service.dart';

void main() {
  late DiaryEntryService sut;

  setUpAll(() {
    GetIt.instance.registerSingleton<DiaryEntryRepository>(
      FakeDiaryEntryRepository(),
    );
  });

  setUp(() {
    sut = DiaryEntryService();
  });

  test('should observe created entry', () async {
    await sut.create(_entry);
    final stream = sut.watchAll();

    expect(stream, emits([_entry]));
  });

  test('should read empty entries', () async {
    final result = await sut.readAll();

    expect(result, isEmpty);
  });

  test('should read entry after adding one', () async {
    await sut.create(_entry);
    final result = await sut.readAll();

    expect(result, [_entry]);
  });
}

final _entry = DiaryEntry(
  id: '1',
  createdAt: DateTime.now(),
  episode: EpisodeSeverity.maniaMild,
  moodRating: 40,
  hoursOfSleep: 8,
  symptoms: const [],
  medications: const [],
);

class FakeDiaryEntryRepository extends Fake implements DiaryEntryRepository {
  final _entries = <DiaryEntry>[];

  @override
  Future<String> create(DiaryEntry entry) async {
    await _delay;
    _entries.add(entry);
    return entry.id;
  }

  @override
  Future<List<DiaryEntry>> readAll() async {
    await _delay;
    return _entries;
  }

  Future<void> get _delay => Future.delayed(const Duration(milliseconds: 300));
}
