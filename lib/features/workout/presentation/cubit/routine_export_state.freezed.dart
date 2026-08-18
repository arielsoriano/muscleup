// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_export_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RoutineExportState {
  bool get isLoading => throw _privateConstructorUsedError;

  /// The serialized routines, ready to be copied. Empty while loading, and
  /// also when the user has no routines at all.
  String get json => throw _privateConstructorUsedError;
  int get routineCount => throw _privateConstructorUsedError;
  int get exerciseCount => throw _privateConstructorUsedError;
  int get setCount => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of RoutineExportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoutineExportStateCopyWith<RoutineExportState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutineExportStateCopyWith<$Res> {
  factory $RoutineExportStateCopyWith(
          RoutineExportState value, $Res Function(RoutineExportState) then) =
      _$RoutineExportStateCopyWithImpl<$Res, RoutineExportState>;
  @useResult
  $Res call(
      {bool isLoading,
      String json,
      int routineCount,
      int exerciseCount,
      int setCount,
      String? errorMessage});
}

/// @nodoc
class _$RoutineExportStateCopyWithImpl<$Res, $Val extends RoutineExportState>
    implements $RoutineExportStateCopyWith<$Res> {
  _$RoutineExportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoutineExportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? json = null,
    Object? routineCount = null,
    Object? exerciseCount = null,
    Object? setCount = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      json: null == json
          ? _value.json
          : json // ignore: cast_nullable_to_non_nullable
              as String,
      routineCount: null == routineCount
          ? _value.routineCount
          : routineCount // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseCount: null == exerciseCount
          ? _value.exerciseCount
          : exerciseCount // ignore: cast_nullable_to_non_nullable
              as int,
      setCount: null == setCount
          ? _value.setCount
          : setCount // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoutineExportStateImplCopyWith<$Res>
    implements $RoutineExportStateCopyWith<$Res> {
  factory _$$RoutineExportStateImplCopyWith(_$RoutineExportStateImpl value,
          $Res Function(_$RoutineExportStateImpl) then) =
      __$$RoutineExportStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String json,
      int routineCount,
      int exerciseCount,
      int setCount,
      String? errorMessage});
}

/// @nodoc
class __$$RoutineExportStateImplCopyWithImpl<$Res>
    extends _$RoutineExportStateCopyWithImpl<$Res, _$RoutineExportStateImpl>
    implements _$$RoutineExportStateImplCopyWith<$Res> {
  __$$RoutineExportStateImplCopyWithImpl(_$RoutineExportStateImpl _value,
      $Res Function(_$RoutineExportStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoutineExportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? json = null,
    Object? routineCount = null,
    Object? exerciseCount = null,
    Object? setCount = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$RoutineExportStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      json: null == json
          ? _value.json
          : json // ignore: cast_nullable_to_non_nullable
              as String,
      routineCount: null == routineCount
          ? _value.routineCount
          : routineCount // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseCount: null == exerciseCount
          ? _value.exerciseCount
          : exerciseCount // ignore: cast_nullable_to_non_nullable
              as int,
      setCount: null == setCount
          ? _value.setCount
          : setCount // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RoutineExportStateImpl implements _RoutineExportState {
  const _$RoutineExportStateImpl(
      {this.isLoading = true,
      this.json = '',
      this.routineCount = 0,
      this.exerciseCount = 0,
      this.setCount = 0,
      this.errorMessage});

  @override
  @JsonKey()
  final bool isLoading;

  /// The serialized routines, ready to be copied. Empty while loading, and
  /// also when the user has no routines at all.
  @override
  @JsonKey()
  final String json;
  @override
  @JsonKey()
  final int routineCount;
  @override
  @JsonKey()
  final int exerciseCount;
  @override
  @JsonKey()
  final int setCount;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'RoutineExportState(isLoading: $isLoading, json: $json, routineCount: $routineCount, exerciseCount: $exerciseCount, setCount: $setCount, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineExportStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.json, json) || other.json == json) &&
            (identical(other.routineCount, routineCount) ||
                other.routineCount == routineCount) &&
            (identical(other.exerciseCount, exerciseCount) ||
                other.exerciseCount == exerciseCount) &&
            (identical(other.setCount, setCount) ||
                other.setCount == setCount) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, json, routineCount,
      exerciseCount, setCount, errorMessage);

  /// Create a copy of RoutineExportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineExportStateImplCopyWith<_$RoutineExportStateImpl> get copyWith =>
      __$$RoutineExportStateImplCopyWithImpl<_$RoutineExportStateImpl>(
          this, _$identity);
}

abstract class _RoutineExportState implements RoutineExportState {
  const factory _RoutineExportState(
      {final bool isLoading,
      final String json,
      final int routineCount,
      final int exerciseCount,
      final int setCount,
      final String? errorMessage}) = _$RoutineExportStateImpl;

  @override
  bool get isLoading;

  /// The serialized routines, ready to be copied. Empty while loading, and
  /// also when the user has no routines at all.
  @override
  String get json;
  @override
  int get routineCount;
  @override
  int get exerciseCount;
  @override
  int get setCount;
  @override
  String? get errorMessage;

  /// Create a copy of RoutineExportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutineExportStateImplCopyWith<_$RoutineExportStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
