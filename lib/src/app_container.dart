import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'core/app_navigator.dart';
import 'repositories/diary_entry_repository.dart';
import 'repositories/scheduled_notifications_repository.dart';
import 'repositories/temp_diary_entry_repository.dart';
import 'services/local_notification_service.dart';

abstract class AppContainer {
  static final _getIt = GetIt.instance;

  static Future<void> initialize() async {
    _getIt.registerSingletonAsync<DiaryEntryRepository>(
      () async => TempDiaryEntryRepository(),
    );
    _getIt.registerSingletonAsync<ScheduledNotificationsRepository>(
      () => SqlScheduledNotificationRepository.getInstance(),
    );
    _getIt.registerSingletonAsync(() => LocalNotificationService.getInstance());
    _getIt.registerLazySingleton(() => AppNavigator(GlobalKey()));
    return _getIt.allReady();
  }

  static T get<T extends Object>() => _getIt.call<T>();
}
