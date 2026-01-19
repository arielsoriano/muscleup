// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_workout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ActiveWorkoutState {
  WorkoutRoutine get routine => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)
        initial,
    required TResult Function(WorkoutRoutine routine, bool isLoading) loading,
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)
        tracking,
    required TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)
        saving,
    required TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)
        success,
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        initial,
    TResult? Function(WorkoutRoutine routine, bool isLoading)? loading,
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        tracking,
    TResult? Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        saving,
    TResult? Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        success,
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        initial,
    TResult Function(WorkoutRoutine routine, bool isLoading)? loading,
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        tracking,
    TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        saving,
    TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        success,
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveWorkoutStateInitial value) initial,
    required TResult Function(ActiveWorkoutStateLoading value) loading,
    required TResult Function(ActiveWorkoutStateTracking value) tracking,
    required TResult Function(ActiveWorkoutStateSaving value) saving,
    required TResult Function(ActiveWorkoutStateSuccess value) success,
    required TResult Function(ActiveWorkoutStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveWorkoutStateInitial value)? initial,
    TResult? Function(ActiveWorkoutStateLoading value)? loading,
    TResult? Function(ActiveWorkoutStateTracking value)? tracking,
    TResult? Function(ActiveWorkoutStateSaving value)? saving,
    TResult? Function(ActiveWorkoutStateSuccess value)? success,
    TResult? Function(ActiveWorkoutStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveWorkoutStateInitial value)? initial,
    TResult Function(ActiveWorkoutStateLoading value)? loading,
    TResult Function(ActiveWorkoutStateTracking value)? tracking,
    TResult Function(ActiveWorkoutStateSaving value)? saving,
    TResult Function(ActiveWorkoutStateSuccess value)? success,
    TResult Function(ActiveWorkoutStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActiveWorkoutStateCopyWith<ActiveWorkoutState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveWorkoutStateCopyWith<$Res> {
  factory $ActiveWorkoutStateCopyWith(
          ActiveWorkoutState value, $Res Function(ActiveWorkoutState) then) =
      _$ActiveWorkoutStateCopyWithImpl<$Res, ActiveWorkoutState>;
  @useResult
  $Res call({WorkoutRoutine routine, bool isLoading});

  $WorkoutRoutineCopyWith<$Res> get routine;
}

/// @nodoc
class _$ActiveWorkoutStateCopyWithImpl<$Res, $Val extends ActiveWorkoutState>
    implements $ActiveWorkoutStateCopyWith<$Res> {
  _$ActiveWorkoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routine = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      routine: null == routine
          ? _value.routine
          : routine // ignore: cast_nullable_to_non_nullable
              as WorkoutRoutine,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of ActiveWorkoutState
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
abstract class _$$ActiveWorkoutStateInitialImplCopyWith<$Res>
    implements $ActiveWorkoutStateCopyWith<$Res> {
  factory _$$ActiveWorkoutStateInitialImplCopyWith(
          _$ActiveWorkoutStateInitialImpl value,
          $Res Function(_$ActiveWorkoutStateInitialImpl) then) =
      __$$ActiveWorkoutStateInitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {WorkoutRoutine routine,
      List<SetLog> setLogs,
      bool isSaving,
      bool isLoading});

  @override
  $WorkoutRoutineCopyWith<$Res> get routine;
}

/// @nodoc
class __$$ActiveWorkoutStateInitialImplCopyWithImpl<$Res>
    extends _$ActiveWorkoutStateCopyWithImpl<$Res,
        _$ActiveWorkoutStateInitialImpl>
    implements _$$ActiveWorkoutStateInitialImplCopyWith<$Res> {
  __$$ActiveWorkoutStateInitialImplCopyWithImpl(
      _$ActiveWorkoutStateInitialImpl _value,
      $Res Function(_$ActiveWorkoutStateInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routine = null,
    Object? setLogs = null,
    Object? isSaving = null,
    Object? isLoading = null,
  }) {
    return _then(_$ActiveWorkoutStateInitialImpl(
      routine: null == routine
          ? _value.routine
          : routine // ignore: cast_nullable_to_non_nullable
              as WorkoutRoutine,
      setLogs: null == setLogs
          ? _value._setLogs
          : setLogs // ignore: cast_nullable_to_non_nullable
              as List<SetLog>,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ActiveWorkoutStateInitialImpl implements ActiveWorkoutStateInitial {
  const _$ActiveWorkoutStateInitialImpl(
      {required this.routine,
      final List<SetLog> setLogs = const [],
      this.isSaving = false,
      this.isLoading = false})
      : _setLogs = setLogs;

  @override
  final WorkoutRoutine routine;
  final List<SetLog> _setLogs;
  @override
  @JsonKey()
  List<SetLog> get setLogs {
    if (_setLogs is EqualUnmodifiableListView) return _setLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_setLogs);
  }

  @override
  @JsonKey()
  final bool isSaving;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'ActiveWorkoutState.initial(routine: $routine, setLogs: $setLogs, isSaving: $isSaving, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveWorkoutStateInitialImpl &&
            (identical(other.routine, routine) || other.routine == routine) &&
            const DeepCollectionEquality().equals(other._setLogs, _setLogs) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, routine,
      const DeepCollectionEquality().hash(_setLogs), isSaving, isLoading);

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveWorkoutStateInitialImplCopyWith<_$ActiveWorkoutStateInitialImpl>
      get copyWith => __$$ActiveWorkoutStateInitialImplCopyWithImpl<
          _$ActiveWorkoutStateInitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)
        initial,
    required TResult Function(WorkoutRoutine routine, bool isLoading) loading,
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)
        tracking,
    required TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)
        saving,
    required TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)
        success,
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)
        error,
  }) {
    return initial(routine, setLogs, isSaving, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        initial,
    TResult? Function(WorkoutRoutine routine, bool isLoading)? loading,
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        tracking,
    TResult? Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        saving,
    TResult? Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        success,
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)?
        error,
  }) {
    return initial?.call(routine, setLogs, isSaving, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        initial,
    TResult Function(WorkoutRoutine routine, bool isLoading)? loading,
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        tracking,
    TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        saving,
    TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        success,
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)?
        error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(routine, setLogs, isSaving, isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveWorkoutStateInitial value) initial,
    required TResult Function(ActiveWorkoutStateLoading value) loading,
    required TResult Function(ActiveWorkoutStateTracking value) tracking,
    required TResult Function(ActiveWorkoutStateSaving value) saving,
    required TResult Function(ActiveWorkoutStateSuccess value) success,
    required TResult Function(ActiveWorkoutStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveWorkoutStateInitial value)? initial,
    TResult? Function(ActiveWorkoutStateLoading value)? loading,
    TResult? Function(ActiveWorkoutStateTracking value)? tracking,
    TResult? Function(ActiveWorkoutStateSaving value)? saving,
    TResult? Function(ActiveWorkoutStateSuccess value)? success,
    TResult? Function(ActiveWorkoutStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveWorkoutStateInitial value)? initial,
    TResult Function(ActiveWorkoutStateLoading value)? loading,
    TResult Function(ActiveWorkoutStateTracking value)? tracking,
    TResult Function(ActiveWorkoutStateSaving value)? saving,
    TResult Function(ActiveWorkoutStateSuccess value)? success,
    TResult Function(ActiveWorkoutStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ActiveWorkoutStateInitial implements ActiveWorkoutState {
  const factory ActiveWorkoutStateInitial(
      {required final WorkoutRoutine routine,
      final List<SetLog> setLogs,
      final bool isSaving,
      final bool isLoading}) = _$ActiveWorkoutStateInitialImpl;

  @override
  WorkoutRoutine get routine;
  List<SetLog> get setLogs;
  bool get isSaving;
  @override
  bool get isLoading;

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveWorkoutStateInitialImplCopyWith<_$ActiveWorkoutStateInitialImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActiveWorkoutStateLoadingImplCopyWith<$Res>
    implements $ActiveWorkoutStateCopyWith<$Res> {
  factory _$$ActiveWorkoutStateLoadingImplCopyWith(
          _$ActiveWorkoutStateLoadingImpl value,
          $Res Function(_$ActiveWorkoutStateLoadingImpl) then) =
      __$$ActiveWorkoutStateLoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WorkoutRoutine routine, bool isLoading});

  @override
  $WorkoutRoutineCopyWith<$Res> get routine;
}

/// @nodoc
class __$$ActiveWorkoutStateLoadingImplCopyWithImpl<$Res>
    extends _$ActiveWorkoutStateCopyWithImpl<$Res,
        _$ActiveWorkoutStateLoadingImpl>
    implements _$$ActiveWorkoutStateLoadingImplCopyWith<$Res> {
  __$$ActiveWorkoutStateLoadingImplCopyWithImpl(
      _$ActiveWorkoutStateLoadingImpl _value,
      $Res Function(_$ActiveWorkoutStateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routine = null,
    Object? isLoading = null,
  }) {
    return _then(_$ActiveWorkoutStateLoadingImpl(
      routine: null == routine
          ? _value.routine
          : routine // ignore: cast_nullable_to_non_nullable
              as WorkoutRoutine,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ActiveWorkoutStateLoadingImpl implements ActiveWorkoutStateLoading {
  const _$ActiveWorkoutStateLoadingImpl(
      {required this.routine, this.isLoading = true});

  @override
  final WorkoutRoutine routine;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'ActiveWorkoutState.loading(routine: $routine, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveWorkoutStateLoadingImpl &&
            (identical(other.routine, routine) || other.routine == routine) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, routine, isLoading);

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveWorkoutStateLoadingImplCopyWith<_$ActiveWorkoutStateLoadingImpl>
      get copyWith => __$$ActiveWorkoutStateLoadingImplCopyWithImpl<
          _$ActiveWorkoutStateLoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)
        initial,
    required TResult Function(WorkoutRoutine routine, bool isLoading) loading,
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)
        tracking,
    required TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)
        saving,
    required TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)
        success,
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)
        error,
  }) {
    return loading(routine, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        initial,
    TResult? Function(WorkoutRoutine routine, bool isLoading)? loading,
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        tracking,
    TResult? Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        saving,
    TResult? Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        success,
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)?
        error,
  }) {
    return loading?.call(routine, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        initial,
    TResult Function(WorkoutRoutine routine, bool isLoading)? loading,
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        tracking,
    TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        saving,
    TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        success,
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(routine, isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveWorkoutStateInitial value) initial,
    required TResult Function(ActiveWorkoutStateLoading value) loading,
    required TResult Function(ActiveWorkoutStateTracking value) tracking,
    required TResult Function(ActiveWorkoutStateSaving value) saving,
    required TResult Function(ActiveWorkoutStateSuccess value) success,
    required TResult Function(ActiveWorkoutStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveWorkoutStateInitial value)? initial,
    TResult? Function(ActiveWorkoutStateLoading value)? loading,
    TResult? Function(ActiveWorkoutStateTracking value)? tracking,
    TResult? Function(ActiveWorkoutStateSaving value)? saving,
    TResult? Function(ActiveWorkoutStateSuccess value)? success,
    TResult? Function(ActiveWorkoutStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveWorkoutStateInitial value)? initial,
    TResult Function(ActiveWorkoutStateLoading value)? loading,
    TResult Function(ActiveWorkoutStateTracking value)? tracking,
    TResult Function(ActiveWorkoutStateSaving value)? saving,
    TResult Function(ActiveWorkoutStateSuccess value)? success,
    TResult Function(ActiveWorkoutStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ActiveWorkoutStateLoading implements ActiveWorkoutState {
  const factory ActiveWorkoutStateLoading(
      {required final WorkoutRoutine routine,
      final bool isLoading}) = _$ActiveWorkoutStateLoadingImpl;

  @override
  WorkoutRoutine get routine;
  @override
  bool get isLoading;

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveWorkoutStateLoadingImplCopyWith<_$ActiveWorkoutStateLoadingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActiveWorkoutStateTrackingImplCopyWith<$Res>
    implements $ActiveWorkoutStateCopyWith<$Res> {
  factory _$$ActiveWorkoutStateTrackingImplCopyWith(
          _$ActiveWorkoutStateTrackingImpl value,
          $Res Function(_$ActiveWorkoutStateTrackingImpl) then) =
      __$$ActiveWorkoutStateTrackingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {WorkoutRoutine routine,
      List<SetLog> setLogs,
      bool isSaving,
      bool isLoading});

  @override
  $WorkoutRoutineCopyWith<$Res> get routine;
}

/// @nodoc
class __$$ActiveWorkoutStateTrackingImplCopyWithImpl<$Res>
    extends _$ActiveWorkoutStateCopyWithImpl<$Res,
        _$ActiveWorkoutStateTrackingImpl>
    implements _$$ActiveWorkoutStateTrackingImplCopyWith<$Res> {
  __$$ActiveWorkoutStateTrackingImplCopyWithImpl(
      _$ActiveWorkoutStateTrackingImpl _value,
      $Res Function(_$ActiveWorkoutStateTrackingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routine = null,
    Object? setLogs = null,
    Object? isSaving = null,
    Object? isLoading = null,
  }) {
    return _then(_$ActiveWorkoutStateTrackingImpl(
      routine: null == routine
          ? _value.routine
          : routine // ignore: cast_nullable_to_non_nullable
              as WorkoutRoutine,
      setLogs: null == setLogs
          ? _value._setLogs
          : setLogs // ignore: cast_nullable_to_non_nullable
              as List<SetLog>,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ActiveWorkoutStateTrackingImpl implements ActiveWorkoutStateTracking {
  const _$ActiveWorkoutStateTrackingImpl(
      {required this.routine,
      required final List<SetLog> setLogs,
      this.isSaving = false,
      this.isLoading = false})
      : _setLogs = setLogs;

  @override
  final WorkoutRoutine routine;
  final List<SetLog> _setLogs;
  @override
  List<SetLog> get setLogs {
    if (_setLogs is EqualUnmodifiableListView) return _setLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_setLogs);
  }

  @override
  @JsonKey()
  final bool isSaving;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'ActiveWorkoutState.tracking(routine: $routine, setLogs: $setLogs, isSaving: $isSaving, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveWorkoutStateTrackingImpl &&
            (identical(other.routine, routine) || other.routine == routine) &&
            const DeepCollectionEquality().equals(other._setLogs, _setLogs) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, routine,
      const DeepCollectionEquality().hash(_setLogs), isSaving, isLoading);

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveWorkoutStateTrackingImplCopyWith<_$ActiveWorkoutStateTrackingImpl>
      get copyWith => __$$ActiveWorkoutStateTrackingImplCopyWithImpl<
          _$ActiveWorkoutStateTrackingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)
        initial,
    required TResult Function(WorkoutRoutine routine, bool isLoading) loading,
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)
        tracking,
    required TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)
        saving,
    required TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)
        success,
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)
        error,
  }) {
    return tracking(routine, setLogs, isSaving, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        initial,
    TResult? Function(WorkoutRoutine routine, bool isLoading)? loading,
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        tracking,
    TResult? Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        saving,
    TResult? Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        success,
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)?
        error,
  }) {
    return tracking?.call(routine, setLogs, isSaving, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        initial,
    TResult Function(WorkoutRoutine routine, bool isLoading)? loading,
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        tracking,
    TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        saving,
    TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        success,
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)?
        error,
    required TResult orElse(),
  }) {
    if (tracking != null) {
      return tracking(routine, setLogs, isSaving, isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveWorkoutStateInitial value) initial,
    required TResult Function(ActiveWorkoutStateLoading value) loading,
    required TResult Function(ActiveWorkoutStateTracking value) tracking,
    required TResult Function(ActiveWorkoutStateSaving value) saving,
    required TResult Function(ActiveWorkoutStateSuccess value) success,
    required TResult Function(ActiveWorkoutStateError value) error,
  }) {
    return tracking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveWorkoutStateInitial value)? initial,
    TResult? Function(ActiveWorkoutStateLoading value)? loading,
    TResult? Function(ActiveWorkoutStateTracking value)? tracking,
    TResult? Function(ActiveWorkoutStateSaving value)? saving,
    TResult? Function(ActiveWorkoutStateSuccess value)? success,
    TResult? Function(ActiveWorkoutStateError value)? error,
  }) {
    return tracking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveWorkoutStateInitial value)? initial,
    TResult Function(ActiveWorkoutStateLoading value)? loading,
    TResult Function(ActiveWorkoutStateTracking value)? tracking,
    TResult Function(ActiveWorkoutStateSaving value)? saving,
    TResult Function(ActiveWorkoutStateSuccess value)? success,
    TResult Function(ActiveWorkoutStateError value)? error,
    required TResult orElse(),
  }) {
    if (tracking != null) {
      return tracking(this);
    }
    return orElse();
  }
}

abstract class ActiveWorkoutStateTracking implements ActiveWorkoutState {
  const factory ActiveWorkoutStateTracking(
      {required final WorkoutRoutine routine,
      required final List<SetLog> setLogs,
      final bool isSaving,
      final bool isLoading}) = _$ActiveWorkoutStateTrackingImpl;

  @override
  WorkoutRoutine get routine;
  List<SetLog> get setLogs;
  bool get isSaving;
  @override
  bool get isLoading;

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveWorkoutStateTrackingImplCopyWith<_$ActiveWorkoutStateTrackingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActiveWorkoutStateSavingImplCopyWith<$Res>
    implements $ActiveWorkoutStateCopyWith<$Res> {
  factory _$$ActiveWorkoutStateSavingImplCopyWith(
          _$ActiveWorkoutStateSavingImpl value,
          $Res Function(_$ActiveWorkoutStateSavingImpl) then) =
      __$$ActiveWorkoutStateSavingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading});

  @override
  $WorkoutRoutineCopyWith<$Res> get routine;
}

/// @nodoc
class __$$ActiveWorkoutStateSavingImplCopyWithImpl<$Res>
    extends _$ActiveWorkoutStateCopyWithImpl<$Res,
        _$ActiveWorkoutStateSavingImpl>
    implements _$$ActiveWorkoutStateSavingImplCopyWith<$Res> {
  __$$ActiveWorkoutStateSavingImplCopyWithImpl(
      _$ActiveWorkoutStateSavingImpl _value,
      $Res Function(_$ActiveWorkoutStateSavingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routine = null,
    Object? setLogs = null,
    Object? isLoading = null,
  }) {
    return _then(_$ActiveWorkoutStateSavingImpl(
      routine: null == routine
          ? _value.routine
          : routine // ignore: cast_nullable_to_non_nullable
              as WorkoutRoutine,
      setLogs: null == setLogs
          ? _value._setLogs
          : setLogs // ignore: cast_nullable_to_non_nullable
              as List<SetLog>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ActiveWorkoutStateSavingImpl implements ActiveWorkoutStateSaving {
  const _$ActiveWorkoutStateSavingImpl(
      {required this.routine,
      required final List<SetLog> setLogs,
      this.isLoading = false})
      : _setLogs = setLogs;

  @override
  final WorkoutRoutine routine;
  final List<SetLog> _setLogs;
  @override
  List<SetLog> get setLogs {
    if (_setLogs is EqualUnmodifiableListView) return _setLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_setLogs);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'ActiveWorkoutState.saving(routine: $routine, setLogs: $setLogs, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveWorkoutStateSavingImpl &&
            (identical(other.routine, routine) || other.routine == routine) &&
            const DeepCollectionEquality().equals(other._setLogs, _setLogs) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, routine,
      const DeepCollectionEquality().hash(_setLogs), isLoading);

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveWorkoutStateSavingImplCopyWith<_$ActiveWorkoutStateSavingImpl>
      get copyWith => __$$ActiveWorkoutStateSavingImplCopyWithImpl<
          _$ActiveWorkoutStateSavingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)
        initial,
    required TResult Function(WorkoutRoutine routine, bool isLoading) loading,
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)
        tracking,
    required TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)
        saving,
    required TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)
        success,
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)
        error,
  }) {
    return saving(routine, setLogs, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        initial,
    TResult? Function(WorkoutRoutine routine, bool isLoading)? loading,
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        tracking,
    TResult? Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        saving,
    TResult? Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        success,
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)?
        error,
  }) {
    return saving?.call(routine, setLogs, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        initial,
    TResult Function(WorkoutRoutine routine, bool isLoading)? loading,
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        tracking,
    TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        saving,
    TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        success,
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)?
        error,
    required TResult orElse(),
  }) {
    if (saving != null) {
      return saving(routine, setLogs, isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveWorkoutStateInitial value) initial,
    required TResult Function(ActiveWorkoutStateLoading value) loading,
    required TResult Function(ActiveWorkoutStateTracking value) tracking,
    required TResult Function(ActiveWorkoutStateSaving value) saving,
    required TResult Function(ActiveWorkoutStateSuccess value) success,
    required TResult Function(ActiveWorkoutStateError value) error,
  }) {
    return saving(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveWorkoutStateInitial value)? initial,
    TResult? Function(ActiveWorkoutStateLoading value)? loading,
    TResult? Function(ActiveWorkoutStateTracking value)? tracking,
    TResult? Function(ActiveWorkoutStateSaving value)? saving,
    TResult? Function(ActiveWorkoutStateSuccess value)? success,
    TResult? Function(ActiveWorkoutStateError value)? error,
  }) {
    return saving?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveWorkoutStateInitial value)? initial,
    TResult Function(ActiveWorkoutStateLoading value)? loading,
    TResult Function(ActiveWorkoutStateTracking value)? tracking,
    TResult Function(ActiveWorkoutStateSaving value)? saving,
    TResult Function(ActiveWorkoutStateSuccess value)? success,
    TResult Function(ActiveWorkoutStateError value)? error,
    required TResult orElse(),
  }) {
    if (saving != null) {
      return saving(this);
    }
    return orElse();
  }
}

abstract class ActiveWorkoutStateSaving implements ActiveWorkoutState {
  const factory ActiveWorkoutStateSaving(
      {required final WorkoutRoutine routine,
      required final List<SetLog> setLogs,
      final bool isLoading}) = _$ActiveWorkoutStateSavingImpl;

  @override
  WorkoutRoutine get routine;
  List<SetLog> get setLogs;
  @override
  bool get isLoading;

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveWorkoutStateSavingImplCopyWith<_$ActiveWorkoutStateSavingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActiveWorkoutStateSuccessImplCopyWith<$Res>
    implements $ActiveWorkoutStateCopyWith<$Res> {
  factory _$$ActiveWorkoutStateSuccessImplCopyWith(
          _$ActiveWorkoutStateSuccessImpl value,
          $Res Function(_$ActiveWorkoutStateSuccessImpl) then) =
      __$$ActiveWorkoutStateSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading});

  @override
  $WorkoutRoutineCopyWith<$Res> get routine;
}

/// @nodoc
class __$$ActiveWorkoutStateSuccessImplCopyWithImpl<$Res>
    extends _$ActiveWorkoutStateCopyWithImpl<$Res,
        _$ActiveWorkoutStateSuccessImpl>
    implements _$$ActiveWorkoutStateSuccessImplCopyWith<$Res> {
  __$$ActiveWorkoutStateSuccessImplCopyWithImpl(
      _$ActiveWorkoutStateSuccessImpl _value,
      $Res Function(_$ActiveWorkoutStateSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routine = null,
    Object? setLogs = null,
    Object? isLoading = null,
  }) {
    return _then(_$ActiveWorkoutStateSuccessImpl(
      routine: null == routine
          ? _value.routine
          : routine // ignore: cast_nullable_to_non_nullable
              as WorkoutRoutine,
      setLogs: null == setLogs
          ? _value._setLogs
          : setLogs // ignore: cast_nullable_to_non_nullable
              as List<SetLog>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ActiveWorkoutStateSuccessImpl implements ActiveWorkoutStateSuccess {
  const _$ActiveWorkoutStateSuccessImpl(
      {required this.routine,
      required final List<SetLog> setLogs,
      this.isLoading = false})
      : _setLogs = setLogs;

  @override
  final WorkoutRoutine routine;
  final List<SetLog> _setLogs;
  @override
  List<SetLog> get setLogs {
    if (_setLogs is EqualUnmodifiableListView) return _setLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_setLogs);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'ActiveWorkoutState.success(routine: $routine, setLogs: $setLogs, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveWorkoutStateSuccessImpl &&
            (identical(other.routine, routine) || other.routine == routine) &&
            const DeepCollectionEquality().equals(other._setLogs, _setLogs) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, routine,
      const DeepCollectionEquality().hash(_setLogs), isLoading);

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveWorkoutStateSuccessImplCopyWith<_$ActiveWorkoutStateSuccessImpl>
      get copyWith => __$$ActiveWorkoutStateSuccessImplCopyWithImpl<
          _$ActiveWorkoutStateSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)
        initial,
    required TResult Function(WorkoutRoutine routine, bool isLoading) loading,
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)
        tracking,
    required TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)
        saving,
    required TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)
        success,
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)
        error,
  }) {
    return success(routine, setLogs, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        initial,
    TResult? Function(WorkoutRoutine routine, bool isLoading)? loading,
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        tracking,
    TResult? Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        saving,
    TResult? Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        success,
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)?
        error,
  }) {
    return success?.call(routine, setLogs, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        initial,
    TResult Function(WorkoutRoutine routine, bool isLoading)? loading,
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        tracking,
    TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        saving,
    TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        success,
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)?
        error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(routine, setLogs, isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveWorkoutStateInitial value) initial,
    required TResult Function(ActiveWorkoutStateLoading value) loading,
    required TResult Function(ActiveWorkoutStateTracking value) tracking,
    required TResult Function(ActiveWorkoutStateSaving value) saving,
    required TResult Function(ActiveWorkoutStateSuccess value) success,
    required TResult Function(ActiveWorkoutStateError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveWorkoutStateInitial value)? initial,
    TResult? Function(ActiveWorkoutStateLoading value)? loading,
    TResult? Function(ActiveWorkoutStateTracking value)? tracking,
    TResult? Function(ActiveWorkoutStateSaving value)? saving,
    TResult? Function(ActiveWorkoutStateSuccess value)? success,
    TResult? Function(ActiveWorkoutStateError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveWorkoutStateInitial value)? initial,
    TResult Function(ActiveWorkoutStateLoading value)? loading,
    TResult Function(ActiveWorkoutStateTracking value)? tracking,
    TResult Function(ActiveWorkoutStateSaving value)? saving,
    TResult Function(ActiveWorkoutStateSuccess value)? success,
    TResult Function(ActiveWorkoutStateError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ActiveWorkoutStateSuccess implements ActiveWorkoutState {
  const factory ActiveWorkoutStateSuccess(
      {required final WorkoutRoutine routine,
      required final List<SetLog> setLogs,
      final bool isLoading}) = _$ActiveWorkoutStateSuccessImpl;

  @override
  WorkoutRoutine get routine;
  List<SetLog> get setLogs;
  @override
  bool get isLoading;

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveWorkoutStateSuccessImplCopyWith<_$ActiveWorkoutStateSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActiveWorkoutStateErrorImplCopyWith<$Res>
    implements $ActiveWorkoutStateCopyWith<$Res> {
  factory _$$ActiveWorkoutStateErrorImplCopyWith(
          _$ActiveWorkoutStateErrorImpl value,
          $Res Function(_$ActiveWorkoutStateErrorImpl) then) =
      __$$ActiveWorkoutStateErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {WorkoutRoutine routine,
      List<SetLog> setLogs,
      String message,
      bool isLoading});

  @override
  $WorkoutRoutineCopyWith<$Res> get routine;
}

/// @nodoc
class __$$ActiveWorkoutStateErrorImplCopyWithImpl<$Res>
    extends _$ActiveWorkoutStateCopyWithImpl<$Res,
        _$ActiveWorkoutStateErrorImpl>
    implements _$$ActiveWorkoutStateErrorImplCopyWith<$Res> {
  __$$ActiveWorkoutStateErrorImplCopyWithImpl(
      _$ActiveWorkoutStateErrorImpl _value,
      $Res Function(_$ActiveWorkoutStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routine = null,
    Object? setLogs = null,
    Object? message = null,
    Object? isLoading = null,
  }) {
    return _then(_$ActiveWorkoutStateErrorImpl(
      routine: null == routine
          ? _value.routine
          : routine // ignore: cast_nullable_to_non_nullable
              as WorkoutRoutine,
      setLogs: null == setLogs
          ? _value._setLogs
          : setLogs // ignore: cast_nullable_to_non_nullable
              as List<SetLog>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ActiveWorkoutStateErrorImpl implements ActiveWorkoutStateError {
  const _$ActiveWorkoutStateErrorImpl(
      {required this.routine,
      required final List<SetLog> setLogs,
      required this.message,
      this.isLoading = false})
      : _setLogs = setLogs;

  @override
  final WorkoutRoutine routine;
  final List<SetLog> _setLogs;
  @override
  List<SetLog> get setLogs {
    if (_setLogs is EqualUnmodifiableListView) return _setLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_setLogs);
  }

  @override
  final String message;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'ActiveWorkoutState.error(routine: $routine, setLogs: $setLogs, message: $message, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveWorkoutStateErrorImpl &&
            (identical(other.routine, routine) || other.routine == routine) &&
            const DeepCollectionEquality().equals(other._setLogs, _setLogs) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, routine,
      const DeepCollectionEquality().hash(_setLogs), message, isLoading);

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveWorkoutStateErrorImplCopyWith<_$ActiveWorkoutStateErrorImpl>
      get copyWith => __$$ActiveWorkoutStateErrorImplCopyWithImpl<
          _$ActiveWorkoutStateErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)
        initial,
    required TResult Function(WorkoutRoutine routine, bool isLoading) loading,
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)
        tracking,
    required TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)
        saving,
    required TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)
        success,
    required TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)
        error,
  }) {
    return error(routine, setLogs, message, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        initial,
    TResult? Function(WorkoutRoutine routine, bool isLoading)? loading,
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        tracking,
    TResult? Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        saving,
    TResult? Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        success,
    TResult? Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)?
        error,
  }) {
    return error?.call(routine, setLogs, message, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        initial,
    TResult Function(WorkoutRoutine routine, bool isLoading)? loading,
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            bool isSaving, bool isLoading)?
        tracking,
    TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        saving,
    TResult Function(
            WorkoutRoutine routine, List<SetLog> setLogs, bool isLoading)?
        success,
    TResult Function(WorkoutRoutine routine, List<SetLog> setLogs,
            String message, bool isLoading)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(routine, setLogs, message, isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveWorkoutStateInitial value) initial,
    required TResult Function(ActiveWorkoutStateLoading value) loading,
    required TResult Function(ActiveWorkoutStateTracking value) tracking,
    required TResult Function(ActiveWorkoutStateSaving value) saving,
    required TResult Function(ActiveWorkoutStateSuccess value) success,
    required TResult Function(ActiveWorkoutStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveWorkoutStateInitial value)? initial,
    TResult? Function(ActiveWorkoutStateLoading value)? loading,
    TResult? Function(ActiveWorkoutStateTracking value)? tracking,
    TResult? Function(ActiveWorkoutStateSaving value)? saving,
    TResult? Function(ActiveWorkoutStateSuccess value)? success,
    TResult? Function(ActiveWorkoutStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveWorkoutStateInitial value)? initial,
    TResult Function(ActiveWorkoutStateLoading value)? loading,
    TResult Function(ActiveWorkoutStateTracking value)? tracking,
    TResult Function(ActiveWorkoutStateSaving value)? saving,
    TResult Function(ActiveWorkoutStateSuccess value)? success,
    TResult Function(ActiveWorkoutStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ActiveWorkoutStateError implements ActiveWorkoutState {
  const factory ActiveWorkoutStateError(
      {required final WorkoutRoutine routine,
      required final List<SetLog> setLogs,
      required final String message,
      final bool isLoading}) = _$ActiveWorkoutStateErrorImpl;

  @override
  WorkoutRoutine get routine;
  List<SetLog> get setLogs;
  String get message;
  @override
  bool get isLoading;

  /// Create a copy of ActiveWorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveWorkoutStateErrorImplCopyWith<_$ActiveWorkoutStateErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
