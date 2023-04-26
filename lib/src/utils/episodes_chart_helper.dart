import 'package:moodify_app/src/models/episode_severity.dart';

abstract class EpisodesChartHelper {
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
