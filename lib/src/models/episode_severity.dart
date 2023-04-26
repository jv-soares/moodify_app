abstract class EpisodeSeverity {
  factory EpisodeSeverity.fromInteger(int value) {
    switch (value) {
      case -4:
        return Depression(Level.severe);
      case -3:
        return Depression(Level.moderateHigh);
      case -2:
        return Depression(Level.moderateLow);
      case -1:
        return Depression(Level.mild);
      case 0:
        return Balanced();
      case 1:
        return Mania(Level.mild);
      case 2:
        return Mania(Level.moderateLow);
      case 3:
        return Mania(Level.moderateHigh);
      case 4:
        return Mania(Level.severe);
    }
    throw Exception('value not in range [-4, 4]');
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
