import 'package:moodify_app/src/pages/diary_entry_form/episode_severity_form_page.dart';

interface class EpisodeSeverity {
  factory EpisodeSeverity.fromEnum(EpisodeSeverity2 episode) {
    return switch (episode) {
      EpisodeSeverity2.maniaSevere => Mania(Level.severe),
      EpisodeSeverity2.maniaModerateHigh => Mania(Level.moderateHigh),
      EpisodeSeverity2.maniaModerateLow => Mania(Level.moderateLow),
      EpisodeSeverity2.maniaMild => Mania(Level.mild),
      EpisodeSeverity2.balanced => Balanced(),
      EpisodeSeverity2.depressionMild => Depression(Level.mild),
      EpisodeSeverity2.depressionModerateLow => Depression(Level.moderateLow),
      EpisodeSeverity2.depressionModerateHigh => Depression(Level.moderateHigh),
      EpisodeSeverity2.depressionSevere => Depression(Level.severe),
    };
  }

  factory EpisodeSeverity.fromString(String episode) {
    if (episode == 'Balanced') return Balanced();
    final level = int.parse(episode.split(':').last);
    if (episode.startsWith('Depression')) {
      return Depression(Level.fromValue(level));
    }
    if (episode.startsWith('Mania')) {
      return Mania(Level.fromValue(level));
    }
    throw Exception('unsupported episode string');
  }
}

class Balanced implements EpisodeSeverity {
  @override
  String toString() => 'Balanced';
}

class Depression implements EpisodeSeverity {
  final Level level;

  Depression(this.level);

  @override
  String toString() => 'Depression:${level.value}';
}

class Mania implements EpisodeSeverity {
  final Level level;

  Mania(this.level);

  @override
  String toString() => 'Mania:${level.value}';
}

enum Level {
  mild(1),
  moderateLow(2),
  moderateHigh(3),
  severe(4);

  final int value;

  const Level(this.value);

  static Level fromValue(int value) {
    return switch (value) {
      1 => Level.mild,
      2 => Level.moderateLow,
      3 => Level.moderateHigh,
      4 => Level.severe,
      _ => throw Exception('unsupported value'),
    };
  }
}
