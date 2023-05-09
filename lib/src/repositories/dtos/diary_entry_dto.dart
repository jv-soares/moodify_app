import 'package:json_annotation/json_annotation.dart';
import 'package:moodify_app/src/models/episode_severity.dart';

import '../../models/diary_entry.dart';
import '../../models/life_event.dart';
import '../../models/medication.dart';

part 'diary_entry_dto.g.dart';

@JsonSerializable()
class DiaryEntryDto {
  @JsonKey(includeToJson: false)
  final int? diaryEntryId;
  final int createdAt;
  final String episode;
  final int moodRating;
  final int hoursOfSleep;
  final String symptoms;
  final int? moodSwitchesPerDay;
  final String? observations;

  const DiaryEntryDto({
    this.diaryEntryId,
    required this.createdAt,
    required this.episode,
    required this.moodRating,
    required this.hoursOfSleep,
    required this.symptoms,
    this.moodSwitchesPerDay,
    this.observations,
  });

  factory DiaryEntryDto.fromModel(DiaryEntry model) {
    return DiaryEntryDto(
      createdAt: model.createdAt.millisecondsSinceEpoch,
      episode: model.episode.toString(),
      moodRating: model.moodRating,
      symptoms: model.symptoms.map((e) => e.name).toString(),
      hoursOfSleep: model.hoursOfSleep,
      moodSwitchesPerDay: model.moodSwitchesPerDay,
      observations: model.observations,
    );
  }

  factory DiaryEntryDto.fromJson(Map<String, dynamic> json) =>
      _$DiaryEntryDtoFromJson(json);

  DiaryEntry toModel({
    required List<Medication> medications,
    LifeEvent? lifeEvent,
  }) {
    return DiaryEntry(
      id: diaryEntryId!.toString(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      episode: EpisodeSeverity.fromString(episode),
      moodRating: moodRating,
      symptoms: [],
      medications: medications,
      hoursOfSleep: hoursOfSleep,
      lifeEvent: lifeEvent,
      moodSwitchesPerDay: moodSwitchesPerDay,
      observations: observations,
    );
  }

  Map<String, dynamic> toJson() => _$DiaryEntryDtoToJson(this);
}

@JsonSerializable()
class MedicationDto {
  @JsonKey(includeToJson: false)
  final int? medicationId;
  final String name;
  final int tabletsTaken;
  final double doseAmount;
  final String doseMeasurement;
  final int diaryEntryId;

  const MedicationDto({
    this.medicationId,
    required this.name,
    required this.tabletsTaken,
    required this.doseAmount,
    required this.doseMeasurement,
    required this.diaryEntryId,
  });

  factory MedicationDto.fromModel(Medication model, int diaryEntryId) {
    return MedicationDto(
      name: model.name,
      tabletsTaken: model.tabletsTaken,
      doseAmount: model.dose.value,
      doseMeasurement: model.dose.unitOfMeasurement.name,
      diaryEntryId: diaryEntryId,
    );
  }

  factory MedicationDto.fromJson(Map<String, dynamic> json) =>
      _$MedicationDtoFromJson(json);

  Medication toModel() {
    return Medication(
      id: medicationId!.toString(),
      name: name,
      tabletsTaken: tabletsTaken,
      dose: Dose(doseAmount, UnitOfMeasurement.mg),
    );
  }

  Map<String, dynamic> toJson() => _$MedicationDtoToJson(this);
}

@JsonSerializable()
class LifeEventDto {
  @JsonKey(includeToJson: false)
  final int? lifeEventId;
  final int impactRating;
  final String description;
  final int diaryEntryId;

  const LifeEventDto({
    this.lifeEventId,
    required this.impactRating,
    required this.description,
    required this.diaryEntryId,
  });

  factory LifeEventDto.fromModel(LifeEvent model, int diaryEntryId) {
    return LifeEventDto(
      impactRating: model.impactRating,
      description: model.description,
      diaryEntryId: diaryEntryId,
    );
  }

  factory LifeEventDto.fromJson(Map<String, dynamic> json) =>
      _$LifeEventDtoFromJson(json);

  LifeEvent toModel() {
    return LifeEvent(
      id: lifeEventId!.toString(),
      description: description,
      impactRating: impactRating,
    );
  }

  Map<String, dynamic> toJson() => _$LifeEventDtoToJson(this);
}
