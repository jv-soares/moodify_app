import 'package:moodify_app/src/pages/diary_entry_form/episode_severity_form_page.dart';

abstract class EpisodeSeverity {
  factory EpisodeSeverity.fromEnum(EpisodeSeverity2 episode) {
    switch (episode) {
      case EpisodeSeverity2.maniaSevere:
        return Mania(Level.severe);
      case EpisodeSeverity2.maniaModerateHigh:
        return Mania(Level.moderateHigh);
      case EpisodeSeverity2.maniaModerateLow:
        return Mania(Level.moderateLow);
      case EpisodeSeverity2.maniaMild:
        return Mania(Level.mild);
      case EpisodeSeverity2.balanced:
        return Balanced();
      case EpisodeSeverity2.depressionMild:
        return Depression(Level.mild);
      case EpisodeSeverity2.depressionModerateLow:
        return Depression(Level.moderateLow);
      case EpisodeSeverity2.depressionModerateHigh:
        return Depression(Level.moderateHigh);
      case EpisodeSeverity2.depressionSevere:
        return Depression(Level.severe);
    }
  }
}

class Balanced implements EpisodeSeverity {}

class Depression implements EpisodeSeverity {
  final Level level;

  Depression(this.level);
}

class Mania implements EpisodeSeverity {
  final Level level;

  Mania(this.level);
}

enum Level {
  mild(1),
  moderateLow(2),
  moderateHigh(3),
  severe(4);

  final int value;

  const Level(this.value);
}
