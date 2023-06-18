import 'package:moodify_app/src/models/episode_severity.dart';

abstract class EpisodesChartHelper {
  static String resolveName(EpisodeSeverity episode) {
    return switch (episode) {
      EpisodeSeverity.maniaSevere => 'Mania severa',
      EpisodeSeverity.maniaModerateHigh => 'Mania moderada-alta',
      EpisodeSeverity.maniaModerateLow => 'Mania moderada-baixa',
      EpisodeSeverity.maniaMild => 'Mania leve',
      EpisodeSeverity.balanced => 'Equilibrado',
      EpisodeSeverity.depressionMild => 'Depressão leve',
      EpisodeSeverity.depressionModerateLow => 'Depressão moderada-baixa',
      EpisodeSeverity.depressionModerateHigh => 'Depressão moderada-alta',
      EpisodeSeverity.depressionSevere => 'Depressão severa',
    };
  }

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
