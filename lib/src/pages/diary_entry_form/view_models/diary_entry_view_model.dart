import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../models/diary_entry.dart';
import '../../../models/episode_severity.dart';
import '../../../models/life_event.dart';
import '../../../models/symptom.dart';
import '../../../models/taken_medication.dart';

class DiaryEntryViewModel extends ChangeNotifier {
  EpisodeSeverity get episodeSeverity => _episodeSeverity;
  EpisodeSeverity _episodeSeverity = EpisodeSeverity.balanced;

  int get moodRating => _moodRating;
  int _moodRating = 50;

  int get hoursOfSleep => _hoursOfSleep;
  int _hoursOfSleep = 8;

  List<Symptom>? get symptoms => _symptoms;
  List<Symptom>? _symptoms;

  List<TakenMedication>? get medications => _medications;
  List<TakenMedication>? _medications;

  LifeEvent? get lifeEvent => _lifeEvent;
  LifeEvent? _lifeEvent;

  String? get observations => _observations;
  String? _observations;

  int? get moodSwitchesPerDay => _moodSwitchesPerDay;
  int? _moodSwitchesPerDay;

  DateTime get createdAt => _createdAt;
  DateTime _createdAt = DateTime.now();

  void update({
    EpisodeSeverity? episodeSeverity,
    int? moodRating,
    int? hoursOfSleep,
    List<Symptom>? symptoms,
    List<TakenMedication>? medications,
    LifeEvent? lifeEvent,
    String? observations,
    int? moodSwitchesPerDay,
    DateTime? createdAt,
  }) {
    _episodeSeverity = episodeSeverity ?? _episodeSeverity;
    _moodRating = moodRating ?? _moodRating;
    _hoursOfSleep = hoursOfSleep ?? _hoursOfSleep;
    _symptoms = symptoms ?? _symptoms;
    _medications = medications ?? _medications;
    _lifeEvent = lifeEvent ?? _lifeEvent;
    _observations = observations ?? _observations;
    _moodSwitchesPerDay = moodSwitchesPerDay ?? _moodSwitchesPerDay;
    _createdAt = createdAt ?? _createdAt;
    notifyListeners();
  }

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
