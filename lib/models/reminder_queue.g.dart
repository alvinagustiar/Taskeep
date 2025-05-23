// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReminderItemImpl _$$ReminderItemImplFromJson(Map<String, dynamic> json) =>
    _$ReminderItemImpl(
      id: json['id'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      taskId: json['taskId'] as String,
      taskTitle: json['taskTitle'] as String,
      isProcessed: json['isProcessed'] as bool? ?? false,
    );

Map<String, dynamic> _$$ReminderItemImplToJson(_$ReminderItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dueDate': instance.dueDate.toIso8601String(),
      'taskId': instance.taskId,
      'taskTitle': instance.taskTitle,
      'isProcessed': instance.isProcessed,
    };
