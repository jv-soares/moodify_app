// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledNotificationDto _$ScheduledNotificationDtoFromJson(
        Map<String, dynamic> json) =>
    ScheduledNotificationDto(
      notificationId: json['notificationId'] as int?,
      time: json['time'] as String,
      active: json['active'] as int,
    );

Map<String, dynamic> _$ScheduledNotificationDtoToJson(
        ScheduledNotificationDto instance) =>
    <String, dynamic>{
      'time': instance.time,
      'active': instance.active,
    };
