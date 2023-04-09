import 'dart:convert';

import '../../models/diary_entry.dart';
import '../../models/life_event.dart';
import '../../models/medication.dart';

class DiaryEntryDto {
  final String id;
  final int createdAt;
  final String episode;
  final int moodRating;
  final List<String> symptoms;
  final List<MedicationDto> medications;
  final int? hoursOfSleep;
  final int? moodSwitchesPerDay;
  final LifeEventDto? lifeEvent;
  final String? observations;

  const DiaryEntryDto({
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

  factory DiaryEntryDto.fromModel(DiaryEntry model) {
    return DiaryEntryDto(
      id: model.id,
      createdAt: model.createdAt.millisecondsSinceEpoch,
      episode: model.episode.toString(),
      moodRating: model.moodRating,
      symptoms: model.symptoms.map((e) => e.name).toList(),
      medications: model.medications.map(MedicationDto.fromModel).toList(),
      hoursOfSleep: model.hoursOfSleep,
      lifeEvent: model.lifeEvent != null
          ? LifeEventDto.fromModel(model.lifeEvent!)
          : null,
      moodSwitchesPerDay: model.moodSwitchesPerDay,
      observations: model.observations,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'episode': episode,
      'moodRating': moodRating,
      'symptoms': jsonEncode(symptoms),
      'hoursOfSleep': hoursOfSleep,
      'moodSwitchesPerDay': moodSwitchesPerDay,
      'observations': observations,
    };
  }
}

class MedicationDto {
  final String id;
  final String name;
  final int tabletsTaken;
  final double doseAmount;
  final String doseMeasurement;

  const MedicationDto({
    required this.id,
    required this.name,
    required this.tabletsTaken,
    required this.doseAmount,
    required this.doseMeasurement,
  });

  factory MedicationDto.fromModel(Medication model) {
    return MedicationDto(
      id: model.id,
      name: model.name,
      tabletsTaken: model.tabletsTaken,
      doseAmount: model.dose.value,
      doseMeasurement: model.dose.unitOfMeasurement.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tabletsTaken': tabletsTaken,
      'doseAmount': doseAmount,
      'doseMeasurement': doseMeasurement,
    };
  }
}

class LifeEventDto {
  final int impactRating;
  final String description;

  const LifeEventDto({
    required this.impactRating,
    required this.description,
  });

  factory LifeEventDto.fromModel(LifeEvent model) {
    return LifeEventDto(
      impactRating: model.impactRating,
      description: model.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'impactRating': impactRating,
      'description': description,
    };
  }
}
