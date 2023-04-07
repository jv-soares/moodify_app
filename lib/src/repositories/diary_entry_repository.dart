import 'dart:async';

import 'package:collection/collection.dart';
import 'package:moodify_app/src/diary_entries.dart';
import 'package:moodify_app/src/utils/date_time_utils.dart';
import 'package:rxdart/subjects.dart';

import '../core/failures.dart';
import '../models/diary_entry.dart';

abstract class DiaryEntryRepository {
  Stream<List<DiaryEntry>> watchAll();
  Future<List<DiaryEntry>> readAll();
  Future<DiaryEntry> read(String id);
  Future<String> create(DiaryEntry entry);
}

class TempDiaryEntryRepository implements DiaryEntryRepository {
  TempDiaryEntryRepository() {
    _controller.add(diaryEntries);
  }

  final _controller = BehaviorSubject<List<DiaryEntry>>();

  @override
  Stream<List<DiaryEntry>> watchAll() async* {
    if (!_controller.hasValue) {
      yield [];
    } else {
      yield* _controller.map(
        (entries) => entries.sortedByCompare(
          (e) => e.createdAt,
          (a, b) => b.compareTo(a),
        ),
      );
    }
  }

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

  @override
  Future<DiaryEntry> read(String id) async {
    await _delay;
    return _controller.value.singleWhere(
      (element) => element.id == id,
      orElse: () => throw DiaryEntryNotFoundFailure(),
    );
  }

  Future<void> get _delay => Future.delayed(const Duration(seconds: 1));
}

class DuplicatedEntryFailure extends Failure {}
