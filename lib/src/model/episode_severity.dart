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

enum Level { mild, moderateLow, moderateHigh, severe }
