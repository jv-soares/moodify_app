import 'package:moodify_app/src/model/episode_severity.dart';
import 'package:uuid/uuid.dart';

import '../../../model/diary_entry.dart';
import '../../../model/life_event.dart';
import '../../../model/medication.dart';
import '../../../model/symptom.dart';

class DiaryEntryViewModel {
  int functionalImpairment = 0;
  int moodRating = 0;
  int? hoursOfSleep;
  List<Symptom>? symptoms;
  List<Medication>? medications;
  LifeEvent? lifeEvent;
  String? observations;
  int? moodSwitchesPerDay;

  DiaryEntry toModel() {
    return DiaryEntry(
      id: const Uuid().v1(),
      createdAt: DateTime.now(),
      episode: Mania(Level.moderateHigh),
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
