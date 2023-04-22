// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moodify_app/src/models/scheduled_notification.dart';
import 'package:moodify_app/src/repositories/dtos/scheduled_notification_dto.dart';
import 'package:sqflite/sqflite.dart' as sql;

abstract class ScheduledNotificationsRepository {
  Future<List<ScheduledNotification>> readAll();
  Future<String> create(ScheduledNotification notification);
  Future<void> toggle(String id, bool isActive);
  Future<void> delete(String id);
}

class TempScheduledNotificationRepository
    implements ScheduledNotificationsRepository {
  final _notifications = [
    ScheduledNotification('1', TimeOfDay(hour: 12, minute: 0), true),
    ScheduledNotification('2', TimeOfDay(hour: 23, minute: 10), true),
    ScheduledNotification('3', TimeOfDay(hour: 10, minute: 5), false),
    ScheduledNotification('4', TimeOfDay(hour: 14, minute: 30), false),
  ];

  @override
  Future<String> create(ScheduledNotification notification) async {
    await _delay;
    _notifications.add(notification);
    return notification.id;
  }

  @override
  Future<void> delete(String id) async {
    await _delay;
    _notifications.removeWhere((element) => element.id == id);
  }

  @override
  Future<List<ScheduledNotification>> readAll() async {
    await _delay;
    return _notifications;
  }

  Future<void> get _delay => Future.delayed(const Duration(seconds: 1));

  @override
  Future<void> toggle(String id, bool isActive) async {
    await _delay;
    final index = _notifications.indexWhere((element) => element.id == id);
    _notifications[index] = _notifications[index].copyWith(isActive: isActive);
  }
}

class SqlScheduledNotificationRepository
    implements ScheduledNotificationsRepository {
  late sql.Database _db;

  SqlScheduledNotificationRepository._();

  static Future<SqlScheduledNotificationRepository> getInstance() async {
    final instance = SqlScheduledNotificationRepository._();
    await instance._init();
    return instance;
  }

  Future<void> _init() async {
    _db = await sql.openDatabase(
      'notifications.db',
      version: 1,
      onOpen: (_) => log('opened $runtimeType'),
      onCreate: (db, version) async {
        await db.execute(_CreateTableQuery.notifications);
      },
    );
  }

  @override
  Future<String> create(ScheduledNotification notification) async {
    final dto = ScheduledNotificationDto.fromModel(notification);
    final id = await _db.insert(_Tables.notifications, dto.toJson());
    return id.toString();
  }

  @override
  Future<void> delete(String id) async {
    await _db.delete(
      _Tables.notifications,
      where: 'notificationId = ?',
      whereArgs: [int.parse(id)],
    );
  }

  @override
  Future<List<ScheduledNotification>> readAll() async {
    final items = await _db.query(_Tables.notifications);
    return items
        .map((e) => ScheduledNotificationDto.fromJson(e).toModel())
        .toList();
  }

  @override
  Future<void> toggle(String id, bool isActive) async {
    await _db.update(
      _Tables.notifications,
      {'active': isActive ? 1 : 0},
      where: 'notificationId = ?',
      whereArgs: [int.parse(id)],
    );
  }
}

abstract class _CreateTableQuery {
  static const notifications = '''
CREATE TABLE ${_Tables.notifications} (
  notificationId INTEGER PRIMARY KEY,
  time TEXT NOT NULL,
  active INTEGER NOT NULL
)''';
}

abstract class _Tables {
  static const notifications = 'notifications';
}
