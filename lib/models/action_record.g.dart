// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActionRecordImpl _$$ActionRecordImplFromJson(Map<String, dynamic> json) =>
    _$ActionRecordImpl(
      id: json['id'] as String,
      type: $enumDecode(_$ActionTypeEnumMap, json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      previousState: json['previousState'] as Map<String, dynamic>,
      newState: json['newState'] as Map<String, dynamic>,
      entityId: json['entityId'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ActionRecordImplToJson(_$ActionRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ActionTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'previousState': instance.previousState,
      'newState': instance.newState,
      'entityId': instance.entityId,
      'description': instance.description,
    };

const _$ActionTypeEnumMap = {
  ActionType.createTask: 'createTask',
  ActionType.updateTask: 'updateTask',
  ActionType.deleteTask: 'deleteTask',
  ActionType.createCategory: 'createCategory',
  ActionType.updateCategory: 'updateCategory',
  ActionType.deleteCategory: 'deleteCategory',
  ActionType.moveTask: 'moveTask',
  ActionType.updatePriority: 'updatePriority',
  ActionType.toggleComplete: 'toggleComplete',
  ActionType.addTag: 'addTag',
  ActionType.removeTag: 'removeTag',
  ActionType.addAttachment: 'addAttachment',
  ActionType.removeAttachment: 'removeAttachment',
  ActionType.updateDueDate: 'updateDueDate',
};
