// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WorkoutState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<WorkoutRoutine> routines) success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<WorkoutRoutine> routines)? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<WorkoutRoutine> routines)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WorkoutStateInitial value) initial,
    required TResult Function(WorkoutStateLoading value) loading,
    required TResult Function(WorkoutStateSuccess value) success,
    required TResult Function(WorkoutStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WorkoutStateInitial value)? initial,
    TResult? Function(WorkoutStateLoading value)? loading,
    TResult? Function(WorkoutStateSuccess value)? success,
    TResult? Function(WorkoutStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WorkoutStateInitial value)? initial,
    TResult Function(WorkoutStateLoading value)? loading,
    TResult Function(WorkoutStateSuccess value)? success,
    TResult Function(WorkoutStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutStateCopyWith<$Res> {
  factory $WorkoutStateCopyWith(
          WorkoutState value, $Res Function(WorkoutState) then) =
      _$WorkoutStateCopyWithImpl<$Res, WorkoutState>;
}

/// @nodoc
class _$WorkoutStateCopyWithImpl<$Res, $Val extends WorkoutState>
    implements $WorkoutStateCopyWith<$Res> {
  _$WorkoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$WorkoutStateInitialImplCopyWith<$Res> {
  factory _$$WorkoutStateInitialImplCopyWith(_$WorkoutStateInitialImpl value,
          $Res Function(_$WorkoutStateInitialImpl) then) =
      __$$WorkoutStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WorkoutStateInitialImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$WorkoutStateInitialImpl>
    implements _$$WorkoutStateInitialImplCopyWith<$Res> {
  __$$WorkoutStateInitialImplCopyWithImpl(_$WorkoutStateInitialImpl _value,
      $Res Function(_$WorkoutStateInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WorkoutStateInitialImpl implements WorkoutStateInitial {
  const _$WorkoutStateInitialImpl();

  @override
  String toString() {
    return 'WorkoutState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<WorkoutRoutine> routines) success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<WorkoutRoutine> routines)? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<WorkoutRoutine> routines)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WorkoutStateInitial value) initial,
    required TResult Function(WorkoutStateLoading value) loading,
    required TResult Function(WorkoutStateSuccess value) success,
    required TResult Function(WorkoutStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WorkoutStateInitial value)? initial,
    TResult? Function(WorkoutStateLoading value)? loading,
    TResult? Function(WorkoutStateSuccess value)? success,
    TResult? Function(WorkoutStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WorkoutStateInitial value)? initial,
    TResult Function(WorkoutStateLoading value)? loading,
    TResult Function(WorkoutStateSuccess value)? success,
    TResult Function(WorkoutStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class WorkoutStateInitial implements WorkoutState {
  const factory WorkoutStateInitial() = _$WorkoutStateInitialImpl;
}

/// @nodoc
abstract class _$$WorkoutStateLoadingImplCopyWith<$Res> {
  factory _$$WorkoutStateLoadingImplCopyWith(_$WorkoutStateLoadingImpl value,
          $Res Function(_$WorkoutStateLoadingImpl) then) =
      __$$WorkoutStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WorkoutStateLoadingImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$WorkoutStateLoadingImpl>
    implements _$$WorkoutStateLoadingImplCopyWith<$Res> {
  __$$WorkoutStateLoadingImplCopyWithImpl(_$WorkoutStateLoadingImpl _value,
      $Res Function(_$WorkoutStateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WorkoutStateLoadingImpl implements WorkoutStateLoading {
  const _$WorkoutStateLoadingImpl();

  @override
  String toString() {
    return 'WorkoutState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<WorkoutRoutine> routines) success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<WorkoutRoutine> routines)? success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<WorkoutRoutine> routines)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WorkoutStateInitial value) initial,
    required TResult Function(WorkoutStateLoading value) loading,
    required TResult Function(WorkoutStateSuccess value) success,
    required TResult Function(WorkoutStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WorkoutStateInitial value)? initial,
    TResult? Function(WorkoutStateLoading value)? loading,
    TResult? Function(WorkoutStateSuccess value)? success,
    TResult? Function(WorkoutStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WorkoutStateInitial value)? initial,
    TResult Function(WorkoutStateLoading value)? loading,
    TResult Function(WorkoutStateSuccess value)? success,
    TResult Function(WorkoutStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class WorkoutStateLoading implements WorkoutState {
  const factory WorkoutStateLoading() = _$WorkoutStateLoadingImpl;
}

/// @nodoc
abstract class _$$WorkoutStateSuccessImplCopyWith<$Res> {
  factory _$$WorkoutStateSuccessImplCopyWith(_$WorkoutStateSuccessImpl value,
          $Res Function(_$WorkoutStateSuccessImpl) then) =
      __$$WorkoutStateSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<WorkoutRoutine> routines});
}

/// @nodoc
class __$$WorkoutStateSuccessImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$WorkoutStateSuccessImpl>
    implements _$$WorkoutStateSuccessImplCopyWith<$Res> {
  __$$WorkoutStateSuccessImplCopyWithImpl(_$WorkoutStateSuccessImpl _value,
      $Res Function(_$WorkoutStateSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routines = null,
  }) {
    return _then(_$WorkoutStateSuccessImpl(
      routines: null == routines
          ? _value._routines
          : routines // ignore: cast_nullable_to_non_nullable
              as List<WorkoutRoutine>,
    ));
  }
}

/// @nodoc

class _$WorkoutStateSuccessImpl implements WorkoutStateSuccess {
  const _$WorkoutStateSuccessImpl(
      {required final List<WorkoutRoutine> routines})
      : _routines = routines;

  final List<WorkoutRoutine> _routines;
  @override
  List<WorkoutRoutine> get routines {
    if (_routines is EqualUnmodifiableListView) return _routines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routines);
  }

  @override
  String toString() {
    return 'WorkoutState.success(routines: $routines)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutStateSuccessImpl &&
            const DeepCollectionEquality().equals(other._routines, _routines));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_routines));

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutStateSuccessImplCopyWith<_$WorkoutStateSuccessImpl> get copyWith =>
      __$$WorkoutStateSuccessImplCopyWithImpl<_$WorkoutStateSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<WorkoutRoutine> routines) success,
    required TResult Function(String message) error,
  }) {
    return success(routines);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<WorkoutRoutine> routines)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(routines);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<WorkoutRoutine> routines)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(routines);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WorkoutStateInitial value) initial,
    required TResult Function(WorkoutStateLoading value) loading,
    required TResult Function(WorkoutStateSuccess value) success,
    required TResult Function(WorkoutStateError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WorkoutStateInitial value)? initial,
    TResult? Function(WorkoutStateLoading value)? loading,
    TResult? Function(WorkoutStateSuccess value)? success,
    TResult? Function(WorkoutStateError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WorkoutStateInitial value)? initial,
    TResult Function(WorkoutStateLoading value)? loading,
    TResult Function(WorkoutStateSuccess value)? success,
    TResult Function(WorkoutStateError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class WorkoutStateSuccess implements WorkoutState {
  const factory WorkoutStateSuccess(
          {required final List<WorkoutRoutine> routines}) =
      _$WorkoutStateSuccessImpl;

  List<WorkoutRoutine> get routines;

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutStateSuccessImplCopyWith<_$WorkoutStateSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WorkoutStateErrorImplCopyWith<$Res> {
  factory _$$WorkoutStateErrorImplCopyWith(_$WorkoutStateErrorImpl value,
          $Res Function(_$WorkoutStateErrorImpl) then) =
      __$$WorkoutStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$WorkoutStateErrorImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$WorkoutStateErrorImpl>
    implements _$$WorkoutStateErrorImplCopyWith<$Res> {
  __$$WorkoutStateErrorImplCopyWithImpl(_$WorkoutStateErrorImpl _value,
      $Res Function(_$WorkoutStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$WorkoutStateErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$WorkoutStateErrorImpl implements WorkoutStateError {
  const _$WorkoutStateErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'WorkoutState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutStateErrorImplCopyWith<_$WorkoutStateErrorImpl> get copyWith =>
      __$$WorkoutStateErrorImplCopyWithImpl<_$WorkoutStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<WorkoutRoutine> routines) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<WorkoutRoutine> routines)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<WorkoutRoutine> routines)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WorkoutStateInitial value) initial,
    required TResult Function(WorkoutStateLoading value) loading,
    required TResult Function(WorkoutStateSuccess value) success,
    required TResult Function(WorkoutStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WorkoutStateInitial value)? initial,
    TResult? Function(WorkoutStateLoading value)? loading,
    TResult? Function(WorkoutStateSuccess value)? success,
    TResult? Function(WorkoutStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WorkoutStateInitial value)? initial,
    TResult Function(WorkoutStateLoading value)? loading,
    TResult Function(WorkoutStateSuccess value)? success,
    TResult Function(WorkoutStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class WorkoutStateError implements WorkoutState {
  const factory WorkoutStateError({required final String message}) =
      _$WorkoutStateErrorImpl;

  String get message;

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutStateErrorImplCopyWith<_$WorkoutStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
