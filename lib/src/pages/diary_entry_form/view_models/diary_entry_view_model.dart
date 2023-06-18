import 'package:uuid/uuid.dart';

import '../../../models/diary_entry.dart';
import '../../../models/episode_severity.dart';
import '../../../models/life_event.dart';
import '../../../models/symptom.dart';
import '../../../models/taken_medication.dart';

class DiaryEntryViewModel {
  EpisodeSeverity episodeSeverity = EpisodeSeverity.balanced;
  int moodRating = 50;
  int hoursOfSleep = 8;
  List<Symptom>? symptoms;
  List<TakenMedication>? medications;
  LifeEvent? lifeEvent;
  String? observations;
  int? moodSwitchesPerDay;
  DateTime createdAt = DateTime.now();

  DiaryEntry toModel() {
    return DiaryEntry(
      id: const Uuid().v1(),
      createdAt: createdAt,
      episode: episodeSeverity,
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
