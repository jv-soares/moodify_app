import 'episode_severity.dart';
import 'life_event.dart';
import 'medication.dart';

class DiaryEntry {
  final String id;
  final DateTime createdAt;
  final EpisodeSeverity episode;
  final int moodRating;
  final int? hoursOfSleep;
  final bool? dysphoricMania;
  final int? moodSwitchesPerDay;
  final LifeEvent? lifeEvent;
  final List<Medication>? medications;
  final String? observations;

  DiaryEntry({
    required this.id,
    required this.createdAt,
    required this.episode,
    required this.moodRating,
    this.hoursOfSleep,
    this.dysphoricMania,
    this.moodSwitchesPerDay,
    this.lifeEvent,
    this.medications,
    this.observations,
  });
}
