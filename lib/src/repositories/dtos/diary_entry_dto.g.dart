// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiaryEntryDto _$DiaryEntryDtoFromJson(Map<String, dynamic> json) =>
    DiaryEntryDto(
      diaryEntryId: json['diaryEntryId'] as int?,
      createdAt: json['createdAt'] as int,
      episode: json['episode'] as String,
      moodRating: json['moodRating'] as int,
      symptoms: json['symptoms'] as String,
      hoursOfSleep: json['hoursOfSleep'] as int?,
      moodSwitchesPerDay: json['moodSwitchesPerDay'] as int?,
      observations: json['observations'] as String?,
    );

Map<String, dynamic> _$DiaryEntryDtoToJson(DiaryEntryDto instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'episode': instance.episode,
      'moodRating': instance.moodRating,
      'symptoms': instance.symptoms,
      'hoursOfSleep': instance.hoursOfSleep,
      'moodSwitchesPerDay': instance.moodSwitchesPerDay,
      'observations': instance.observations,
    };

MedicationDto _$MedicationDtoFromJson(Map<String, dynamic> json) =>
    MedicationDto(
      medicationId: json['medicationId'] as int?,
      name: json['name'] as String,
      tabletsTaken: json['tabletsTaken'] as int,
      doseAmount: (json['doseAmount'] as num).toDouble(),
      doseMeasurement: json['doseMeasurement'] as String,
      diaryEntryId: json['diaryEntryId'] as int,
    );

Map<String, dynamic> _$MedicationDtoToJson(MedicationDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'tabletsTaken': instance.tabletsTaken,
      'doseAmount': instance.doseAmount,
      'doseMeasurement': instance.doseMeasurement,
      'diaryEntryId': instance.diaryEntryId,
    };

LifeEventDto _$LifeEventDtoFromJson(Map<String, dynamic> json) => LifeEventDto(
      lifeEventId: json['lifeEventId'] as int?,
      impactRating: json['impactRating'] as int,
      description: json['description'] as String,
      diaryEntryId: json['diaryEntryId'] as int,
    );

Map<String, dynamic> _$LifeEventDtoToJson(LifeEventDto instance) =>
    <String, dynamic>{
      'impactRating': instance.impactRating,
      'description': instance.description,
      'diaryEntryId': instance.diaryEntryId,
    };
