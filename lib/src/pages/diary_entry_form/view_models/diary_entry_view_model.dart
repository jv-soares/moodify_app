import '../../../models/episode_severity.dart';
import 'package:uuid/uuid.dart';

import '../../../models/diary_entry.dart';
import '../../../models/life_event.dart';
import '../../../models/medication.dart';
import '../../../models/symptom.dart';

class DiaryEntryViewModel {
  int functionalImpairment = 0;
  int moodRating = 50;
  int? hoursOfSleep;
  List<Symptom>? symptoms;
  List<Medication>? medications;
  LifeEvent? lifeEvent;
  String? observations;
  int? moodSwitchesPerDay;
  DateTime createdAt = DateTime.now();

  DiaryEntry toModel() {
    return DiaryEntry(
      id: const Uuid().v1(),
      createdAt: createdAt,
      episode: EpisodeSeverity.fromInteger(functionalImpairment),
      moodRating: moodRating,
      symptoms: symptoms ?? [],
      medications: medications ?? [],
      hoursOfSleep: hoursOfSleep,
      lifeEvent: lifeEvent,
      moodSwitchesPerDay: moodSwitchesPerDay,
      observations: observations,
    );
  }
}
