import 'package:moodify_app/src/model/symptom.dart';

import 'episode_severity.dart';
import 'life_event.dart';
import 'medication.dart';

class DiaryEntry {
  final String id;
  final DateTime createdAt;
  final EpisodeSeverity episode;
  final int moodRating;
  final List<Symptom> symptoms;
  final int? hoursOfSleep;
  final int? moodSwitchesPerDay;
  final LifeEvent? lifeEvent;
  final List<Medication>? medications;
  final String? observations;

  DiaryEntry({
    required this.id,
    required this.createdAt,
    required this.episode,
    required this.moodRating,
    required this.symptoms,
    this.hoursOfSleep,
    this.moodSwitchesPerDay,
    this.lifeEvent,
    this.medications,
    this.observations,
  });
}
