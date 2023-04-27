import 'package:moodify_app/src/models/episode_severity.dart';

abstract class EpisodesChartHelper {
  static String resolveName(EpisodeSeverity episode) {
    var name = '';
    if (episode is Mania) {
      name += 'Mania';
      return _resolveLevel(episode.level, name);
    } else if (episode is Depression) {
      name += 'Depressão';
      return _resolveLevel(episode.level, name);
    } else {
      return 'Equilibrado';
    }
  }

  static String _resolveLevel(Level level, String name) {
    switch (level) {
      case Level.mild:
        return name += ' leve';
      case Level.moderateLow:
        return name += ' moderada-baixa';
      case Level.moderateHigh:
        return name += ' moderada-alta';
      case Level.severe:
        return name += ' severa';
    }
  }

  static double calculateHeight(EpisodeSeverity episode, double rowHeight) {
    final middle = 4 * rowHeight;
    if (episode is Mania) {
      return (episode.level.value * rowHeight) + middle;
    } else if (episode is Depression) {
      return (4 - episode.level.value) * rowHeight;
    } else if (episode is Balanced) {
      return middle;
    }
    throw Exception('unsupported episode severity');
  }
}
