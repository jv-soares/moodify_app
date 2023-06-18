import 'package:collection/collection.dart';
import 'package:moodify_app/src/core/failures.dart';

import 'diary_entry.dart';
import 'episode_severity.dart';

class DiaryAnalyzer {
  final List<DiaryEntry> entries;

  DiaryAnalyzer(this.entries) {
    if (entries.isEmpty) throw EmptyEntriesFailure();
  }

  double get averageMood {
    return entries
            .map((e) => e.moodRating)
            .reduce((value, element) => value + element) /
        entries.length;
  }

  double get averageHoursOfSleep {
    return entries
            .map((e) => e.hoursOfSleep)
            .whereNotNull()
            .reduce((value, element) => value + element) /
        entries.length;
  }

  EpisodeSeverityDistribution calculateEpisodeDistribution() {
    int depressionCount = 0;
    int balancedCount = 0;
    int maniaCount = 0;
    for (final episode in entries.map((e) => e.episode)) {
      if (episode == EpisodeSeverity.depressionMild ||
          episode == EpisodeSeverity.depressionModerateHigh ||
          episode == EpisodeSeverity.depressionModerateLow ||
          episode == EpisodeSeverity.depressionSevere) {
        depressionCount += 1;
      } else if (episode == EpisodeSeverity.maniaMild ||
          episode == EpisodeSeverity.maniaModerateHigh ||
          episode == EpisodeSeverity.maniaModerateLow ||
          episode == EpisodeSeverity.maniaSevere) {
        maniaCount += 1;
      } else {
        balancedCount += 1;
      }
    }
    final total = depressionCount + balancedCount + maniaCount;
    return EpisodeSeverityDistribution(
      depression: depressionCount / total,
      balanced: balancedCount / total,
      mania: maniaCount / total,
    );
  }
}

class EpisodeSeverityDistribution {
  final double depression;
  final double balanced;
  final double mania;

  EpisodeSeverityDistribution({
    required this.depression,
    required this.balanced,
    required this.mania,
  }) : assert(depression + balanced + mania == 1);
}

class EmptyEntriesFailure extends Failure {}
