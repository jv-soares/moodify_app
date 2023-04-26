import 'package:collection/collection.dart';

import 'diary_entry.dart';
import 'episode_severity.dart';

class DiaryAnalyzer {
  final List<DiaryEntry> entries;

  DiaryAnalyzer(this.entries);

  double get averageMood {
    return entries
            .map((e) => e.moodRating)
            .reduce((value, element) => value + element) /
        entries.length;
  }

  double get averageSleepHours {
    return entries
            .map((e) => e.hoursOfSleep)
            .whereNotNull()
            .reduce((value, element) => value + element) /
        entries.length;
  }

  EpisodeSeverityDistribution get episodeDistribution {
    int depressionCount = 0;
    int balancedCount = 0;
    int maniaCount = 0;
    for (final episode in entries.map((e) => e.episode)) {
      if (episode is Depression) {
        depressionCount += 1;
      } else if (episode is Mania) {
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
