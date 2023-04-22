import 'package:get_it/get_it.dart';
import 'package:moodify_app/src/repositories/diary_entry_repository.dart';
import 'package:moodify_app/src/repositories/scheduled_notifications_repository.dart';
import 'package:moodify_app/src/repositories/temp_diary_entry_repository.dart';

abstract class AppContainer {
  static final _getIt = GetIt.instance;

  static Future<void> initialize() async {
    _getIt.registerSingletonAsync<DiaryEntryRepository>(
      () async => TempDiaryEntryRepository(),
    );
    _getIt.registerLazySingleton<ScheduledNotificationsRepository>(
      () => TempScheduledNotificationRepository(),
    );
    return _getIt.allReady();
  }

  static T get<T extends Object>() => _getIt.call<T>();
}
