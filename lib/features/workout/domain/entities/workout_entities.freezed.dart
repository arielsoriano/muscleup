// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WorkoutRoutine {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  List<WorkoutExercise> get exercises => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutRoutine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutRoutineCopyWith<WorkoutRoutine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutRoutineCopyWith<$Res> {
  factory $WorkoutRoutineCopyWith(
          WorkoutRoutine value, $Res Function(WorkoutRoutine) then) =
      _$WorkoutRoutineCopyWithImpl<$Res, WorkoutRoutine>;
  @useResult
  $Res call(
      {String id, String name, int sortOrder, List<WorkoutExercise> exercises});
}

/// @nodoc
class _$WorkoutRoutineCopyWithImpl<$Res, $Val extends WorkoutRoutine>
    implements $WorkoutRoutineCopyWith<$Res> {
  _$WorkoutRoutineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutRoutine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sortOrder = null,
    Object? exercises = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      exercises: null == exercises
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<WorkoutExercise>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkoutRoutineImplCopyWith<$Res>
    implements $WorkoutRoutineCopyWith<$Res> {
  factory _$$WorkoutRoutineImplCopyWith(_$WorkoutRoutineImpl value,
          $Res Function(_$WorkoutRoutineImpl) then) =
      __$$WorkoutRoutineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, int sortOrder, List<WorkoutExercise> exercises});
}

/// @nodoc
class __$$WorkoutRoutineImplCopyWithImpl<$Res>
    extends _$WorkoutRoutineCopyWithImpl<$Res, _$WorkoutRoutineImpl>
    implements _$$WorkoutRoutineImplCopyWith<$Res> {
  __$$WorkoutRoutineImplCopyWithImpl(
      _$WorkoutRoutineImpl _value, $Res Function(_$WorkoutRoutineImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutRoutine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sortOrder = null,
    Object? exercises = null,
  }) {
    return _then(_$WorkoutRoutineImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      exercises: null == exercises
          ? _value._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<WorkoutExercise>,
    ));
  }
}

/// @nodoc

class _$WorkoutRoutineImpl implements _WorkoutRoutine {
  const _$WorkoutRoutineImpl(
      {required this.id,
      required this.name,
      required this.sortOrder,
      required final List<WorkoutExercise> exercises})
      : _exercises = exercises;

  @override
  final String id;
  @override
  final String name;
  @override
  final int sortOrder;
  final List<WorkoutExercise> _exercises;
  @override
  List<WorkoutExercise> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  String toString() {
    return 'WorkoutRoutine(id: $id, name: $name, sortOrder: $sortOrder, exercises: $exercises)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutRoutineImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            const DeepCollectionEquality()
                .equals(other._exercises, _exercises));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, sortOrder,
      const DeepCollectionEquality().hash(_exercises));

  /// Create a copy of WorkoutRoutine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutRoutineImplCopyWith<_$WorkoutRoutineImpl> get copyWith =>
      __$$WorkoutRoutineImplCopyWithImpl<_$WorkoutRoutineImpl>(
          this, _$identity);
}

abstract class _WorkoutRoutine implements WorkoutRoutine {
  const factory _WorkoutRoutine(
      {required final String id,
      required final String name,
      required final int sortOrder,
      required final List<WorkoutExercise> exercises}) = _$WorkoutRoutineImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  int get sortOrder;
  @override
  List<WorkoutExercise> get exercises;

  /// Create a copy of WorkoutRoutine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutRoutineImplCopyWith<_$WorkoutRoutineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WorkoutExercise {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  int get restTimeSeconds => throw _privateConstructorUsedError;
  List<WorkoutSet> get templateSets => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutExerciseCopyWith<WorkoutExercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutExerciseCopyWith<$Res> {
  factory $WorkoutExerciseCopyWith(
          WorkoutExercise value, $Res Function(WorkoutExercise) then) =
      _$WorkoutExerciseCopyWithImpl<$Res, WorkoutExercise>;
  @useResult
  $Res call(
      {String id,
      String name,
      int sortOrder,
      String? notes,
      int restTimeSeconds,
      List<WorkoutSet> templateSets});
}

/// @nodoc
class _$WorkoutExerciseCopyWithImpl<$Res, $Val extends WorkoutExercise>
    implements $WorkoutExerciseCopyWith<$Res> {
  _$WorkoutExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sortOrder = null,
    Object? notes = freezed,
    Object? restTimeSeconds = null,
    Object? templateSets = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      restTimeSeconds: null == restTimeSeconds
          ? _value.restTimeSeconds
          : restTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      templateSets: null == templateSets
          ? _value.templateSets
          : templateSets // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSet>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkoutExerciseImplCopyWith<$Res>
    implements $WorkoutExerciseCopyWith<$Res> {
  factory _$$WorkoutExerciseImplCopyWith(_$WorkoutExerciseImpl value,
          $Res Function(_$WorkoutExerciseImpl) then) =
      __$$WorkoutExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int sortOrder,
      String? notes,
      int restTimeSeconds,
      List<WorkoutSet> templateSets});
}

/// @nodoc
class __$$WorkoutExerciseImplCopyWithImpl<$Res>
    extends _$WorkoutExerciseCopyWithImpl<$Res, _$WorkoutExerciseImpl>
    implements _$$WorkoutExerciseImplCopyWith<$Res> {
  __$$WorkoutExerciseImplCopyWithImpl(
      _$WorkoutExerciseImpl _value, $Res Function(_$WorkoutExerciseImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sortOrder = null,
    Object? notes = freezed,
    Object? restTimeSeconds = null,
    Object? templateSets = null,
  }) {
    return _then(_$WorkoutExerciseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      restTimeSeconds: null == restTimeSeconds
          ? _value.restTimeSeconds
          : restTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      templateSets: null == templateSets
          ? _value._templateSets
          : templateSets // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSet>,
    ));
  }
}

/// @nodoc

class _$WorkoutExerciseImpl implements _WorkoutExercise {
  const _$WorkoutExerciseImpl(
      {required this.id,
      required this.name,
      required this.sortOrder,
      this.notes,
      required this.restTimeSeconds,
      required final List<WorkoutSet> templateSets})
      : _templateSets = templateSets;

  @override
  final String id;
  @override
  final String name;
  @override
  final int sortOrder;
  @override
  final String? notes;
  @override
  final int restTimeSeconds;
  final List<WorkoutSet> _templateSets;
  @override
  List<WorkoutSet> get templateSets {
    if (_templateSets is EqualUnmodifiableListView) return _templateSets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_templateSets);
  }

  @override
  String toString() {
    return 'WorkoutExercise(id: $id, name: $name, sortOrder: $sortOrder, notes: $notes, restTimeSeconds: $restTimeSeconds, templateSets: $templateSets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.restTimeSeconds, restTimeSeconds) ||
                other.restTimeSeconds == restTimeSeconds) &&
            const DeepCollectionEquality()
                .equals(other._templateSets, _templateSets));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, sortOrder, notes,
      restTimeSeconds, const DeepCollectionEquality().hash(_templateSets));

  /// Create a copy of WorkoutExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutExerciseImplCopyWith<_$WorkoutExerciseImpl> get copyWith =>
      __$$WorkoutExerciseImplCopyWithImpl<_$WorkoutExerciseImpl>(
          this, _$identity);
}

abstract class _WorkoutExercise implements WorkoutExercise {
  const factory _WorkoutExercise(
      {required final String id,
      required final String name,
      required final int sortOrder,
      final String? notes,
      required final int restTimeSeconds,
      required final List<WorkoutSet> templateSets}) = _$WorkoutExerciseImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  int get sortOrder;
  @override
  String? get notes;
  @override
  int get restTimeSeconds;
  @override
  List<WorkoutSet> get templateSets;

  /// Create a copy of WorkoutExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutExerciseImplCopyWith<_$WorkoutExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WorkoutSet {
  String get id => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  double? get targetValue1 => throw _privateConstructorUsedError;
  double? get targetValue2 => throw _privateConstructorUsedError;
  WorkoutUnit? get unit1 => throw _privateConstructorUsedError;
  WorkoutUnit? get unit2 => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutSetCopyWith<WorkoutSet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSetCopyWith<$Res> {
  factory $WorkoutSetCopyWith(
          WorkoutSet value, $Res Function(WorkoutSet) then) =
      _$WorkoutSetCopyWithImpl<$Res, WorkoutSet>;
  @useResult
  $Res call(
      {String id,
      int sortOrder,
      double? targetValue1,
      double? targetValue2,
      WorkoutUnit? unit1,
      WorkoutUnit? unit2});
}

/// @nodoc
class _$WorkoutSetCopyWithImpl<$Res, $Val extends WorkoutSet>
    implements $WorkoutSetCopyWith<$Res> {
  _$WorkoutSetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sortOrder = null,
    Object? targetValue1 = freezed,
    Object? targetValue2 = freezed,
    Object? unit1 = freezed,
    Object? unit2 = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      targetValue1: freezed == targetValue1
          ? _value.targetValue1
          : targetValue1 // ignore: cast_nullable_to_non_nullable
              as double?,
      targetValue2: freezed == targetValue2
          ? _value.targetValue2
          : targetValue2 // ignore: cast_nullable_to_non_nullable
              as double?,
      unit1: freezed == unit1
          ? _value.unit1
          : unit1 // ignore: cast_nullable_to_non_nullable
              as WorkoutUnit?,
      unit2: freezed == unit2
          ? _value.unit2
          : unit2 // ignore: cast_nullable_to_non_nullable
              as WorkoutUnit?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkoutSetImplCopyWith<$Res>
    implements $WorkoutSetCopyWith<$Res> {
  factory _$$WorkoutSetImplCopyWith(
          _$WorkoutSetImpl value, $Res Function(_$WorkoutSetImpl) then) =
      __$$WorkoutSetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int sortOrder,
      double? targetValue1,
      double? targetValue2,
      WorkoutUnit? unit1,
      WorkoutUnit? unit2});
}

/// @nodoc
class __$$WorkoutSetImplCopyWithImpl<$Res>
    extends _$WorkoutSetCopyWithImpl<$Res, _$WorkoutSetImpl>
    implements _$$WorkoutSetImplCopyWith<$Res> {
  __$$WorkoutSetImplCopyWithImpl(
      _$WorkoutSetImpl _value, $Res Function(_$WorkoutSetImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sortOrder = null,
    Object? targetValue1 = freezed,
    Object? targetValue2 = freezed,
    Object? unit1 = freezed,
    Object? unit2 = freezed,
  }) {
    return _then(_$WorkoutSetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      targetValue1: freezed == targetValue1
          ? _value.targetValue1
          : targetValue1 // ignore: cast_nullable_to_non_nullable
              as double?,
      targetValue2: freezed == targetValue2
          ? _value.targetValue2
          : targetValue2 // ignore: cast_nullable_to_non_nullable
              as double?,
      unit1: freezed == unit1
          ? _value.unit1
          : unit1 // ignore: cast_nullable_to_non_nullable
              as WorkoutUnit?,
      unit2: freezed == unit2
          ? _value.unit2
          : unit2 // ignore: cast_nullable_to_non_nullable
              as WorkoutUnit?,
    ));
  }
}

/// @nodoc

class _$WorkoutSetImpl implements _WorkoutSet {
  const _$WorkoutSetImpl(
      {required this.id,
      required this.sortOrder,
      this.targetValue1,
      this.targetValue2,
      this.unit1,
      this.unit2});

  @override
  final String id;
  @override
  final int sortOrder;
  @override
  final double? targetValue1;
  @override
  final double? targetValue2;
  @override
  final WorkoutUnit? unit1;
  @override
  final WorkoutUnit? unit2;

  @override
  String toString() {
    return 'WorkoutSet(id: $id, sortOrder: $sortOrder, targetValue1: $targetValue1, targetValue2: $targetValue2, unit1: $unit1, unit2: $unit2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.targetValue1, targetValue1) ||
                other.targetValue1 == targetValue1) &&
            (identical(other.targetValue2, targetValue2) ||
                other.targetValue2 == targetValue2) &&
            (identical(other.unit1, unit1) || other.unit1 == unit1) &&
            (identical(other.unit2, unit2) || other.unit2 == unit2));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, sortOrder, targetValue1, targetValue2, unit1, unit2);

  /// Create a copy of WorkoutSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSetImplCopyWith<_$WorkoutSetImpl> get copyWith =>
      __$$WorkoutSetImplCopyWithImpl<_$WorkoutSetImpl>(this, _$identity);
}

abstract class _WorkoutSet implements WorkoutSet {
  const factory _WorkoutSet(
      {required final String id,
      required final int sortOrder,
      final double? targetValue1,
      final double? targetValue2,
      final WorkoutUnit? unit1,
      final WorkoutUnit? unit2}) = _$WorkoutSetImpl;

  @override
  String get id;
  @override
  int get sortOrder;
  @override
  double? get targetValue1;
  @override
  double? get targetValue2;
  @override
  WorkoutUnit? get unit1;
  @override
  WorkoutUnit? get unit2;

  /// Create a copy of WorkoutSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutSetImplCopyWith<_$WorkoutSetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WorkoutSession {
  String get id => throw _privateConstructorUsedError;
  String get routineId => throw _privateConstructorUsedError;
  String get routineName => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutSessionCopyWith<WorkoutSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSessionCopyWith<$Res> {
  factory $WorkoutSessionCopyWith(
          WorkoutSession value, $Res Function(WorkoutSession) then) =
      _$WorkoutSessionCopyWithImpl<$Res, WorkoutSession>;
  @useResult
  $Res call(
      {String id,
      String routineId,
      String routineName,
      DateTime date,
      String? notes});
}

/// @nodoc
class _$WorkoutSessionCopyWithImpl<$Res, $Val extends WorkoutSession>
    implements $WorkoutSessionCopyWith<$Res> {
  _$WorkoutSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? routineId = null,
    Object? routineName = null,
    Object? date = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      routineId: null == routineId
          ? _value.routineId
          : routineId // ignore: cast_nullable_to_non_nullable
              as String,
      routineName: null == routineName
          ? _value.routineName
          : routineName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkoutSessionImplCopyWith<$Res>
    implements $WorkoutSessionCopyWith<$Res> {
  factory _$$WorkoutSessionImplCopyWith(_$WorkoutSessionImpl value,
          $Res Function(_$WorkoutSessionImpl) then) =
      __$$WorkoutSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String routineId,
      String routineName,
      DateTime date,
      String? notes});
}

/// @nodoc
class __$$WorkoutSessionImplCopyWithImpl<$Res>
    extends _$WorkoutSessionCopyWithImpl<$Res, _$WorkoutSessionImpl>
    implements _$$WorkoutSessionImplCopyWith<$Res> {
  __$$WorkoutSessionImplCopyWithImpl(
      _$WorkoutSessionImpl _value, $Res Function(_$WorkoutSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? routineId = null,
    Object? routineName = null,
    Object? date = null,
    Object? notes = freezed,
  }) {
    return _then(_$WorkoutSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      routineId: null == routineId
          ? _value.routineId
          : routineId // ignore: cast_nullable_to_non_nullable
              as String,
      routineName: null == routineName
          ? _value.routineName
          : routineName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$WorkoutSessionImpl implements _WorkoutSession {
  const _$WorkoutSessionImpl(
      {required this.id,
      required this.routineId,
      required this.routineName,
      required this.date,
      this.notes});

  @override
  final String id;
  @override
  final String routineId;
  @override
  final String routineName;
  @override
  final DateTime date;
  @override
  final String? notes;

  @override
  String toString() {
    return 'WorkoutSession(id: $id, routineId: $routineId, routineName: $routineName, date: $date, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.routineId, routineId) ||
                other.routineId == routineId) &&
            (identical(other.routineName, routineName) ||
                other.routineName == routineName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, routineId, routineName, date, notes);

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSessionImplCopyWith<_$WorkoutSessionImpl> get copyWith =>
      __$$WorkoutSessionImplCopyWithImpl<_$WorkoutSessionImpl>(
          this, _$identity);
}

abstract class _WorkoutSession implements WorkoutSession {
  const factory _WorkoutSession(
      {required final String id,
      required final String routineId,
      required final String routineName,
      required final DateTime date,
      final String? notes}) = _$WorkoutSessionImpl;

  @override
  String get id;
  @override
  String get routineId;
  @override
  String get routineName;
  @override
  DateTime get date;
  @override
  String? get notes;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutSessionImplCopyWith<_$WorkoutSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SetLog {
  String get id => throw _privateConstructorUsedError;
  String get sessionId => throw _privateConstructorUsedError;
  String get workoutExerciseId => throw _privateConstructorUsedError;
  int get setNumber => throw _privateConstructorUsedError;
  double? get actualValue1 => throw _privateConstructorUsedError;
  double? get actualValue2 => throw _privateConstructorUsedError;
  WorkoutUnit? get unit1 => throw _privateConstructorUsedError;
  WorkoutUnit? get unit2 => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Create a copy of SetLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SetLogCopyWith<SetLog> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetLogCopyWith<$Res> {
  factory $SetLogCopyWith(SetLog value, $Res Function(SetLog) then) =
      _$SetLogCopyWithImpl<$Res, SetLog>;
  @useResult
  $Res call(
      {String id,
      String sessionId,
      String workoutExerciseId,
      int setNumber,
      double? actualValue1,
      double? actualValue2,
      WorkoutUnit? unit1,
      WorkoutUnit? unit2,
      bool isCompleted,
      DateTime timestamp});
}

/// @nodoc
class _$SetLogCopyWithImpl<$Res, $Val extends SetLog>
    implements $SetLogCopyWith<$Res> {
  _$SetLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SetLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? workoutExerciseId = null,
    Object? setNumber = null,
    Object? actualValue1 = freezed,
    Object? actualValue2 = freezed,
    Object? unit1 = freezed,
    Object? unit2 = freezed,
    Object? isCompleted = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      workoutExerciseId: null == workoutExerciseId
          ? _value.workoutExerciseId
          : workoutExerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      setNumber: null == setNumber
          ? _value.setNumber
          : setNumber // ignore: cast_nullable_to_non_nullable
              as int,
      actualValue1: freezed == actualValue1
          ? _value.actualValue1
          : actualValue1 // ignore: cast_nullable_to_non_nullable
              as double?,
      actualValue2: freezed == actualValue2
          ? _value.actualValue2
          : actualValue2 // ignore: cast_nullable_to_non_nullable
              as double?,
      unit1: freezed == unit1
          ? _value.unit1
          : unit1 // ignore: cast_nullable_to_non_nullable
              as WorkoutUnit?,
      unit2: freezed == unit2
          ? _value.unit2
          : unit2 // ignore: cast_nullable_to_non_nullable
              as WorkoutUnit?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SetLogImplCopyWith<$Res> implements $SetLogCopyWith<$Res> {
  factory _$$SetLogImplCopyWith(
          _$SetLogImpl value, $Res Function(_$SetLogImpl) then) =
      __$$SetLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sessionId,
      String workoutExerciseId,
      int setNumber,
      double? actualValue1,
      double? actualValue2,
      WorkoutUnit? unit1,
      WorkoutUnit? unit2,
      bool isCompleted,
      DateTime timestamp});
}

/// @nodoc
class __$$SetLogImplCopyWithImpl<$Res>
    extends _$SetLogCopyWithImpl<$Res, _$SetLogImpl>
    implements _$$SetLogImplCopyWith<$Res> {
  __$$SetLogImplCopyWithImpl(
      _$SetLogImpl _value, $Res Function(_$SetLogImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? workoutExerciseId = null,
    Object? setNumber = null,
    Object? actualValue1 = freezed,
    Object? actualValue2 = freezed,
    Object? unit1 = freezed,
    Object? unit2 = freezed,
    Object? isCompleted = null,
    Object? timestamp = null,
  }) {
    return _then(_$SetLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      workoutExerciseId: null == workoutExerciseId
          ? _value.workoutExerciseId
          : workoutExerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      setNumber: null == setNumber
          ? _value.setNumber
          : setNumber // ignore: cast_nullable_to_non_nullable
              as int,
      actualValue1: freezed == actualValue1
          ? _value.actualValue1
          : actualValue1 // ignore: cast_nullable_to_non_nullable
              as double?,
      actualValue2: freezed == actualValue2
          ? _value.actualValue2
          : actualValue2 // ignore: cast_nullable_to_non_nullable
              as double?,
      unit1: freezed == unit1
          ? _value.unit1
          : unit1 // ignore: cast_nullable_to_non_nullable
              as WorkoutUnit?,
      unit2: freezed == unit2
          ? _value.unit2
          : unit2 // ignore: cast_nullable_to_non_nullable
              as WorkoutUnit?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$SetLogImpl implements _SetLog {
  const _$SetLogImpl(
      {required this.id,
      required this.sessionId,
      required this.workoutExerciseId,
      required this.setNumber,
      this.actualValue1,
      this.actualValue2,
      this.unit1,
      this.unit2,
      required this.isCompleted,
      required this.timestamp});

  @override
  final String id;
  @override
  final String sessionId;
  @override
  final String workoutExerciseId;
  @override
  final int setNumber;
  @override
  final double? actualValue1;
  @override
  final double? actualValue2;
  @override
  final WorkoutUnit? unit1;
  @override
  final WorkoutUnit? unit2;
  @override
  final bool isCompleted;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'SetLog(id: $id, sessionId: $sessionId, workoutExerciseId: $workoutExerciseId, setNumber: $setNumber, actualValue1: $actualValue1, actualValue2: $actualValue2, unit1: $unit1, unit2: $unit2, isCompleted: $isCompleted, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.workoutExerciseId, workoutExerciseId) ||
                other.workoutExerciseId == workoutExerciseId) &&
            (identical(other.setNumber, setNumber) ||
                other.setNumber == setNumber) &&
            (identical(other.actualValue1, actualValue1) ||
                other.actualValue1 == actualValue1) &&
            (identical(other.actualValue2, actualValue2) ||
                other.actualValue2 == actualValue2) &&
            (identical(other.unit1, unit1) || other.unit1 == unit1) &&
            (identical(other.unit2, unit2) || other.unit2 == unit2) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sessionId,
      workoutExerciseId,
      setNumber,
      actualValue1,
      actualValue2,
      unit1,
      unit2,
      isCompleted,
      timestamp);

  /// Create a copy of SetLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetLogImplCopyWith<_$SetLogImpl> get copyWith =>
      __$$SetLogImplCopyWithImpl<_$SetLogImpl>(this, _$identity);
}

abstract class _SetLog implements SetLog {
  const factory _SetLog(
      {required final String id,
      required final String sessionId,
      required final String workoutExerciseId,
      required final int setNumber,
      final double? actualValue1,
      final double? actualValue2,
      final WorkoutUnit? unit1,
      final WorkoutUnit? unit2,
      required final bool isCompleted,
      required final DateTime timestamp}) = _$SetLogImpl;

  @override
  String get id;
  @override
  String get sessionId;
  @override
  String get workoutExerciseId;
  @override
  int get setNumber;
  @override
  double? get actualValue1;
  @override
  double? get actualValue2;
  @override
  WorkoutUnit? get unit1;
  @override
  WorkoutUnit? get unit2;
  @override
  bool get isCompleted;
  @override
  DateTime get timestamp;

  /// Create a copy of SetLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetLogImplCopyWith<_$SetLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
