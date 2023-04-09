import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:moodify_app/src/diary_entries.dart';
import 'package:moodify_app/src/repositories/dtos/diary_entry_dto.dart';
import 'package:rxdart/subjects.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/diary_entry.dart';
import 'diary_entry_repository.dart';

class SqlDiaryEntryRepository implements DiaryEntryRepository {
  late sql.Database _db;

  SqlDiaryEntryRepository._() {
    _controller.add(diaryEntries);
  }

  static Future<SqlDiaryEntryRepository> getInstance() async {
    final instance = SqlDiaryEntryRepository._();
    await instance._init();
    return instance;
  }

  final _controller = BehaviorSubject<List<DiaryEntry>>();

  Future<void> _init() async {
    // await sql.Sqflite.setDebugModeOn();
    _db = await sql.openDatabase(
      'moodify.db',
      version: 1,
      onOpen: (_) => log('opened database'),
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute(CreateTableQuery.diaryEntries);
        await db.execute(CreateTableQuery.lifeEvents);
        await db.execute(CreateTableQuery.medications);
      },
    );
  }

  @override
  Future<String> create(DiaryEntry entry) async {
    _controller.add([..._controller.value, entry]);
    final batch = _db.batch();
    final dto = DiaryEntryDto.fromModel(entry);
    batch.insert('diary_entries', dto.toJson());
    if (dto.lifeEvent != null) {
      batch.insert('diary_entries', dto.lifeEvent!.toJson());
    }
    if (dto.medications.isNotEmpty) {
      for (final medication in dto.medications) {
        batch.insert('diary_entries', medication.toJson());
      }
    }
    final ids = await batch.commit();
    return (ids.first as int).toString();
  }

  @override
  Future<DiaryEntry> read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<List<DiaryEntry>> readAll() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Stream<List<DiaryEntry>> watchAll() async* {
    if (_controller.hasValue) {
      yield* _controller.map((entries) => entries.sortedByCreationDate());
    } else {
      yield [];
    }
  }
}

abstract class CreateTableQuery {
  static const diaryEntries = '''
CREATE TABLE diary_entries (
  diaryEntryId INTEGER PRIMARY KEY,
  createdAt INTEGER,
  episode TEXT,
  moodRating INTEGER,
  hoursOfSleep INTEGER,
  moodSwitchesPerDay INTEGER,
  symptoms TEXT,
  observations TEXT)
''';

  static const lifeEvents = '''
CREATE TABLE life_events (
  lifeEventId INTEGER PRIMARY KEY,
  impactRating INTEGER,
  description TEXT,
  diaryEntryId INTEGER,
  FOREIGN KEY (diaryEntryId) REFERENCES diary_entries (diaryEntryId))
''';

  static const medications = '''
CREATE TABLE medications (
  medicationId INTEGER PRIMARY KEY,
  name TEXT,
  tabletsTaken INTEGER,
  doseAmount REAL,
  doseMeasurement TEXT,
  diaryEntryId INTEGER,
  FOREIGN KEY (diaryEntryId) REFERENCES diary_entries (diaryEntryId))
''';
}

extension on List<DiaryEntry> {
  List<DiaryEntry> sortedByCreationDate({bool ascending = false}) {
    return sortedByCompare(
      (e) => e.createdAt,
      (a, b) => ascending ? b.compareTo(a) : a.compareTo(b),
    );
  }
}
