import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:moodify_app/src/repositories/dtos/diary_entry_dto.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/diary_entry.dart';
import 'diary_entry_repository.dart';

class SqlDiaryEntryRepository implements DiaryEntryRepository {
  late sql.Database _db;

  SqlDiaryEntryRepository._();

  static Future<SqlDiaryEntryRepository> getInstance() async {
    final instance = SqlDiaryEntryRepository._();
    await instance._init();
    return instance;
  }

  Future<void> _init() async {
    _db = await sql.openDatabase(
      'moodify.db',
      version: 1,
      onOpen: (_) => log('opened $runtimeType'),
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute(_CreateTableQuery.diaryEntries);
        await db.execute(_CreateTableQuery.lifeEvents);
        await db.execute(_CreateTableQuery.medications);
      },
    );
  }

  @override
  Future<String> create(DiaryEntry entry) async {
    final diaryEntryId = await _db.insert(
      _Tables.diaryEntries,
      DiaryEntryDto.fromModel(entry).toJson(),
    );
    if (entry.lifeEvent != null) {
      await _db.insert(
        _Tables.lifeEvents,
        LifeEventDto.fromModel(entry.lifeEvent!, diaryEntryId).toJson(),
      );
    }
    if (entry.medications.isNotEmpty) {
      for (final medication in entry.medications) {
        await _db.insert(
          _Tables.medications,
          MedicationDto.fromModel(medication, diaryEntryId).toJson(),
        );
      }
    }
    _logAllTables();
    return diaryEntryId.toString();
  }

  Future<void> _logAllTables() async {
    log('DIARY ENTRIES\n${await _db.query(_Tables.diaryEntries)}');
    log('LIFE EVENTS\n${await _db.query(_Tables.lifeEvents)}');
    log('MEDICATION\n${await _db.query(_Tables.medications)}');
  }

  @override
  Future<List<DiaryEntry>> readAll() async {
    List<DiaryEntry> list = [];
    final results = await _db.query(_Tables.diaryEntries, orderBy: 'createdAt');
    final entries = results.map(DiaryEntryDto.fromJson).toList();
    for (final entry in entries) {
      final medicationResults = await _db.query(
        _Tables.medications,
        where: 'diaryEntryId = ?',
        whereArgs: [entry.diaryEntryId],
      );
      final medications = medicationResults
          .map(MedicationDto.fromJson)
          .map((e) => e.toModel())
          .toList();
      final lifeEventResults = await _db.query(
        _Tables.lifeEvents,
        where: 'diaryEntryId = ?',
        whereArgs: [entry.diaryEntryId],
      );
      final lifeEvents = lifeEventResults
          .map(LifeEventDto.fromJson)
          .map((e) => e.toModel())
          .toList();
      list.add(
        entry.toModel(
          medications: medications,
          lifeEvent: lifeEvents.firstOrNull,
        ),
      );
    }
    return list;
  }

  @override
  Future<String> update(DiaryEntry entry) async {
    final diaryEntryId = await _db.update(
      _Tables.diaryEntries,
      DiaryEntryDto.fromModel(entry).toJson(),
    );
    if (entry.lifeEvent != null) {
      await _db.update(
        _Tables.lifeEvents,
        LifeEventDto.fromModel(entry.lifeEvent!, diaryEntryId).toJson(),
      );
    }
    if (entry.medications.isNotEmpty) {
      for (final medication in entry.medications) {
        await _db.update(
          _Tables.medications,
          MedicationDto.fromModel(medication, diaryEntryId).toJson(),
        );
      }
    }
    _logAllTables();
    return diaryEntryId.toString();
  }
}

abstract class _CreateTableQuery {
  static const diaryEntries = '''
CREATE TABLE ${_Tables.diaryEntries} (
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
CREATE TABLE ${_Tables.lifeEvents} (
  lifeEventId INTEGER PRIMARY KEY,
  impactRating INTEGER,
  description TEXT,
  diaryEntryId INTEGER,
  FOREIGN KEY (diaryEntryId) REFERENCES diary_entries (diaryEntryId))
''';

  static const medications = '''
CREATE TABLE ${_Tables.medications} (
  medicationId INTEGER PRIMARY KEY,
  name TEXT,
  tabletsTaken INTEGER,
  doseAmount REAL,
  doseMeasurement TEXT,
  diaryEntryId INTEGER,
  FOREIGN KEY (diaryEntryId) REFERENCES diary_entries (diaryEntryId))
''';
}

abstract class _Tables {
  static const diaryEntries = 'diary_entries';
  static const medications = 'medications';
  static const lifeEvents = 'life_events';
}
