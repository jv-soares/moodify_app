import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moodify_app/src/repositories/medication_repository.dart';
import 'package:moodify_app/src/repositories/sql_diary_entry_repository.dart';

import 'core/app_navigator.dart';
import 'repositories/diary_entry_repository.dart';
import 'repositories/scheduled_notifications_repository.dart';
import 'services/local_notification_service.dart';

abstract class AppContainer {
  static final _getIt = GetIt.instance;

  static Future<void> initialize() async {
    _getIt.registerLazySingleton(() => AppNavigator(GlobalKey()));
    _getIt.registerSingletonAsync<DiaryEntryRepository>(
      () async => SqlDiaryEntryRepository.getInstance(),
    );
    _getIt.registerSingletonAsync<ScheduledNotificationsRepository>(
      () => SqlScheduledNotificationRepository.getInstance(),
    );
    _getIt.registerSingletonAsync<MedicationRepository>(
      () async => TempMedicationRepository(),
    );
    _getIt.registerSingletonAsync(() => LocalNotificationService.getInstance());
    return _getIt.allReady();
  }

  static T get<T extends Object>() => _getIt.call<T>();
}
