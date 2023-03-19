abstract class EpisodeSeverity {}

class Balanced extends EpisodeSeverity {}

class Depression extends EpisodeSeverity {
  final Level level;

  Depression(this.level);
}

class Mania extends EpisodeSeverity {
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
