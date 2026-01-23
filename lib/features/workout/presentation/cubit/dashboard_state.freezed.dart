// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DashboardState {
  DateTime get selectedDate => throw _privateConstructorUsedError;
  List<WorkoutSession> get sessions => throw _privateConstructorUsedError;
  List<WorkoutSession> get activeSessions => throw _privateConstructorUsedError;
  List<WorkoutSession> get completedSessions =>
      throw _privateConstructorUsedError;
  List<WorkoutRoutine> get routines => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        initial,
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        loading,
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        success,
    required TResult Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        initial,
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        loading,
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        success,
    TResult? Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        initial,
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        loading,
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        success,
    TResult Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DashboardStateInitial value) initial,
    required TResult Function(DashboardStateLoading value) loading,
    required TResult Function(DashboardStateSuccess value) success,
    required TResult Function(DashboardStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DashboardStateInitial value)? initial,
    TResult? Function(DashboardStateLoading value)? loading,
    TResult? Function(DashboardStateSuccess value)? success,
    TResult? Function(DashboardStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DashboardStateInitial value)? initial,
    TResult Function(DashboardStateLoading value)? loading,
    TResult Function(DashboardStateSuccess value)? success,
    TResult Function(DashboardStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardStateCopyWith<DashboardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardStateCopyWith<$Res> {
  factory $DashboardStateCopyWith(
          DashboardState value, $Res Function(DashboardState) then) =
      _$DashboardStateCopyWithImpl<$Res, DashboardState>;
  @useResult
  $Res call(
      {DateTime selectedDate,
      List<WorkoutSession> sessions,
      List<WorkoutSession> activeSessions,
      List<WorkoutSession> completedSessions,
      List<WorkoutRoutine> routines});
}

/// @nodoc
class _$DashboardStateCopyWithImpl<$Res, $Val extends DashboardState>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? sessions = null,
    Object? activeSessions = null,
    Object? completedSessions = null,
    Object? routines = null,
  }) {
    return _then(_value.copyWith(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sessions: null == sessions
          ? _value.sessions
          : sessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      activeSessions: null == activeSessions
          ? _value.activeSessions
          : activeSessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      completedSessions: null == completedSessions
          ? _value.completedSessions
          : completedSessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      routines: null == routines
          ? _value.routines
          : routines // ignore: cast_nullable_to_non_nullable
              as List<WorkoutRoutine>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardStateInitialImplCopyWith<$Res>
    implements $DashboardStateCopyWith<$Res> {
  factory _$$DashboardStateInitialImplCopyWith(
          _$DashboardStateInitialImpl value,
          $Res Function(_$DashboardStateInitialImpl) then) =
      __$$DashboardStateInitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime selectedDate,
      List<WorkoutSession> sessions,
      List<WorkoutSession> activeSessions,
      List<WorkoutSession> completedSessions,
      List<WorkoutRoutine> routines});
}

/// @nodoc
class __$$DashboardStateInitialImplCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$DashboardStateInitialImpl>
    implements _$$DashboardStateInitialImplCopyWith<$Res> {
  __$$DashboardStateInitialImplCopyWithImpl(_$DashboardStateInitialImpl _value,
      $Res Function(_$DashboardStateInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? sessions = null,
    Object? activeSessions = null,
    Object? completedSessions = null,
    Object? routines = null,
  }) {
    return _then(_$DashboardStateInitialImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sessions: null == sessions
          ? _value._sessions
          : sessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      activeSessions: null == activeSessions
          ? _value._activeSessions
          : activeSessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      completedSessions: null == completedSessions
          ? _value._completedSessions
          : completedSessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      routines: null == routines
          ? _value._routines
          : routines // ignore: cast_nullable_to_non_nullable
              as List<WorkoutRoutine>,
    ));
  }
}

/// @nodoc

class _$DashboardStateInitialImpl implements DashboardStateInitial {
  const _$DashboardStateInitialImpl(
      {required this.selectedDate,
      final List<WorkoutSession> sessions = const [],
      final List<WorkoutSession> activeSessions = const [],
      final List<WorkoutSession> completedSessions = const [],
      final List<WorkoutRoutine> routines = const []})
      : _sessions = sessions,
        _activeSessions = activeSessions,
        _completedSessions = completedSessions,
        _routines = routines;

  @override
  final DateTime selectedDate;
  final List<WorkoutSession> _sessions;
  @override
  @JsonKey()
  List<WorkoutSession> get sessions {
    if (_sessions is EqualUnmodifiableListView) return _sessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessions);
  }

  final List<WorkoutSession> _activeSessions;
  @override
  @JsonKey()
  List<WorkoutSession> get activeSessions {
    if (_activeSessions is EqualUnmodifiableListView) return _activeSessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeSessions);
  }

  final List<WorkoutSession> _completedSessions;
  @override
  @JsonKey()
  List<WorkoutSession> get completedSessions {
    if (_completedSessions is EqualUnmodifiableListView)
      return _completedSessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedSessions);
  }

  final List<WorkoutRoutine> _routines;
  @override
  @JsonKey()
  List<WorkoutRoutine> get routines {
    if (_routines is EqualUnmodifiableListView) return _routines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routines);
  }

  @override
  String toString() {
    return 'DashboardState.initial(selectedDate: $selectedDate, sessions: $sessions, activeSessions: $activeSessions, completedSessions: $completedSessions, routines: $routines)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStateInitialImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            const DeepCollectionEquality().equals(other._sessions, _sessions) &&
            const DeepCollectionEquality()
                .equals(other._activeSessions, _activeSessions) &&
            const DeepCollectionEquality()
                .equals(other._completedSessions, _completedSessions) &&
            const DeepCollectionEquality().equals(other._routines, _routines));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedDate,
      const DeepCollectionEquality().hash(_sessions),
      const DeepCollectionEquality().hash(_activeSessions),
      const DeepCollectionEquality().hash(_completedSessions),
      const DeepCollectionEquality().hash(_routines));

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStateInitialImplCopyWith<_$DashboardStateInitialImpl>
      get copyWith => __$$DashboardStateInitialImplCopyWithImpl<
          _$DashboardStateInitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        initial,
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        loading,
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        success,
    required TResult Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        error,
  }) {
    return initial(
        selectedDate, sessions, activeSessions, completedSessions, routines);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        initial,
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        loading,
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        success,
    TResult? Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        error,
  }) {
    return initial?.call(
        selectedDate, sessions, activeSessions, completedSessions, routines);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        initial,
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        loading,
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        success,
    TResult Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(
          selectedDate, sessions, activeSessions, completedSessions, routines);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DashboardStateInitial value) initial,
    required TResult Function(DashboardStateLoading value) loading,
    required TResult Function(DashboardStateSuccess value) success,
    required TResult Function(DashboardStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DashboardStateInitial value)? initial,
    TResult? Function(DashboardStateLoading value)? loading,
    TResult? Function(DashboardStateSuccess value)? success,
    TResult? Function(DashboardStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DashboardStateInitial value)? initial,
    TResult Function(DashboardStateLoading value)? loading,
    TResult Function(DashboardStateSuccess value)? success,
    TResult Function(DashboardStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class DashboardStateInitial implements DashboardState {
  const factory DashboardStateInitial(
      {required final DateTime selectedDate,
      final List<WorkoutSession> sessions,
      final List<WorkoutSession> activeSessions,
      final List<WorkoutSession> completedSessions,
      final List<WorkoutRoutine> routines}) = _$DashboardStateInitialImpl;

  @override
  DateTime get selectedDate;
  @override
  List<WorkoutSession> get sessions;
  @override
  List<WorkoutSession> get activeSessions;
  @override
  List<WorkoutSession> get completedSessions;
  @override
  List<WorkoutRoutine> get routines;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardStateInitialImplCopyWith<_$DashboardStateInitialImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DashboardStateLoadingImplCopyWith<$Res>
    implements $DashboardStateCopyWith<$Res> {
  factory _$$DashboardStateLoadingImplCopyWith(
          _$DashboardStateLoadingImpl value,
          $Res Function(_$DashboardStateLoadingImpl) then) =
      __$$DashboardStateLoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime selectedDate,
      List<WorkoutSession> sessions,
      List<WorkoutSession> activeSessions,
      List<WorkoutSession> completedSessions,
      List<WorkoutRoutine> routines});
}

/// @nodoc
class __$$DashboardStateLoadingImplCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$DashboardStateLoadingImpl>
    implements _$$DashboardStateLoadingImplCopyWith<$Res> {
  __$$DashboardStateLoadingImplCopyWithImpl(_$DashboardStateLoadingImpl _value,
      $Res Function(_$DashboardStateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? sessions = null,
    Object? activeSessions = null,
    Object? completedSessions = null,
    Object? routines = null,
  }) {
    return _then(_$DashboardStateLoadingImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sessions: null == sessions
          ? _value._sessions
          : sessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      activeSessions: null == activeSessions
          ? _value._activeSessions
          : activeSessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      completedSessions: null == completedSessions
          ? _value._completedSessions
          : completedSessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      routines: null == routines
          ? _value._routines
          : routines // ignore: cast_nullable_to_non_nullable
              as List<WorkoutRoutine>,
    ));
  }
}

/// @nodoc

class _$DashboardStateLoadingImpl implements DashboardStateLoading {
  const _$DashboardStateLoadingImpl(
      {required this.selectedDate,
      final List<WorkoutSession> sessions = const [],
      final List<WorkoutSession> activeSessions = const [],
      final List<WorkoutSession> completedSessions = const [],
      final List<WorkoutRoutine> routines = const []})
      : _sessions = sessions,
        _activeSessions = activeSessions,
        _completedSessions = completedSessions,
        _routines = routines;

  @override
  final DateTime selectedDate;
  final List<WorkoutSession> _sessions;
  @override
  @JsonKey()
  List<WorkoutSession> get sessions {
    if (_sessions is EqualUnmodifiableListView) return _sessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessions);
  }

  final List<WorkoutSession> _activeSessions;
  @override
  @JsonKey()
  List<WorkoutSession> get activeSessions {
    if (_activeSessions is EqualUnmodifiableListView) return _activeSessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeSessions);
  }

  final List<WorkoutSession> _completedSessions;
  @override
  @JsonKey()
  List<WorkoutSession> get completedSessions {
    if (_completedSessions is EqualUnmodifiableListView)
      return _completedSessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedSessions);
  }

  final List<WorkoutRoutine> _routines;
  @override
  @JsonKey()
  List<WorkoutRoutine> get routines {
    if (_routines is EqualUnmodifiableListView) return _routines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routines);
  }

  @override
  String toString() {
    return 'DashboardState.loading(selectedDate: $selectedDate, sessions: $sessions, activeSessions: $activeSessions, completedSessions: $completedSessions, routines: $routines)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStateLoadingImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            const DeepCollectionEquality().equals(other._sessions, _sessions) &&
            const DeepCollectionEquality()
                .equals(other._activeSessions, _activeSessions) &&
            const DeepCollectionEquality()
                .equals(other._completedSessions, _completedSessions) &&
            const DeepCollectionEquality().equals(other._routines, _routines));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedDate,
      const DeepCollectionEquality().hash(_sessions),
      const DeepCollectionEquality().hash(_activeSessions),
      const DeepCollectionEquality().hash(_completedSessions),
      const DeepCollectionEquality().hash(_routines));

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStateLoadingImplCopyWith<_$DashboardStateLoadingImpl>
      get copyWith => __$$DashboardStateLoadingImplCopyWithImpl<
          _$DashboardStateLoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        initial,
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        loading,
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        success,
    required TResult Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        error,
  }) {
    return loading(
        selectedDate, sessions, activeSessions, completedSessions, routines);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        initial,
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        loading,
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        success,
    TResult? Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        error,
  }) {
    return loading?.call(
        selectedDate, sessions, activeSessions, completedSessions, routines);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        initial,
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        loading,
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        success,
    TResult Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(
          selectedDate, sessions, activeSessions, completedSessions, routines);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DashboardStateInitial value) initial,
    required TResult Function(DashboardStateLoading value) loading,
    required TResult Function(DashboardStateSuccess value) success,
    required TResult Function(DashboardStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DashboardStateInitial value)? initial,
    TResult? Function(DashboardStateLoading value)? loading,
    TResult? Function(DashboardStateSuccess value)? success,
    TResult? Function(DashboardStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DashboardStateInitial value)? initial,
    TResult Function(DashboardStateLoading value)? loading,
    TResult Function(DashboardStateSuccess value)? success,
    TResult Function(DashboardStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class DashboardStateLoading implements DashboardState {
  const factory DashboardStateLoading(
      {required final DateTime selectedDate,
      final List<WorkoutSession> sessions,
      final List<WorkoutSession> activeSessions,
      final List<WorkoutSession> completedSessions,
      final List<WorkoutRoutine> routines}) = _$DashboardStateLoadingImpl;

  @override
  DateTime get selectedDate;
  @override
  List<WorkoutSession> get sessions;
  @override
  List<WorkoutSession> get activeSessions;
  @override
  List<WorkoutSession> get completedSessions;
  @override
  List<WorkoutRoutine> get routines;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardStateLoadingImplCopyWith<_$DashboardStateLoadingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DashboardStateSuccessImplCopyWith<$Res>
    implements $DashboardStateCopyWith<$Res> {
  factory _$$DashboardStateSuccessImplCopyWith(
          _$DashboardStateSuccessImpl value,
          $Res Function(_$DashboardStateSuccessImpl) then) =
      __$$DashboardStateSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime selectedDate,
      List<WorkoutSession> sessions,
      List<WorkoutSession> activeSessions,
      List<WorkoutSession> completedSessions,
      List<WorkoutRoutine> routines});
}

/// @nodoc
class __$$DashboardStateSuccessImplCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$DashboardStateSuccessImpl>
    implements _$$DashboardStateSuccessImplCopyWith<$Res> {
  __$$DashboardStateSuccessImplCopyWithImpl(_$DashboardStateSuccessImpl _value,
      $Res Function(_$DashboardStateSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? sessions = null,
    Object? activeSessions = null,
    Object? completedSessions = null,
    Object? routines = null,
  }) {
    return _then(_$DashboardStateSuccessImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sessions: null == sessions
          ? _value._sessions
          : sessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      activeSessions: null == activeSessions
          ? _value._activeSessions
          : activeSessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      completedSessions: null == completedSessions
          ? _value._completedSessions
          : completedSessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      routines: null == routines
          ? _value._routines
          : routines // ignore: cast_nullable_to_non_nullable
              as List<WorkoutRoutine>,
    ));
  }
}

/// @nodoc

class _$DashboardStateSuccessImpl implements DashboardStateSuccess {
  const _$DashboardStateSuccessImpl(
      {required this.selectedDate,
      required final List<WorkoutSession> sessions,
      final List<WorkoutSession> activeSessions = const [],
      final List<WorkoutSession> completedSessions = const [],
      final List<WorkoutRoutine> routines = const []})
      : _sessions = sessions,
        _activeSessions = activeSessions,
        _completedSessions = completedSessions,
        _routines = routines;

  @override
  final DateTime selectedDate;
  final List<WorkoutSession> _sessions;
  @override
  List<WorkoutSession> get sessions {
    if (_sessions is EqualUnmodifiableListView) return _sessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessions);
  }

  final List<WorkoutSession> _activeSessions;
  @override
  @JsonKey()
  List<WorkoutSession> get activeSessions {
    if (_activeSessions is EqualUnmodifiableListView) return _activeSessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeSessions);
  }

  final List<WorkoutSession> _completedSessions;
  @override
  @JsonKey()
  List<WorkoutSession> get completedSessions {
    if (_completedSessions is EqualUnmodifiableListView)
      return _completedSessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedSessions);
  }

  final List<WorkoutRoutine> _routines;
  @override
  @JsonKey()
  List<WorkoutRoutine> get routines {
    if (_routines is EqualUnmodifiableListView) return _routines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routines);
  }

  @override
  String toString() {
    return 'DashboardState.success(selectedDate: $selectedDate, sessions: $sessions, activeSessions: $activeSessions, completedSessions: $completedSessions, routines: $routines)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStateSuccessImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            const DeepCollectionEquality().equals(other._sessions, _sessions) &&
            const DeepCollectionEquality()
                .equals(other._activeSessions, _activeSessions) &&
            const DeepCollectionEquality()
                .equals(other._completedSessions, _completedSessions) &&
            const DeepCollectionEquality().equals(other._routines, _routines));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedDate,
      const DeepCollectionEquality().hash(_sessions),
      const DeepCollectionEquality().hash(_activeSessions),
      const DeepCollectionEquality().hash(_completedSessions),
      const DeepCollectionEquality().hash(_routines));

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStateSuccessImplCopyWith<_$DashboardStateSuccessImpl>
      get copyWith => __$$DashboardStateSuccessImplCopyWithImpl<
          _$DashboardStateSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        initial,
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        loading,
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        success,
    required TResult Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        error,
  }) {
    return success(
        selectedDate, sessions, activeSessions, completedSessions, routines);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        initial,
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        loading,
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        success,
    TResult? Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        error,
  }) {
    return success?.call(
        selectedDate, sessions, activeSessions, completedSessions, routines);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        initial,
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        loading,
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        success,
    TResult Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(
          selectedDate, sessions, activeSessions, completedSessions, routines);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DashboardStateInitial value) initial,
    required TResult Function(DashboardStateLoading value) loading,
    required TResult Function(DashboardStateSuccess value) success,
    required TResult Function(DashboardStateError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DashboardStateInitial value)? initial,
    TResult? Function(DashboardStateLoading value)? loading,
    TResult? Function(DashboardStateSuccess value)? success,
    TResult? Function(DashboardStateError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DashboardStateInitial value)? initial,
    TResult Function(DashboardStateLoading value)? loading,
    TResult Function(DashboardStateSuccess value)? success,
    TResult Function(DashboardStateError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class DashboardStateSuccess implements DashboardState {
  const factory DashboardStateSuccess(
      {required final DateTime selectedDate,
      required final List<WorkoutSession> sessions,
      final List<WorkoutSession> activeSessions,
      final List<WorkoutSession> completedSessions,
      final List<WorkoutRoutine> routines}) = _$DashboardStateSuccessImpl;

  @override
  DateTime get selectedDate;
  @override
  List<WorkoutSession> get sessions;
  @override
  List<WorkoutSession> get activeSessions;
  @override
  List<WorkoutSession> get completedSessions;
  @override
  List<WorkoutRoutine> get routines;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardStateSuccessImplCopyWith<_$DashboardStateSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DashboardStateErrorImplCopyWith<$Res>
    implements $DashboardStateCopyWith<$Res> {
  factory _$$DashboardStateErrorImplCopyWith(_$DashboardStateErrorImpl value,
          $Res Function(_$DashboardStateErrorImpl) then) =
      __$$DashboardStateErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime selectedDate,
      String message,
      List<WorkoutSession> sessions,
      List<WorkoutSession> activeSessions,
      List<WorkoutSession> completedSessions,
      List<WorkoutRoutine> routines});
}

/// @nodoc
class __$$DashboardStateErrorImplCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$DashboardStateErrorImpl>
    implements _$$DashboardStateErrorImplCopyWith<$Res> {
  __$$DashboardStateErrorImplCopyWithImpl(_$DashboardStateErrorImpl _value,
      $Res Function(_$DashboardStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? message = null,
    Object? sessions = null,
    Object? activeSessions = null,
    Object? completedSessions = null,
    Object? routines = null,
  }) {
    return _then(_$DashboardStateErrorImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      sessions: null == sessions
          ? _value._sessions
          : sessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      activeSessions: null == activeSessions
          ? _value._activeSessions
          : activeSessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      completedSessions: null == completedSessions
          ? _value._completedSessions
          : completedSessions // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSession>,
      routines: null == routines
          ? _value._routines
          : routines // ignore: cast_nullable_to_non_nullable
              as List<WorkoutRoutine>,
    ));
  }
}

/// @nodoc

class _$DashboardStateErrorImpl implements DashboardStateError {
  const _$DashboardStateErrorImpl(
      {required this.selectedDate,
      required this.message,
      final List<WorkoutSession> sessions = const [],
      final List<WorkoutSession> activeSessions = const [],
      final List<WorkoutSession> completedSessions = const [],
      final List<WorkoutRoutine> routines = const []})
      : _sessions = sessions,
        _activeSessions = activeSessions,
        _completedSessions = completedSessions,
        _routines = routines;

  @override
  final DateTime selectedDate;
  @override
  final String message;
  final List<WorkoutSession> _sessions;
  @override
  @JsonKey()
  List<WorkoutSession> get sessions {
    if (_sessions is EqualUnmodifiableListView) return _sessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessions);
  }

  final List<WorkoutSession> _activeSessions;
  @override
  @JsonKey()
  List<WorkoutSession> get activeSessions {
    if (_activeSessions is EqualUnmodifiableListView) return _activeSessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeSessions);
  }

  final List<WorkoutSession> _completedSessions;
  @override
  @JsonKey()
  List<WorkoutSession> get completedSessions {
    if (_completedSessions is EqualUnmodifiableListView)
      return _completedSessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedSessions);
  }

  final List<WorkoutRoutine> _routines;
  @override
  @JsonKey()
  List<WorkoutRoutine> get routines {
    if (_routines is EqualUnmodifiableListView) return _routines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routines);
  }

  @override
  String toString() {
    return 'DashboardState.error(selectedDate: $selectedDate, message: $message, sessions: $sessions, activeSessions: $activeSessions, completedSessions: $completedSessions, routines: $routines)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStateErrorImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._sessions, _sessions) &&
            const DeepCollectionEquality()
                .equals(other._activeSessions, _activeSessions) &&
            const DeepCollectionEquality()
                .equals(other._completedSessions, _completedSessions) &&
            const DeepCollectionEquality().equals(other._routines, _routines));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedDate,
      message,
      const DeepCollectionEquality().hash(_sessions),
      const DeepCollectionEquality().hash(_activeSessions),
      const DeepCollectionEquality().hash(_completedSessions),
      const DeepCollectionEquality().hash(_routines));

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStateErrorImplCopyWith<_$DashboardStateErrorImpl> get copyWith =>
      __$$DashboardStateErrorImplCopyWithImpl<_$DashboardStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        initial,
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        loading,
    required TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        success,
    required TResult Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)
        error,
  }) {
    return error(selectedDate, message, sessions, activeSessions,
        completedSessions, routines);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        initial,
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        loading,
    TResult? Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        success,
    TResult? Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        error,
  }) {
    return error?.call(selectedDate, message, sessions, activeSessions,
        completedSessions, routines);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        initial,
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        loading,
    TResult Function(
            DateTime selectedDate,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        success,
    TResult Function(
            DateTime selectedDate,
            String message,
            List<WorkoutSession> sessions,
            List<WorkoutSession> activeSessions,
            List<WorkoutSession> completedSessions,
            List<WorkoutRoutine> routines)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(selectedDate, message, sessions, activeSessions,
          completedSessions, routines);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DashboardStateInitial value) initial,
    required TResult Function(DashboardStateLoading value) loading,
    required TResult Function(DashboardStateSuccess value) success,
    required TResult Function(DashboardStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DashboardStateInitial value)? initial,
    TResult? Function(DashboardStateLoading value)? loading,
    TResult? Function(DashboardStateSuccess value)? success,
    TResult? Function(DashboardStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DashboardStateInitial value)? initial,
    TResult Function(DashboardStateLoading value)? loading,
    TResult Function(DashboardStateSuccess value)? success,
    TResult Function(DashboardStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class DashboardStateError implements DashboardState {
  const factory DashboardStateError(
      {required final DateTime selectedDate,
      required final String message,
      final List<WorkoutSession> sessions,
      final List<WorkoutSession> activeSessions,
      final List<WorkoutSession> completedSessions,
      final List<WorkoutRoutine> routines}) = _$DashboardStateErrorImpl;

  @override
  DateTime get selectedDate;
  String get message;
  @override
  List<WorkoutSession> get sessions;
  @override
  List<WorkoutSession> get activeSessions;
  @override
  List<WorkoutSession> get completedSessions;
  @override
  List<WorkoutRoutine> get routines;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardStateErrorImplCopyWith<_$DashboardStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
