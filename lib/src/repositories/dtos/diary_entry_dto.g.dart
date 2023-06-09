// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiaryEntryDto _$DiaryEntryDtoFromJson(Map<String, dynamic> json) =>
    DiaryEntryDto(
      diaryEntryId: json['diaryEntryId'] as int?,
      createdAt: json['createdAt'] as int,
      episode: $enumDecode(_$EpisodeSeverityEnumMap, json['episode']),
      moodRating: json['moodRating'] as int,
      hoursOfSleep: json['hoursOfSleep'] as int,
      symptoms: json['symptoms'] as String,
      moodSwitchesPerDay: json['moodSwitchesPerDay'] as int?,
      observations: json['observations'] as String?,
    );

Map<String, dynamic> _$DiaryEntryDtoToJson(DiaryEntryDto instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'episode': _$EpisodeSeverityEnumMap[instance.episode]!,
      'moodRating': instance.moodRating,
      'hoursOfSleep': instance.hoursOfSleep,
      'symptoms': instance.symptoms,
      'moodSwitchesPerDay': instance.moodSwitchesPerDay,
      'observations': instance.observations,
    };

const _$EpisodeSeverityEnumMap = {
  EpisodeSeverity.maniaSevere: 'maniaSevere',
  EpisodeSeverity.maniaModerateHigh: 'maniaModerateHigh',
  EpisodeSeverity.maniaModerateLow: 'maniaModerateLow',
  EpisodeSeverity.maniaMild: 'maniaMild',
  EpisodeSeverity.balanced: 'balanced',
  EpisodeSeverity.depressionMild: 'depressionMild',
  EpisodeSeverity.depressionModerateLow: 'depressionModerateLow',
  EpisodeSeverity.depressionModerateHigh: 'depressionModerateHigh',
  EpisodeSeverity.depressionSevere: 'depressionSevere',
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
