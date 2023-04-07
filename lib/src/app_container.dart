import 'package:get_it/get_it.dart';
import 'package:moodify_app/src/repositories/diary_entry_repository.dart';

abstract class AppContainer {
  static final _getIt = GetIt.instance;

  static Future<void> initialize() async {
    _getIt.registerLazySingleton<DiaryEntryRepository>(
      () => TempDiaryEntryRepository(),
    );
    return _getIt.allReady();
  }

  static T get<T extends Object>() => _getIt.call<T>();
}