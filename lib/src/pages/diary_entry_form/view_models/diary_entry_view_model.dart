import 'package:moodify_app/src/pages/diary_entry_form/episode_severity_form_page.dart';
import 'package:uuid/uuid.dart';

import '../../../models/diary_entry.dart';
import '../../../models/episode_severity.dart';
import '../../../models/life_event.dart';
import '../../../models/medication.dart';
import '../../../models/symptom.dart';

class DiaryEntryViewModel {
  EpisodeSeverity2 episodeSeverity = EpisodeSeverity2.balanced;
  int moodRating = 50;
  int hoursOfSleep = 8;
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
      episode: EpisodeSeverity.fromEnum(episodeSeverity),
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
