// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ActionRecord _$ActionRecordFromJson(Map<String, dynamic> json) {
  return _ActionRecord.fromJson(json);
}

/// @nodoc
mixin _$ActionRecord {
  String get id => throw _privateConstructorUsedError;
  ActionType get type => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  Map<String, dynamic> get previousState => throw _privateConstructorUsedError;
  Map<String, dynamic> get newState => throw _privateConstructorUsedError;
  String? get entityId => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this ActionRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActionRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActionRecordCopyWith<ActionRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionRecordCopyWith<$Res> {
  factory $ActionRecordCopyWith(
          ActionRecord value, $Res Function(ActionRecord) then) =
      _$ActionRecordCopyWithImpl<$Res, ActionRecord>;
  @useResult
  $Res call(
      {String id,
      ActionType type,
      DateTime timestamp,
      Map<String, dynamic> previousState,
      Map<String, dynamic> newState,
      String? entityId,
      String? description});
}

/// @nodoc
class _$ActionRecordCopyWithImpl<$Res, $Val extends ActionRecord>
    implements $ActionRecordCopyWith<$Res> {
  _$ActionRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? timestamp = null,
    Object? previousState = null,
    Object? newState = null,
    Object? entityId = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActionType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      previousState: null == previousState
          ? _value.previousState
          : previousState // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      newState: null == newState
          ? _value.newState
          : newState // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      entityId: freezed == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActionRecordImplCopyWith<$Res>
    implements $ActionRecordCopyWith<$Res> {
  factory _$$ActionRecordImplCopyWith(
          _$ActionRecordImpl value, $Res Function(_$ActionRecordImpl) then) =
      __$$ActionRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      ActionType type,
      DateTime timestamp,
      Map<String, dynamic> previousState,
      Map<String, dynamic> newState,
      String? entityId,
      String? description});
}

/// @nodoc
class __$$ActionRecordImplCopyWithImpl<$Res>
    extends _$ActionRecordCopyWithImpl<$Res, _$ActionRecordImpl>
    implements _$$ActionRecordImplCopyWith<$Res> {
  __$$ActionRecordImplCopyWithImpl(
      _$ActionRecordImpl _value, $Res Function(_$ActionRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? timestamp = null,
    Object? previousState = null,
    Object? newState = null,
    Object? entityId = freezed,
    Object? description = freezed,
  }) {
    return _then(_$ActionRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActionType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      previousState: null == previousState
          ? _value._previousState
          : previousState // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      newState: null == newState
          ? _value._newState
          : newState // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      entityId: freezed == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActionRecordImpl implements _ActionRecord {
  const _$ActionRecordImpl(
      {required this.id,
      required this.type,
      required this.timestamp,
      required final Map<String, dynamic> previousState,
      required final Map<String, dynamic> newState,
      this.entityId,
      this.description})
      : _previousState = previousState,
        _newState = newState;

  factory _$ActionRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActionRecordImplFromJson(json);

  @override
  final String id;
  @override
  final ActionType type;
  @override
  final DateTime timestamp;
  final Map<String, dynamic> _previousState;
  @override
  Map<String, dynamic> get previousState {
    if (_previousState is EqualUnmodifiableMapView) return _previousState;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_previousState);
  }

  final Map<String, dynamic> _newState;
  @override
  Map<String, dynamic> get newState {
    if (_newState is EqualUnmodifiableMapView) return _newState;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_newState);
  }

  @override
  final String? entityId;
  @override
  final String? description;

  @override
  String toString() {
    return 'ActionRecord(id: $id, type: $type, timestamp: $timestamp, previousState: $previousState, newState: $newState, entityId: $entityId, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality()
                .equals(other._previousState, _previousState) &&
            const DeepCollectionEquality().equals(other._newState, _newState) &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      timestamp,
      const DeepCollectionEquality().hash(_previousState),
      const DeepCollectionEquality().hash(_newState),
      entityId,
      description);

  /// Create a copy of ActionRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionRecordImplCopyWith<_$ActionRecordImpl> get copyWith =>
      __$$ActionRecordImplCopyWithImpl<_$ActionRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActionRecordImplToJson(
      this,
    );
  }
}

abstract class _ActionRecord implements ActionRecord {
  const factory _ActionRecord(
      {required final String id,
      required final ActionType type,
      required final DateTime timestamp,
      required final Map<String, dynamic> previousState,
      required final Map<String, dynamic> newState,
      final String? entityId,
      final String? description}) = _$ActionRecordImpl;

  factory _ActionRecord.fromJson(Map<String, dynamic> json) =
      _$ActionRecordImpl.fromJson;

  @override
  String get id;
  @override
  ActionType get type;
  @override
  DateTime get timestamp;
  @override
  Map<String, dynamic> get previousState;
  @override
  Map<String, dynamic> get newState;
  @override
  String? get entityId;
  @override
  String? get description;

  /// Create a copy of ActionRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionRecordImplCopyWith<_$ActionRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
