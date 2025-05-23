// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReminderImpl _$$ReminderImplFromJson(Map<String, dynamic> json) =>
    _$ReminderImpl(
      id: json['id'] as String,
      taskId: json['taskId'] as String,
      scheduledFor: DateTime.parse(json['scheduledFor'] as String),
      title: json['title'] as String,
      message: json['message'] as String,
      status: $enumDecodeNullable(_$ReminderStatusEnumMap, json['status']) ??
          ReminderStatus.pending,
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
    );

Map<String, dynamic> _$$ReminderImplToJson(_$ReminderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskId': instance.taskId,
      'scheduledFor': instance.scheduledFor.toIso8601String(),
      'title': instance.title,
      'message': instance.message,
      'status': _$ReminderStatusEnumMap[instance.status]!,
      'sentAt': instance.sentAt?.toIso8601String(),
    };

const _$ReminderStatusEnumMap = {
  ReminderStatus.pending: 'pending',
  ReminderStatus.sent: 'sent',
  ReminderStatus.cancelled: 'cancelled',
};
