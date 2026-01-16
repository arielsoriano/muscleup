// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RoutineFormState {
  WorkoutRoutine get routine => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WorkoutRoutine routine, bool isNew, bool isSaving)
        editing,
    required TResult Function(WorkoutRoutine routine, bool isNew) saving,
    required TResult Function(WorkoutRoutine routine) success,
    required TResult Function(
            WorkoutRoutine routine, bool isNew, String message)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(WorkoutRoutine routine, bool isNew, bool isSaving)?
        editing,
    TResult? Function(WorkoutRoutine routine, bool isNew)? saving,
    TResult? Function(WorkoutRoutine routine)? success,
    TResult? Function(WorkoutRoutine routine, bool isNew, String message)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WorkoutRoutine routine, bool isNew, bool isSaving)?
        editing,
    TResult Function(WorkoutRoutine routine, bool isNew)? saving,
    TResult Function(WorkoutRoutine routine)? success,
    TResult Function(WorkoutRoutine routine, bool isNew, String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoutineFormStateEditing value) editing,
    required TResult Function(RoutineFormStateSaving value) saving,
    required TResult Function(RoutineFormStateSuccess value) success,
    required TResult Function(RoutineFormStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoutineFormStateEditing value)? editing,
    TResult? Function(RoutineFormStateSaving value)? saving,
    TResult? Function(RoutineFormStateSuccess value)? success,
    TResult? Function(RoutineFormStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoutineFormStateEditing value)? editing,
    TResult Function(RoutineFormStateSaving value)? saving,
    TResult Function(RoutineFormStateSuccess value)? success,
    TResult Function(RoutineFormStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoutineFormStateCopyWith<RoutineFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutineFormStateCopyWith<$Res> {
  factory $RoutineFormStateCopyWith(
          RoutineFormState value, $Res Function(RoutineFormState) then) =
      _$RoutineFormStateCopyWithImpl<$Res, RoutineFormState>;
  @useResult
  $Res call({WorkoutRoutine routine});

  $WorkoutRoutineCopyWith<$Res> get routine;
}

/// @nodoc
class _$RoutineFormStateCopyWithImpl<$Res, $Val extends RoutineFormState>
    implements $RoutineFormStateCopyWith<$Res> {
  _$RoutineFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routine = null,
  }) {
    return _then(_value.copyWith(
      routine: null == routine
          ? _value.routine
          : routine // ignore: cast_nullable_to_non_nullable
              as WorkoutRoutine,
    ) as $Val);
  }

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutRoutineCopyWith<$Res> get routine {
    return $WorkoutRoutineCopyWith<$Res>(_value.routine, (value) {
      return _then(_value.copyWith(routine: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RoutineFormStateEditingImplCopyWith<$Res>
    implements $RoutineFormStateCopyWith<$Res> {
  factory _$$RoutineFormStateEditingImplCopyWith(
          _$RoutineFormStateEditingImpl value,
          $Res Function(_$RoutineFormStateEditingImpl) then) =
      __$$RoutineFormStateEditingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WorkoutRoutine routine, bool isNew, bool isSaving});

  @override
  $WorkoutRoutineCopyWith<$Res> get routine;
}

/// @nodoc
class __$$RoutineFormStateEditingImplCopyWithImpl<$Res>
    extends _$RoutineFormStateCopyWithImpl<$Res, _$RoutineFormStateEditingImpl>
    implements _$$RoutineFormStateEditingImplCopyWith<$Res> {
  __$$RoutineFormStateEditingImplCopyWithImpl(
      _$RoutineFormStateEditingImpl _value,
      $Res Function(_$RoutineFormStateEditingImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routine = null,
    Object? isNew = null,
    Object? isSaving = null,
  }) {
    return _then(_$RoutineFormStateEditingImpl(
      routine: null == routine
          ? _value.routine
          : routine // ignore: cast_nullable_to_non_nullable
              as WorkoutRoutine,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RoutineFormStateEditingImpl implements RoutineFormStateEditing {
  const _$RoutineFormStateEditingImpl(
      {required this.routine, required this.isNew, this.isSaving = false});

  @override
  final WorkoutRoutine routine;
  @override
  final bool isNew;
  @override
  @JsonKey()
  final bool isSaving;

  @override
  String toString() {
    return 'RoutineFormState.editing(routine: $routine, isNew: $isNew, isSaving: $isSaving)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineFormStateEditingImpl &&
            (identical(other.routine, routine) || other.routine == routine) &&
            (identical(other.isNew, isNew) || other.isNew == isNew) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving));
  }

  @override
  int get hashCode => Object.hash(runtimeType, routine, isNew, isSaving);

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineFormStateEditingImplCopyWith<_$RoutineFormStateEditingImpl>
      get copyWith => __$$RoutineFormStateEditingImplCopyWithImpl<
          _$RoutineFormStateEditingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WorkoutRoutine routine, bool isNew, bool isSaving)
        editing,
    required TResult Function(WorkoutRoutine routine, bool isNew) saving,
    required TResult Function(WorkoutRoutine routine) success,
    required TResult Function(
            WorkoutRoutine routine, bool isNew, String message)
        error,
  }) {
    return editing(routine, isNew, isSaving);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(WorkoutRoutine routine, bool isNew, bool isSaving)?
        editing,
    TResult? Function(WorkoutRoutine routine, bool isNew)? saving,
    TResult? Function(WorkoutRoutine routine)? success,
    TResult? Function(WorkoutRoutine routine, bool isNew, String message)?
        error,
  }) {
    return editing?.call(routine, isNew, isSaving);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WorkoutRoutine routine, bool isNew, bool isSaving)?
        editing,
    TResult Function(WorkoutRoutine routine, bool isNew)? saving,
    TResult Function(WorkoutRoutine routine)? success,
    TResult Function(WorkoutRoutine routine, bool isNew, String message)? error,
    required TResult orElse(),
  }) {
    if (editing != null) {
      return editing(routine, isNew, isSaving);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoutineFormStateEditing value) editing,
    required TResult Function(RoutineFormStateSaving value) saving,
    required TResult Function(RoutineFormStateSuccess value) success,
    required TResult Function(RoutineFormStateError value) error,
  }) {
    return editing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoutineFormStateEditing value)? editing,
    TResult? Function(RoutineFormStateSaving value)? saving,
    TResult? Function(RoutineFormStateSuccess value)? success,
    TResult? Function(RoutineFormStateError value)? error,
  }) {
    return editing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoutineFormStateEditing value)? editing,
    TResult Function(RoutineFormStateSaving value)? saving,
    TResult Function(RoutineFormStateSuccess value)? success,
    TResult Function(RoutineFormStateError value)? error,
    required TResult orElse(),
  }) {
    if (editing != null) {
      return editing(this);
    }
    return orElse();
  }
}

abstract class RoutineFormStateEditing implements RoutineFormState {
  const factory RoutineFormStateEditing(
      {required final WorkoutRoutine routine,
      required final bool isNew,
      final bool isSaving}) = _$RoutineFormStateEditingImpl;

  @override
  WorkoutRoutine get routine;
  bool get isNew;
  bool get isSaving;

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutineFormStateEditingImplCopyWith<_$RoutineFormStateEditingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RoutineFormStateSavingImplCopyWith<$Res>
    implements $RoutineFormStateCopyWith<$Res> {
  factory _$$RoutineFormStateSavingImplCopyWith(
          _$RoutineFormStateSavingImpl value,
          $Res Function(_$RoutineFormStateSavingImpl) then) =
      __$$RoutineFormStateSavingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WorkoutRoutine routine, bool isNew});

  @override
  $WorkoutRoutineCopyWith<$Res> get routine;
}

/// @nodoc
class __$$RoutineFormStateSavingImplCopyWithImpl<$Res>
    extends _$RoutineFormStateCopyWithImpl<$Res, _$RoutineFormStateSavingImpl>
    implements _$$RoutineFormStateSavingImplCopyWith<$Res> {
  __$$RoutineFormStateSavingImplCopyWithImpl(
      _$RoutineFormStateSavingImpl _value,
      $Res Function(_$RoutineFormStateSavingImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routine = null,
    Object? isNew = null,
  }) {
    return _then(_$RoutineFormStateSavingImpl(
      routine: null == routine
          ? _value.routine
          : routine // ignore: cast_nullable_to_non_nullable
              as WorkoutRoutine,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RoutineFormStateSavingImpl implements RoutineFormStateSaving {
  const _$RoutineFormStateSavingImpl(
      {required this.routine, required this.isNew});

  @override
  final WorkoutRoutine routine;
  @override
  final bool isNew;

  @override
  String toString() {
    return 'RoutineFormState.saving(routine: $routine, isNew: $isNew)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineFormStateSavingImpl &&
            (identical(other.routine, routine) || other.routine == routine) &&
            (identical(other.isNew, isNew) || other.isNew == isNew));
  }

  @override
  int get hashCode => Object.hash(runtimeType, routine, isNew);

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineFormStateSavingImplCopyWith<_$RoutineFormStateSavingImpl>
      get copyWith => __$$RoutineFormStateSavingImplCopyWithImpl<
          _$RoutineFormStateSavingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WorkoutRoutine routine, bool isNew, bool isSaving)
        editing,
    required TResult Function(WorkoutRoutine routine, bool isNew) saving,
    required TResult Function(WorkoutRoutine routine) success,
    required TResult Function(
            WorkoutRoutine routine, bool isNew, String message)
        error,
  }) {
    return saving(routine, isNew);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(WorkoutRoutine routine, bool isNew, bool isSaving)?
        editing,
    TResult? Function(WorkoutRoutine routine, bool isNew)? saving,
    TResult? Function(WorkoutRoutine routine)? success,
    TResult? Function(WorkoutRoutine routine, bool isNew, String message)?
        error,
  }) {
    return saving?.call(routine, isNew);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WorkoutRoutine routine, bool isNew, bool isSaving)?
        editing,
    TResult Function(WorkoutRoutine routine, bool isNew)? saving,
    TResult Function(WorkoutRoutine routine)? success,
    TResult Function(WorkoutRoutine routine, bool isNew, String message)? error,
    required TResult orElse(),
  }) {
    if (saving != null) {
      return saving(routine, isNew);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoutineFormStateEditing value) editing,
    required TResult Function(RoutineFormStateSaving value) saving,
    required TResult Function(RoutineFormStateSuccess value) success,
    required TResult Function(RoutineFormStateError value) error,
  }) {
    return saving(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoutineFormStateEditing value)? editing,
    TResult? Function(RoutineFormStateSaving value)? saving,
    TResult? Function(RoutineFormStateSuccess value)? success,
    TResult? Function(RoutineFormStateError value)? error,
  }) {
    return saving?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoutineFormStateEditing value)? editing,
    TResult Function(RoutineFormStateSaving value)? saving,
    TResult Function(RoutineFormStateSuccess value)? success,
    TResult Function(RoutineFormStateError value)? error,
    required TResult orElse(),
  }) {
    if (saving != null) {
      return saving(this);
    }
    return orElse();
  }
}

abstract class RoutineFormStateSaving implements RoutineFormState {
  const factory RoutineFormStateSaving(
      {required final WorkoutRoutine routine,
      required final bool isNew}) = _$RoutineFormStateSavingImpl;

  @override
  WorkoutRoutine get routine;
  bool get isNew;

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutineFormStateSavingImplCopyWith<_$RoutineFormStateSavingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RoutineFormStateSuccessImplCopyWith<$Res>
    implements $RoutineFormStateCopyWith<$Res> {
  factory _$$RoutineFormStateSuccessImplCopyWith(
          _$RoutineFormStateSuccessImpl value,
          $Res Function(_$RoutineFormStateSuccessImpl) then) =
      __$$RoutineFormStateSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WorkoutRoutine routine});

  @override
  $WorkoutRoutineCopyWith<$Res> get routine;
}

/// @nodoc
class __$$RoutineFormStateSuccessImplCopyWithImpl<$Res>
    extends _$RoutineFormStateCopyWithImpl<$Res, _$RoutineFormStateSuccessImpl>
    implements _$$RoutineFormStateSuccessImplCopyWith<$Res> {
  __$$RoutineFormStateSuccessImplCopyWithImpl(
      _$RoutineFormStateSuccessImpl _value,
      $Res Function(_$RoutineFormStateSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routine = null,
  }) {
    return _then(_$RoutineFormStateSuccessImpl(
      routine: null == routine
          ? _value.routine
          : routine // ignore: cast_nullable_to_non_nullable
              as WorkoutRoutine,
    ));
  }
}

/// @nodoc

class _$RoutineFormStateSuccessImpl implements RoutineFormStateSuccess {
  const _$RoutineFormStateSuccessImpl({required this.routine});

  @override
  final WorkoutRoutine routine;

  @override
  String toString() {
    return 'RoutineFormState.success(routine: $routine)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineFormStateSuccessImpl &&
            (identical(other.routine, routine) || other.routine == routine));
  }

  @override
  int get hashCode => Object.hash(runtimeType, routine);

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineFormStateSuccessImplCopyWith<_$RoutineFormStateSuccessImpl>
      get copyWith => __$$RoutineFormStateSuccessImplCopyWithImpl<
          _$RoutineFormStateSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WorkoutRoutine routine, bool isNew, bool isSaving)
        editing,
    required TResult Function(WorkoutRoutine routine, bool isNew) saving,
    required TResult Function(WorkoutRoutine routine) success,
    required TResult Function(
            WorkoutRoutine routine, bool isNew, String message)
        error,
  }) {
    return success(routine);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(WorkoutRoutine routine, bool isNew, bool isSaving)?
        editing,
    TResult? Function(WorkoutRoutine routine, bool isNew)? saving,
    TResult? Function(WorkoutRoutine routine)? success,
    TResult? Function(WorkoutRoutine routine, bool isNew, String message)?
        error,
  }) {
    return success?.call(routine);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WorkoutRoutine routine, bool isNew, bool isSaving)?
        editing,
    TResult Function(WorkoutRoutine routine, bool isNew)? saving,
    TResult Function(WorkoutRoutine routine)? success,
    TResult Function(WorkoutRoutine routine, bool isNew, String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(routine);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoutineFormStateEditing value) editing,
    required TResult Function(RoutineFormStateSaving value) saving,
    required TResult Function(RoutineFormStateSuccess value) success,
    required TResult Function(RoutineFormStateError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoutineFormStateEditing value)? editing,
    TResult? Function(RoutineFormStateSaving value)? saving,
    TResult? Function(RoutineFormStateSuccess value)? success,
    TResult? Function(RoutineFormStateError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoutineFormStateEditing value)? editing,
    TResult Function(RoutineFormStateSaving value)? saving,
    TResult Function(RoutineFormStateSuccess value)? success,
    TResult Function(RoutineFormStateError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class RoutineFormStateSuccess implements RoutineFormState {
  const factory RoutineFormStateSuccess(
      {required final WorkoutRoutine routine}) = _$RoutineFormStateSuccessImpl;

  @override
  WorkoutRoutine get routine;

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutineFormStateSuccessImplCopyWith<_$RoutineFormStateSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RoutineFormStateErrorImplCopyWith<$Res>
    implements $RoutineFormStateCopyWith<$Res> {
  factory _$$RoutineFormStateErrorImplCopyWith(
          _$RoutineFormStateErrorImpl value,
          $Res Function(_$RoutineFormStateErrorImpl) then) =
      __$$RoutineFormStateErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WorkoutRoutine routine, bool isNew, String message});

  @override
  $WorkoutRoutineCopyWith<$Res> get routine;
}

/// @nodoc
class __$$RoutineFormStateErrorImplCopyWithImpl<$Res>
    extends _$RoutineFormStateCopyWithImpl<$Res, _$RoutineFormStateErrorImpl>
    implements _$$RoutineFormStateErrorImplCopyWith<$Res> {
  __$$RoutineFormStateErrorImplCopyWithImpl(_$RoutineFormStateErrorImpl _value,
      $Res Function(_$RoutineFormStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routine = null,
    Object? isNew = null,
    Object? message = null,
  }) {
    return _then(_$RoutineFormStateErrorImpl(
      routine: null == routine
          ? _value.routine
          : routine // ignore: cast_nullable_to_non_nullable
              as WorkoutRoutine,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RoutineFormStateErrorImpl implements RoutineFormStateError {
  const _$RoutineFormStateErrorImpl(
      {required this.routine, required this.isNew, required this.message});

  @override
  final WorkoutRoutine routine;
  @override
  final bool isNew;
  @override
  final String message;

  @override
  String toString() {
    return 'RoutineFormState.error(routine: $routine, isNew: $isNew, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineFormStateErrorImpl &&
            (identical(other.routine, routine) || other.routine == routine) &&
            (identical(other.isNew, isNew) || other.isNew == isNew) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, routine, isNew, message);

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineFormStateErrorImplCopyWith<_$RoutineFormStateErrorImpl>
      get copyWith => __$$RoutineFormStateErrorImplCopyWithImpl<
          _$RoutineFormStateErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WorkoutRoutine routine, bool isNew, bool isSaving)
        editing,
    required TResult Function(WorkoutRoutine routine, bool isNew) saving,
    required TResult Function(WorkoutRoutine routine) success,
    required TResult Function(
            WorkoutRoutine routine, bool isNew, String message)
        error,
  }) {
    return error(routine, isNew, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(WorkoutRoutine routine, bool isNew, bool isSaving)?
        editing,
    TResult? Function(WorkoutRoutine routine, bool isNew)? saving,
    TResult? Function(WorkoutRoutine routine)? success,
    TResult? Function(WorkoutRoutine routine, bool isNew, String message)?
        error,
  }) {
    return error?.call(routine, isNew, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WorkoutRoutine routine, bool isNew, bool isSaving)?
        editing,
    TResult Function(WorkoutRoutine routine, bool isNew)? saving,
    TResult Function(WorkoutRoutine routine)? success,
    TResult Function(WorkoutRoutine routine, bool isNew, String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(routine, isNew, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoutineFormStateEditing value) editing,
    required TResult Function(RoutineFormStateSaving value) saving,
    required TResult Function(RoutineFormStateSuccess value) success,
    required TResult Function(RoutineFormStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoutineFormStateEditing value)? editing,
    TResult? Function(RoutineFormStateSaving value)? saving,
    TResult? Function(RoutineFormStateSuccess value)? success,
    TResult? Function(RoutineFormStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoutineFormStateEditing value)? editing,
    TResult Function(RoutineFormStateSaving value)? saving,
    TResult Function(RoutineFormStateSuccess value)? success,
    TResult Function(RoutineFormStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class RoutineFormStateError implements RoutineFormState {
  const factory RoutineFormStateError(
      {required final WorkoutRoutine routine,
      required final bool isNew,
      required final String message}) = _$RoutineFormStateErrorImpl;

  @override
  WorkoutRoutine get routine;
  bool get isNew;
  String get message;

  /// Create a copy of RoutineFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutineFormStateErrorImplCopyWith<_$RoutineFormStateErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
