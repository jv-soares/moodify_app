import 'package:moodify_app/src/models/episode_severity.dart';

abstract class EpisodesChartHelper {
  static double calculateHeight(EpisodeSeverity episode, double rowHeight) {
    final middle = 4 * rowHeight;
    if (episode.isMania) {
      return (episode.levelValue * rowHeight) + middle;
    } else if (episode.isDepression) {
      return (4 - episode.levelValue) * rowHeight;
    } else {
      return middle;
    }
  }
}
