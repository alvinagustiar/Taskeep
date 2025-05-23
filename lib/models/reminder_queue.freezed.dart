// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder_queue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReminderItem _$ReminderItemFromJson(Map<String, dynamic> json) {
  return _ReminderItem.fromJson(json);
}

/// @nodoc
mixin _$ReminderItem {
  String get id => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  String get taskId => throw _privateConstructorUsedError;
  String get taskTitle => throw _privateConstructorUsedError;
  bool get isProcessed => throw _privateConstructorUsedError;

  /// Serializes this ReminderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReminderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReminderItemCopyWith<ReminderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderItemCopyWith<$Res> {
  factory $ReminderItemCopyWith(
          ReminderItem value, $Res Function(ReminderItem) then) =
      _$ReminderItemCopyWithImpl<$Res, ReminderItem>;
  @useResult
  $Res call(
      {String id,
      DateTime dueDate,
      String taskId,
      String taskTitle,
      bool isProcessed});
}

/// @nodoc
class _$ReminderItemCopyWithImpl<$Res, $Val extends ReminderItem>
    implements $ReminderItemCopyWith<$Res> {
  _$ReminderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReminderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dueDate = null,
    Object? taskId = null,
    Object? taskTitle = null,
    Object? isProcessed = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      taskTitle: null == taskTitle
          ? _value.taskTitle
          : taskTitle // ignore: cast_nullable_to_non_nullable
              as String,
      isProcessed: null == isProcessed
          ? _value.isProcessed
          : isProcessed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReminderItemImplCopyWith<$Res>
    implements $ReminderItemCopyWith<$Res> {
  factory _$$ReminderItemImplCopyWith(
          _$ReminderItemImpl value, $Res Function(_$ReminderItemImpl) then) =
      __$$ReminderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime dueDate,
      String taskId,
      String taskTitle,
      bool isProcessed});
}

/// @nodoc
class __$$ReminderItemImplCopyWithImpl<$Res>
    extends _$ReminderItemCopyWithImpl<$Res, _$ReminderItemImpl>
    implements _$$ReminderItemImplCopyWith<$Res> {
  __$$ReminderItemImplCopyWithImpl(
      _$ReminderItemImpl _value, $Res Function(_$ReminderItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dueDate = null,
    Object? taskId = null,
    Object? taskTitle = null,
    Object? isProcessed = null,
  }) {
    return _then(_$ReminderItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      taskTitle: null == taskTitle
          ? _value.taskTitle
          : taskTitle // ignore: cast_nullable_to_non_nullable
              as String,
      isProcessed: null == isProcessed
          ? _value.isProcessed
          : isProcessed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReminderItemImpl implements _ReminderItem {
  const _$ReminderItemImpl(
      {required this.id,
      required this.dueDate,
      required this.taskId,
      required this.taskTitle,
      this.isProcessed = false});

  factory _$ReminderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReminderItemImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime dueDate;
  @override
  final String taskId;
  @override
  final String taskTitle;
  @override
  @JsonKey()
  final bool isProcessed;

  @override
  String toString() {
    return 'ReminderItem(id: $id, dueDate: $dueDate, taskId: $taskId, taskTitle: $taskTitle, isProcessed: $isProcessed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.taskTitle, taskTitle) ||
                other.taskTitle == taskTitle) &&
            (identical(other.isProcessed, isProcessed) ||
                other.isProcessed == isProcessed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, dueDate, taskId, taskTitle, isProcessed);

  /// Create a copy of ReminderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderItemImplCopyWith<_$ReminderItemImpl> get copyWith =>
      __$$ReminderItemImplCopyWithImpl<_$ReminderItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReminderItemImplToJson(
      this,
    );
  }
}

abstract class _ReminderItem implements ReminderItem {
  const factory _ReminderItem(
      {required final String id,
      required final DateTime dueDate,
      required final String taskId,
      required final String taskTitle,
      final bool isProcessed}) = _$ReminderItemImpl;

  factory _ReminderItem.fromJson(Map<String, dynamic> json) =
      _$ReminderItemImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get dueDate;
  @override
  String get taskId;
  @override
  String get taskTitle;
  @override
  bool get isProcessed;

  /// Create a copy of ReminderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReminderItemImplCopyWith<_$ReminderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
