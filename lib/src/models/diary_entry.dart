import 'package:equatable/equatable.dart';
import 'package:moodify_app/src/utils/date_time_utils.dart';

import 'episode_severity.dart';
import 'life_event.dart';
import 'taken_medication.dart';
import 'symptom.dart';

class DiaryEntry extends Equatable {
  final String id;
  final DateTime createdAt;
  final EpisodeSeverity episode;
  final int moodRating;
  final int hoursOfSleep;
  final List<Symptom> symptoms;
  final List<TakenMedication> medications;
  final int? moodSwitchesPerDay;
  final LifeEvent? lifeEvent;
  final String? observations;

  const DiaryEntry({
    required this.id,
    required this.createdAt,
    required this.episode,
    required this.moodRating,
    required this.hoursOfSleep,
    required this.symptoms,
    required this.medications,
    this.moodSwitchesPerDay,
    this.lifeEvent,
    this.observations,
  });

  bool isSameCreationDate(DiaryEntry other) {
    return DateTimeUtils.compareDayOfYear(createdAt, other.createdAt);
  }

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
