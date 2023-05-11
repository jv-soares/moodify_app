import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';

import '../core/failures.dart';
import '../diary_entries.dart';
import '../models/diary_entry.dart';
import '../utils/date_time_utils.dart';
import 'diary_entry_repository.dart';

class TempDiaryEntryRepository implements DiaryEntryRepository {
  TempDiaryEntryRepository() {
    _controller.add(diaryEntries);
  }

  final _controller = BehaviorSubject<List<DiaryEntry>>();

  @override
  Future<List<DiaryEntry>> readAll() async {
    await _delay;
    return _controller.value
        .sortedByCompare((e) => e.createdAt, (a, b) => b.compareTo(a))
        .toList();
  }

  @override
  Future<String> create(DiaryEntry entry) async {
    final duplicatedEntry = _controller.value.singleWhereOrNull(
      (element) => DateTimeUtils.compareDayOfYear(
        element.createdAt,
        entry.createdAt,
      ),
    );
    if (duplicatedEntry != null) throw DuplicatedEntryFailure();
    await _delay;
    _controller.add([..._controller.value, entry]);
    return entry.id;
  }

  Future<void> get _delay => Future.delayed(const Duration(seconds: 1));
}
