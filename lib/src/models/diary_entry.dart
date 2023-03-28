import 'package:equatable/equatable.dart';

import 'episode_severity.dart';
import 'life_event.dart';
import 'medication.dart';
import 'symptom.dart';

class DiaryEntry extends Equatable {
  final String id;
  final DateTime createdAt;
  final EpisodeSeverity episode;
  final int moodRating;
  final List<Symptom> symptoms;
  final List<Medication> medications;
  final int? hoursOfSleep;
  final int? moodSwitchesPerDay;
  final LifeEvent? lifeEvent;
  final String? observations;

  const DiaryEntry({
    required this.id,
    required this.createdAt,
    required this.episode,
    required this.moodRating,
    required this.symptoms,
    required this.medications,
    this.hoursOfSleep,
    this.moodSwitchesPerDay,
    this.lifeEvent,
    this.observations,
  });

  @override
  List<Object?> get props => [
        id,
        createdAt,
        episode,
        moodRating,
        symptoms,
        medications,
        hoursOfSleep,
        moodSwitchesPerDay,
        lifeEvent,
        observations,
      ];
}
