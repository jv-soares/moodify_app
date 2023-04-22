import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:moodify_app/src/models/scheduled_notification.dart';

part 'scheduled_notification_dto.g.dart';

@JsonSerializable()
class ScheduledNotificationDto {
  @JsonKey(includeToJson: false)
  final int? notificationId;
  final String time;
  final int active;

  ScheduledNotificationDto({
    this.notificationId,
    required this.time,
    required this.active,
  });

  factory ScheduledNotificationDto.fromJson(Map<String, dynamic> json) =>
      _$ScheduledNotificationDtoFromJson(json);

  factory ScheduledNotificationDto.fromModel(ScheduledNotification model) {
    return ScheduledNotificationDto(
      time: '${model.time.hour}:${model.time.minute}',
      active: model.isActive ? 1 : 0,
    );
  }

  Map<String, dynamic> toJson() => _$ScheduledNotificationDtoToJson(this);

  ScheduledNotification toModel() {
    return ScheduledNotification(
      notificationId!.toString(),
      TimeOfDay(
        hour: int.parse(time.split(':')[0]),
        minute: int.parse(time.split(':')[1]),
      ),
      active == 1,
    );
  }
}
