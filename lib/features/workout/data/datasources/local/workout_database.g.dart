// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_database.dart';

// ignore_for_file: type=lint
class $RoutinesTable extends Routines
    with TableInfo<$RoutinesTable, RoutineData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routines';
  @override
  VerificationContext validateIntegrity(Insertable<RoutineData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $RoutinesTable createAlias(String alias) {
    return $RoutinesTable(attachedDatabase, alias);
  }
}

class RoutineData extends DataClass implements Insertable<RoutineData> {
  final String id;
  final String name;
  final int sortOrder;
  const RoutineData(
      {required this.id, required this.name, required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  RoutinesCompanion toCompanion(bool nullToAbsent) {
    return RoutinesCompanion(
      id: Value(id),
      name: Value(name),
      sortOrder: Value(sortOrder),
    );
  }

  factory RoutineData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  RoutineData copyWith({String? id, String? name, int? sortOrder}) =>
      RoutineData(
        id: id ?? this.id,
        name: name ?? this.name,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  RoutineData copyWithCompanion(RoutinesCompanion data) {
    return RoutineData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineData &&
          other.id == this.id &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder);
}

class RoutinesCompanion extends UpdateCompanion<RoutineData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const RoutinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutinesCompanion.insert({
    required String id,
    required String name,
    required int sortOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        sortOrder = Value(sortOrder);
  static Insertable<RoutineData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutinesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<int>? sortOrder,
      Value<int>? rowid}) {
    return RoutinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, ExerciseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _routineIdMeta =
      const VerificationMeta('routineId');
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
      'routine_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES routines (id) ON DELETE CASCADE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _restTimeSecondsMeta =
      const VerificationMeta('restTimeSeconds');
  @override
  late final GeneratedColumn<int> restTimeSeconds = GeneratedColumn<int>(
      'rest_time_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, routineId, name, notes, restTimeSeconds, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(_routineIdMeta,
          routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta));
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('rest_time_seconds')) {
      context.handle(
          _restTimeSecondsMeta,
          restTimeSeconds.isAcceptableOrUnknown(
              data['rest_time_seconds']!, _restTimeSecondsMeta));
    } else if (isInserting) {
      context.missing(_restTimeSecondsMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      routineId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}routine_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      restTimeSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rest_time_seconds'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class ExerciseData extends DataClass implements Insertable<ExerciseData> {
  final String id;
  final String routineId;
  final String name;
  final String? notes;
  final int restTimeSeconds;
  final int sortOrder;
  const ExerciseData(
      {required this.id,
      required this.routineId,
      required this.name,
      this.notes,
      required this.restTimeSeconds,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['routine_id'] = Variable<String>(routineId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['rest_time_seconds'] = Variable<int>(restTimeSeconds);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      routineId: Value(routineId),
      name: Value(name),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      restTimeSeconds: Value(restTimeSeconds),
      sortOrder: Value(sortOrder),
    );
  }

  factory ExerciseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseData(
      id: serializer.fromJson<String>(json['id']),
      routineId: serializer.fromJson<String>(json['routineId']),
      name: serializer.fromJson<String>(json['name']),
      notes: serializer.fromJson<String?>(json['notes']),
      restTimeSeconds: serializer.fromJson<int>(json['restTimeSeconds']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routineId': serializer.toJson<String>(routineId),
      'name': serializer.toJson<String>(name),
      'notes': serializer.toJson<String?>(notes),
      'restTimeSeconds': serializer.toJson<int>(restTimeSeconds),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ExerciseData copyWith(
          {String? id,
          String? routineId,
          String? name,
          Value<String?> notes = const Value.absent(),
          int? restTimeSeconds,
          int? sortOrder}) =>
      ExerciseData(
        id: id ?? this.id,
        routineId: routineId ?? this.routineId,
        name: name ?? this.name,
        notes: notes.present ? notes.value : this.notes,
        restTimeSeconds: restTimeSeconds ?? this.restTimeSeconds,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  ExerciseData copyWithCompanion(ExercisesCompanion data) {
    return ExerciseData(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      name: data.name.present ? data.name.value : this.name,
      notes: data.notes.present ? data.notes.value : this.notes,
      restTimeSeconds: data.restTimeSeconds.present
          ? data.restTimeSeconds.value
          : this.restTimeSeconds,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseData(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('name: $name, ')
          ..write('notes: $notes, ')
          ..write('restTimeSeconds: $restTimeSeconds, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, routineId, name, notes, restTimeSeconds, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseData &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.name == this.name &&
          other.notes == this.notes &&
          other.restTimeSeconds == this.restTimeSeconds &&
          other.sortOrder == this.sortOrder);
}

class ExercisesCompanion extends UpdateCompanion<ExerciseData> {
  final Value<String> id;
  final Value<String> routineId;
  final Value<String> name;
  final Value<String?> notes;
  final Value<int> restTimeSeconds;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.name = const Value.absent(),
    this.notes = const Value.absent(),
    this.restTimeSeconds = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExercisesCompanion.insert({
    required String id,
    required String routineId,
    required String name,
    this.notes = const Value.absent(),
    required int restTimeSeconds,
    required int sortOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        routineId = Value(routineId),
        name = Value(name),
        restTimeSeconds = Value(restTimeSeconds),
        sortOrder = Value(sortOrder);
  static Insertable<ExerciseData> custom({
    Expression<String>? id,
    Expression<String>? routineId,
    Expression<String>? name,
    Expression<String>? notes,
    Expression<int>? restTimeSeconds,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (name != null) 'name': name,
      if (notes != null) 'notes': notes,
      if (restTimeSeconds != null) 'rest_time_seconds': restTimeSeconds,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExercisesCompanion copyWith(
      {Value<String>? id,
      Value<String>? routineId,
      Value<String>? name,
      Value<String?>? notes,
      Value<int>? restTimeSeconds,
      Value<int>? sortOrder,
      Value<int>? rowid}) {
    return ExercisesCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      restTimeSeconds: restTimeSeconds ?? this.restTimeSeconds,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (restTimeSeconds.present) {
      map['rest_time_seconds'] = Variable<int>(restTimeSeconds.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('name: $name, ')
          ..write('notes: $notes, ')
          ..write('restTimeSeconds: $restTimeSeconds, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SetsTable extends Sets with TableInfo<$SetsTable, SetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exerciseIdMeta =
      const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
      'exercise_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES exercises (id) ON DELETE CASCADE'));
  static const VerificationMeta _targetValue1Meta =
      const VerificationMeta('targetValue1');
  @override
  late final GeneratedColumn<double> targetValue1 = GeneratedColumn<double>(
      'target_value1', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _targetValue2Meta =
      const VerificationMeta('targetValue2');
  @override
  late final GeneratedColumn<double> targetValue2 = GeneratedColumn<double>(
      'target_value2', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<WorkoutUnit?, int> unit1 =
      GeneratedColumn<int>('unit1', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<WorkoutUnit?>($SetsTable.$converterunit1n);
  @override
  late final GeneratedColumnWithTypeConverter<WorkoutUnit?, int> unit2 =
      GeneratedColumn<int>('unit2', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<WorkoutUnit?>($SetsTable.$converterunit2n);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, exerciseId, targetValue1, targetValue2, unit1, unit2, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sets';
  @override
  VerificationContext validateIntegrity(Insertable<SetData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('target_value1')) {
      context.handle(
          _targetValue1Meta,
          targetValue1.isAcceptableOrUnknown(
              data['target_value1']!, _targetValue1Meta));
    }
    if (data.containsKey('target_value2')) {
      context.handle(
          _targetValue2Meta,
          targetValue2.isAcceptableOrUnknown(
              data['target_value2']!, _targetValue2Meta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SetData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SetData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      exerciseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_id'])!,
      targetValue1: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_value1']),
      targetValue2: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_value2']),
      unit1: $SetsTable.$converterunit1n.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unit1'])),
      unit2: $SetsTable.$converterunit2n.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unit2'])),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $SetsTable createAlias(String alias) {
    return $SetsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WorkoutUnit, int, int> $converterunit1 =
      const EnumIndexConverter<WorkoutUnit>(WorkoutUnit.values);
  static JsonTypeConverter2<WorkoutUnit?, int?, int?> $converterunit1n =
      JsonTypeConverter2.asNullable($converterunit1);
  static JsonTypeConverter2<WorkoutUnit, int, int> $converterunit2 =
      const EnumIndexConverter<WorkoutUnit>(WorkoutUnit.values);
  static JsonTypeConverter2<WorkoutUnit?, int?, int?> $converterunit2n =
      JsonTypeConverter2.asNullable($converterunit2);
}

class SetData extends DataClass implements Insertable<SetData> {
  final String id;
  final String exerciseId;
  final double? targetValue1;
  final double? targetValue2;
  final WorkoutUnit? unit1;
  final WorkoutUnit? unit2;
  final int sortOrder;
  const SetData(
      {required this.id,
      required this.exerciseId,
      this.targetValue1,
      this.targetValue2,
      this.unit1,
      this.unit2,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    if (!nullToAbsent || targetValue1 != null) {
      map['target_value1'] = Variable<double>(targetValue1);
    }
    if (!nullToAbsent || targetValue2 != null) {
      map['target_value2'] = Variable<double>(targetValue2);
    }
    if (!nullToAbsent || unit1 != null) {
      map['unit1'] = Variable<int>($SetsTable.$converterunit1n.toSql(unit1));
    }
    if (!nullToAbsent || unit2 != null) {
      map['unit2'] = Variable<int>($SetsTable.$converterunit2n.toSql(unit2));
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  SetsCompanion toCompanion(bool nullToAbsent) {
    return SetsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      targetValue1: targetValue1 == null && nullToAbsent
          ? const Value.absent()
          : Value(targetValue1),
      targetValue2: targetValue2 == null && nullToAbsent
          ? const Value.absent()
          : Value(targetValue2),
      unit1:
          unit1 == null && nullToAbsent ? const Value.absent() : Value(unit1),
      unit2:
          unit2 == null && nullToAbsent ? const Value.absent() : Value(unit2),
      sortOrder: Value(sortOrder),
    );
  }

  factory SetData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SetData(
      id: serializer.fromJson<String>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      targetValue1: serializer.fromJson<double?>(json['targetValue1']),
      targetValue2: serializer.fromJson<double?>(json['targetValue2']),
      unit1: $SetsTable.$converterunit1n
          .fromJson(serializer.fromJson<int?>(json['unit1'])),
      unit2: $SetsTable.$converterunit2n
          .fromJson(serializer.fromJson<int?>(json['unit2'])),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'targetValue1': serializer.toJson<double?>(targetValue1),
      'targetValue2': serializer.toJson<double?>(targetValue2),
      'unit1':
          serializer.toJson<int?>($SetsTable.$converterunit1n.toJson(unit1)),
      'unit2':
          serializer.toJson<int?>($SetsTable.$converterunit2n.toJson(unit2)),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  SetData copyWith(
          {String? id,
          String? exerciseId,
          Value<double?> targetValue1 = const Value.absent(),
          Value<double?> targetValue2 = const Value.absent(),
          Value<WorkoutUnit?> unit1 = const Value.absent(),
          Value<WorkoutUnit?> unit2 = const Value.absent(),
          int? sortOrder}) =>
      SetData(
        id: id ?? this.id,
        exerciseId: exerciseId ?? this.exerciseId,
        targetValue1:
            targetValue1.present ? targetValue1.value : this.targetValue1,
        targetValue2:
            targetValue2.present ? targetValue2.value : this.targetValue2,
        unit1: unit1.present ? unit1.value : this.unit1,
        unit2: unit2.present ? unit2.value : this.unit2,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  SetData copyWithCompanion(SetsCompanion data) {
    return SetData(
      id: data.id.present ? data.id.value : this.id,
      exerciseId:
          data.exerciseId.present ? data.exerciseId.value : this.exerciseId,
      targetValue1: data.targetValue1.present
          ? data.targetValue1.value
          : this.targetValue1,
      targetValue2: data.targetValue2.present
          ? data.targetValue2.value
          : this.targetValue2,
      unit1: data.unit1.present ? data.unit1.value : this.unit1,
      unit2: data.unit2.present ? data.unit2.value : this.unit2,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SetData(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('targetValue1: $targetValue1, ')
          ..write('targetValue2: $targetValue2, ')
          ..write('unit1: $unit1, ')
          ..write('unit2: $unit2, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, exerciseId, targetValue1, targetValue2, unit1, unit2, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetData &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.targetValue1 == this.targetValue1 &&
          other.targetValue2 == this.targetValue2 &&
          other.unit1 == this.unit1 &&
          other.unit2 == this.unit2 &&
          other.sortOrder == this.sortOrder);
}

class SetsCompanion extends UpdateCompanion<SetData> {
  final Value<String> id;
  final Value<String> exerciseId;
  final Value<double?> targetValue1;
  final Value<double?> targetValue2;
  final Value<WorkoutUnit?> unit1;
  final Value<WorkoutUnit?> unit2;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const SetsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.targetValue1 = const Value.absent(),
    this.targetValue2 = const Value.absent(),
    this.unit1 = const Value.absent(),
    this.unit2 = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SetsCompanion.insert({
    required String id,
    required String exerciseId,
    this.targetValue1 = const Value.absent(),
    this.targetValue2 = const Value.absent(),
    this.unit1 = const Value.absent(),
    this.unit2 = const Value.absent(),
    required int sortOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        exerciseId = Value(exerciseId),
        sortOrder = Value(sortOrder);
  static Insertable<SetData> custom({
    Expression<String>? id,
    Expression<String>? exerciseId,
    Expression<double>? targetValue1,
    Expression<double>? targetValue2,
    Expression<int>? unit1,
    Expression<int>? unit2,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (targetValue1 != null) 'target_value1': targetValue1,
      if (targetValue2 != null) 'target_value2': targetValue2,
      if (unit1 != null) 'unit1': unit1,
      if (unit2 != null) 'unit2': unit2,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? exerciseId,
      Value<double?>? targetValue1,
      Value<double?>? targetValue2,
      Value<WorkoutUnit?>? unit1,
      Value<WorkoutUnit?>? unit2,
      Value<int>? sortOrder,
      Value<int>? rowid}) {
    return SetsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      targetValue1: targetValue1 ?? this.targetValue1,
      targetValue2: targetValue2 ?? this.targetValue2,
      unit1: unit1 ?? this.unit1,
      unit2: unit2 ?? this.unit2,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (targetValue1.present) {
      map['target_value1'] = Variable<double>(targetValue1.value);
    }
    if (targetValue2.present) {
      map['target_value2'] = Variable<double>(targetValue2.value);
    }
    if (unit1.present) {
      map['unit1'] =
          Variable<int>($SetsTable.$converterunit1n.toSql(unit1.value));
    }
    if (unit2.present) {
      map['unit2'] =
          Variable<int>($SetsTable.$converterunit2n.toSql(unit2.value));
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('targetValue1: $targetValue1, ')
          ..write('targetValue2: $targetValue2, ')
          ..write('unit1: $unit1, ')
          ..write('unit2: $unit2, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions
    with TableInfo<$SessionsTable, SessionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _routineIdMeta =
      const VerificationMeta('routineId');
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
      'routine_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES routines (id)'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, routineId, date, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(Insertable<SessionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(_routineIdMeta,
          routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta));
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      routineId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}routine_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class SessionData extends DataClass implements Insertable<SessionData> {
  final String id;
  final String routineId;
  final DateTime date;
  final String? notes;
  const SessionData(
      {required this.id,
      required this.routineId,
      required this.date,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['routine_id'] = Variable<String>(routineId);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      routineId: Value(routineId),
      date: Value(date),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory SessionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionData(
      id: serializer.fromJson<String>(json['id']),
      routineId: serializer.fromJson<String>(json['routineId']),
      date: serializer.fromJson<DateTime>(json['date']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routineId': serializer.toJson<String>(routineId),
      'date': serializer.toJson<DateTime>(date),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  SessionData copyWith(
          {String? id,
          String? routineId,
          DateTime? date,
          Value<String?> notes = const Value.absent()}) =>
      SessionData(
        id: id ?? this.id,
        routineId: routineId ?? this.routineId,
        date: date ?? this.date,
        notes: notes.present ? notes.value : this.notes,
      );
  SessionData copyWithCompanion(SessionsCompanion data) {
    return SessionData(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      date: data.date.present ? data.date.value : this.date,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionData(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('date: $date, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, routineId, date, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionData &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.date == this.date &&
          other.notes == this.notes);
}

class SessionsCompanion extends UpdateCompanion<SessionData> {
  final Value<String> id;
  final Value<String> routineId;
  final Value<DateTime> date;
  final Value<String?> notes;
  final Value<int> rowid;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.date = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsCompanion.insert({
    required String id,
    required String routineId,
    required DateTime date,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        routineId = Value(routineId),
        date = Value(date);
  static Insertable<SessionData> custom({
    Expression<String>? id,
    Expression<String>? routineId,
    Expression<DateTime>? date,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (date != null) 'date': date,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? routineId,
      Value<DateTime>? date,
      Value<String?>? notes,
      Value<int>? rowid}) {
    return SessionsCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('date: $date, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SetLogsTable extends SetLogs with TableInfo<$SetLogsTable, SetLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SetLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES sessions (id) ON DELETE CASCADE'));
  static const VerificationMeta _workoutExerciseIdMeta =
      const VerificationMeta('workoutExerciseId');
  @override
  late final GeneratedColumn<String> workoutExerciseId =
      GeneratedColumn<String>('workout_exercise_id', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _setNumberMeta =
      const VerificationMeta('setNumber');
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
      'set_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _actualValue1Meta =
      const VerificationMeta('actualValue1');
  @override
  late final GeneratedColumn<double> actualValue1 = GeneratedColumn<double>(
      'actual_value1', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _actualValue2Meta =
      const VerificationMeta('actualValue2');
  @override
  late final GeneratedColumn<double> actualValue2 = GeneratedColumn<double>(
      'actual_value2', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<WorkoutUnit?, int> unit1 =
      GeneratedColumn<int>('unit1', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<WorkoutUnit?>($SetLogsTable.$converterunit1n);
  @override
  late final GeneratedColumnWithTypeConverter<WorkoutUnit?, int> unit2 =
      GeneratedColumn<int>('unit2', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<WorkoutUnit?>($SetLogsTable.$converterunit2n);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'));
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sessionId,
        workoutExerciseId,
        setNumber,
        actualValue1,
        actualValue2,
        unit1,
        unit2,
        isCompleted,
        timestamp
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'set_logs';
  @override
  VerificationContext validateIntegrity(Insertable<SetLogData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('workout_exercise_id')) {
      context.handle(
          _workoutExerciseIdMeta,
          workoutExerciseId.isAcceptableOrUnknown(
              data['workout_exercise_id']!, _workoutExerciseIdMeta));
    } else if (isInserting) {
      context.missing(_workoutExerciseIdMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(_setNumberMeta,
          setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta));
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('actual_value1')) {
      context.handle(
          _actualValue1Meta,
          actualValue1.isAcceptableOrUnknown(
              data['actual_value1']!, _actualValue1Meta));
    }
    if (data.containsKey('actual_value2')) {
      context.handle(
          _actualValue2Meta,
          actualValue2.isAcceptableOrUnknown(
              data['actual_value2']!, _actualValue2Meta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    } else if (isInserting) {
      context.missing(_isCompletedMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SetLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SetLogData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      workoutExerciseId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}workout_exercise_id'])!,
      setNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set_number'])!,
      actualValue1: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}actual_value1']),
      actualValue2: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}actual_value2']),
      unit1: $SetLogsTable.$converterunit1n.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unit1'])),
      unit2: $SetLogsTable.$converterunit2n.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unit2'])),
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $SetLogsTable createAlias(String alias) {
    return $SetLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WorkoutUnit, int, int> $converterunit1 =
      const EnumIndexConverter<WorkoutUnit>(WorkoutUnit.values);
  static JsonTypeConverter2<WorkoutUnit?, int?, int?> $converterunit1n =
      JsonTypeConverter2.asNullable($converterunit1);
  static JsonTypeConverter2<WorkoutUnit, int, int> $converterunit2 =
      const EnumIndexConverter<WorkoutUnit>(WorkoutUnit.values);
  static JsonTypeConverter2<WorkoutUnit?, int?, int?> $converterunit2n =
      JsonTypeConverter2.asNullable($converterunit2);
}

class SetLogData extends DataClass implements Insertable<SetLogData> {
  final String id;
  final String sessionId;
  final String workoutExerciseId;
  final int setNumber;
  final double? actualValue1;
  final double? actualValue2;
  final WorkoutUnit? unit1;
  final WorkoutUnit? unit2;
  final bool isCompleted;
  final DateTime timestamp;
  const SetLogData(
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['workout_exercise_id'] = Variable<String>(workoutExerciseId);
    map['set_number'] = Variable<int>(setNumber);
    if (!nullToAbsent || actualValue1 != null) {
      map['actual_value1'] = Variable<double>(actualValue1);
    }
    if (!nullToAbsent || actualValue2 != null) {
      map['actual_value2'] = Variable<double>(actualValue2);
    }
    if (!nullToAbsent || unit1 != null) {
      map['unit1'] = Variable<int>($SetLogsTable.$converterunit1n.toSql(unit1));
    }
    if (!nullToAbsent || unit2 != null) {
      map['unit2'] = Variable<int>($SetLogsTable.$converterunit2n.toSql(unit2));
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  SetLogsCompanion toCompanion(bool nullToAbsent) {
    return SetLogsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      workoutExerciseId: Value(workoutExerciseId),
      setNumber: Value(setNumber),
      actualValue1: actualValue1 == null && nullToAbsent
          ? const Value.absent()
          : Value(actualValue1),
      actualValue2: actualValue2 == null && nullToAbsent
          ? const Value.absent()
          : Value(actualValue2),
      unit1:
          unit1 == null && nullToAbsent ? const Value.absent() : Value(unit1),
      unit2:
          unit2 == null && nullToAbsent ? const Value.absent() : Value(unit2),
      isCompleted: Value(isCompleted),
      timestamp: Value(timestamp),
    );
  }

  factory SetLogData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SetLogData(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      workoutExerciseId: serializer.fromJson<String>(json['workoutExerciseId']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
      actualValue1: serializer.fromJson<double?>(json['actualValue1']),
      actualValue2: serializer.fromJson<double?>(json['actualValue2']),
      unit1: $SetLogsTable.$converterunit1n
          .fromJson(serializer.fromJson<int?>(json['unit1'])),
      unit2: $SetLogsTable.$converterunit2n
          .fromJson(serializer.fromJson<int?>(json['unit2'])),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'workoutExerciseId': serializer.toJson<String>(workoutExerciseId),
      'setNumber': serializer.toJson<int>(setNumber),
      'actualValue1': serializer.toJson<double?>(actualValue1),
      'actualValue2': serializer.toJson<double?>(actualValue2),
      'unit1':
          serializer.toJson<int?>($SetLogsTable.$converterunit1n.toJson(unit1)),
      'unit2':
          serializer.toJson<int?>($SetLogsTable.$converterunit2n.toJson(unit2)),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  SetLogData copyWith(
          {String? id,
          String? sessionId,
          String? workoutExerciseId,
          int? setNumber,
          Value<double?> actualValue1 = const Value.absent(),
          Value<double?> actualValue2 = const Value.absent(),
          Value<WorkoutUnit?> unit1 = const Value.absent(),
          Value<WorkoutUnit?> unit2 = const Value.absent(),
          bool? isCompleted,
          DateTime? timestamp}) =>
      SetLogData(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        workoutExerciseId: workoutExerciseId ?? this.workoutExerciseId,
        setNumber: setNumber ?? this.setNumber,
        actualValue1:
            actualValue1.present ? actualValue1.value : this.actualValue1,
        actualValue2:
            actualValue2.present ? actualValue2.value : this.actualValue2,
        unit1: unit1.present ? unit1.value : this.unit1,
        unit2: unit2.present ? unit2.value : this.unit2,
        isCompleted: isCompleted ?? this.isCompleted,
        timestamp: timestamp ?? this.timestamp,
      );
  SetLogData copyWithCompanion(SetLogsCompanion data) {
    return SetLogData(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      workoutExerciseId: data.workoutExerciseId.present
          ? data.workoutExerciseId.value
          : this.workoutExerciseId,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      actualValue1: data.actualValue1.present
          ? data.actualValue1.value
          : this.actualValue1,
      actualValue2: data.actualValue2.present
          ? data.actualValue2.value
          : this.actualValue2,
      unit1: data.unit1.present ? data.unit1.value : this.unit1,
      unit2: data.unit2.present ? data.unit2.value : this.unit2,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SetLogData(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('workoutExerciseId: $workoutExerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('actualValue1: $actualValue1, ')
          ..write('actualValue2: $actualValue2, ')
          ..write('unit1: $unit1, ')
          ..write('unit2: $unit2, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, workoutExerciseId, setNumber,
      actualValue1, actualValue2, unit1, unit2, isCompleted, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetLogData &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.workoutExerciseId == this.workoutExerciseId &&
          other.setNumber == this.setNumber &&
          other.actualValue1 == this.actualValue1 &&
          other.actualValue2 == this.actualValue2 &&
          other.unit1 == this.unit1 &&
          other.unit2 == this.unit2 &&
          other.isCompleted == this.isCompleted &&
          other.timestamp == this.timestamp);
}

class SetLogsCompanion extends UpdateCompanion<SetLogData> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> workoutExerciseId;
  final Value<int> setNumber;
  final Value<double?> actualValue1;
  final Value<double?> actualValue2;
  final Value<WorkoutUnit?> unit1;
  final Value<WorkoutUnit?> unit2;
  final Value<bool> isCompleted;
  final Value<DateTime> timestamp;
  final Value<int> rowid;
  const SetLogsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.workoutExerciseId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.actualValue1 = const Value.absent(),
    this.actualValue2 = const Value.absent(),
    this.unit1 = const Value.absent(),
    this.unit2 = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SetLogsCompanion.insert({
    required String id,
    required String sessionId,
    required String workoutExerciseId,
    required int setNumber,
    this.actualValue1 = const Value.absent(),
    this.actualValue2 = const Value.absent(),
    this.unit1 = const Value.absent(),
    this.unit2 = const Value.absent(),
    required bool isCompleted,
    required DateTime timestamp,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessionId = Value(sessionId),
        workoutExerciseId = Value(workoutExerciseId),
        setNumber = Value(setNumber),
        isCompleted = Value(isCompleted),
        timestamp = Value(timestamp);
  static Insertable<SetLogData> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? workoutExerciseId,
    Expression<int>? setNumber,
    Expression<double>? actualValue1,
    Expression<double>? actualValue2,
    Expression<int>? unit1,
    Expression<int>? unit2,
    Expression<bool>? isCompleted,
    Expression<DateTime>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (workoutExerciseId != null) 'workout_exercise_id': workoutExerciseId,
      if (setNumber != null) 'set_number': setNumber,
      if (actualValue1 != null) 'actual_value1': actualValue1,
      if (actualValue2 != null) 'actual_value2': actualValue2,
      if (unit1 != null) 'unit1': unit1,
      if (unit2 != null) 'unit2': unit2,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SetLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessionId,
      Value<String>? workoutExerciseId,
      Value<int>? setNumber,
      Value<double?>? actualValue1,
      Value<double?>? actualValue2,
      Value<WorkoutUnit?>? unit1,
      Value<WorkoutUnit?>? unit2,
      Value<bool>? isCompleted,
      Value<DateTime>? timestamp,
      Value<int>? rowid}) {
    return SetLogsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      workoutExerciseId: workoutExerciseId ?? this.workoutExerciseId,
      setNumber: setNumber ?? this.setNumber,
      actualValue1: actualValue1 ?? this.actualValue1,
      actualValue2: actualValue2 ?? this.actualValue2,
      unit1: unit1 ?? this.unit1,
      unit2: unit2 ?? this.unit2,
      isCompleted: isCompleted ?? this.isCompleted,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (workoutExerciseId.present) {
      map['workout_exercise_id'] = Variable<String>(workoutExerciseId.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (actualValue1.present) {
      map['actual_value1'] = Variable<double>(actualValue1.value);
    }
    if (actualValue2.present) {
      map['actual_value2'] = Variable<double>(actualValue2.value);
    }
    if (unit1.present) {
      map['unit1'] =
          Variable<int>($SetLogsTable.$converterunit1n.toSql(unit1.value));
    }
    if (unit2.present) {
      map['unit2'] =
          Variable<int>($SetLogsTable.$converterunit2n.toSql(unit2.value));
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetLogsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('workoutExerciseId: $workoutExerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('actualValue1: $actualValue1, ')
          ..write('actualValue2: $actualValue2, ')
          ..write('unit1: $unit1, ')
          ..write('unit2: $unit2, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LibraryExercisesTable extends LibraryExercises
    with TableInfo<$LibraryExercisesTable, LibraryExerciseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LibraryExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameEsMeta = const VerificationMeta('nameEs');
  @override
  late final GeneratedColumn<String> nameEs = GeneratedColumn<String>(
      'name_es', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isCustomMeta =
      const VerificationMeta('isCustom');
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
      'is_custom', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_custom" IN (0, 1))'));
  @override
  late final GeneratedColumnWithTypeConverter<ExerciseCategory?, int> category =
      GeneratedColumn<int>('category', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<ExerciseCategory?>(
              $LibraryExercisesTable.$convertercategoryn);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, nameEn, nameEs, isCustom, category];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'library_exercises';
  @override
  VerificationContext validateIntegrity(
      Insertable<LibraryExerciseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_es')) {
      context.handle(_nameEsMeta,
          nameEs.isAcceptableOrUnknown(data['name_es']!, _nameEsMeta));
    } else if (isInserting) {
      context.missing(_nameEsMeta);
    }
    if (data.containsKey('is_custom')) {
      context.handle(_isCustomMeta,
          isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta));
    } else if (isInserting) {
      context.missing(_isCustomMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LibraryExerciseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LibraryExerciseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en'])!,
      nameEs: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_es'])!,
      isCustom: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_custom'])!,
      category: $LibraryExercisesTable.$convertercategoryn.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}category'])),
    );
  }

  @override
  $LibraryExercisesTable createAlias(String alias) {
    return $LibraryExercisesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ExerciseCategory, int, int> $convertercategory =
      const EnumIndexConverter<ExerciseCategory>(ExerciseCategory.values);
  static JsonTypeConverter2<ExerciseCategory?, int?, int?> $convertercategoryn =
      JsonTypeConverter2.asNullable($convertercategory);
}

class LibraryExerciseData extends DataClass
    implements Insertable<LibraryExerciseData> {
  final String id;
  final String name;
  final String nameEn;
  final String nameEs;
  final bool isCustom;
  final ExerciseCategory? category;
  const LibraryExerciseData(
      {required this.id,
      required this.name,
      required this.nameEn,
      required this.nameEs,
      required this.isCustom,
      this.category});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['name_en'] = Variable<String>(nameEn);
    map['name_es'] = Variable<String>(nameEs);
    map['is_custom'] = Variable<bool>(isCustom);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<int>(
          $LibraryExercisesTable.$convertercategoryn.toSql(category));
    }
    return map;
  }

  LibraryExercisesCompanion toCompanion(bool nullToAbsent) {
    return LibraryExercisesCompanion(
      id: Value(id),
      name: Value(name),
      nameEn: Value(nameEn),
      nameEs: Value(nameEs),
      isCustom: Value(isCustom),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
    );
  }

  factory LibraryExerciseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LibraryExerciseData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameEs: serializer.fromJson<String>(json['nameEs']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      category: $LibraryExercisesTable.$convertercategoryn
          .fromJson(serializer.fromJson<int?>(json['category'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameEs': serializer.toJson<String>(nameEs),
      'isCustom': serializer.toJson<bool>(isCustom),
      'category': serializer.toJson<int?>(
          $LibraryExercisesTable.$convertercategoryn.toJson(category)),
    };
  }

  LibraryExerciseData copyWith(
          {String? id,
          String? name,
          String? nameEn,
          String? nameEs,
          bool? isCustom,
          Value<ExerciseCategory?> category = const Value.absent()}) =>
      LibraryExerciseData(
        id: id ?? this.id,
        name: name ?? this.name,
        nameEn: nameEn ?? this.nameEn,
        nameEs: nameEs ?? this.nameEs,
        isCustom: isCustom ?? this.isCustom,
        category: category.present ? category.value : this.category,
      );
  LibraryExerciseData copyWithCompanion(LibraryExercisesCompanion data) {
    return LibraryExerciseData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LibraryExerciseData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameEs: $nameEs, ')
          ..write('isCustom: $isCustom, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, nameEn, nameEs, isCustom, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LibraryExerciseData &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameEn == this.nameEn &&
          other.nameEs == this.nameEs &&
          other.isCustom == this.isCustom &&
          other.category == this.category);
}

class LibraryExercisesCompanion extends UpdateCompanion<LibraryExerciseData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> nameEn;
  final Value<String> nameEs;
  final Value<bool> isCustom;
  final Value<ExerciseCategory?> category;
  final Value<int> rowid;
  const LibraryExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LibraryExercisesCompanion.insert({
    required String id,
    required String name,
    required String nameEn,
    required String nameEs,
    required bool isCustom,
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        nameEn = Value(nameEn),
        nameEs = Value(nameEs),
        isCustom = Value(isCustom);
  static Insertable<LibraryExerciseData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? nameEn,
    Expression<String>? nameEs,
    Expression<bool>? isCustom,
    Expression<int>? category,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameEn != null) 'name_en': nameEn,
      if (nameEs != null) 'name_es': nameEs,
      if (isCustom != null) 'is_custom': isCustom,
      if (category != null) 'category': category,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LibraryExercisesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? nameEn,
      Value<String>? nameEs,
      Value<bool>? isCustom,
      Value<ExerciseCategory?>? category,
      Value<int>? rowid}) {
    return LibraryExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      nameEs: nameEs ?? this.nameEs,
      isCustom: isCustom ?? this.isCustom,
      category: category ?? this.category,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(
          $LibraryExercisesTable.$convertercategoryn.toSql(category.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LibraryExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameEs: $nameEs, ')
          ..write('isCustom: $isCustom, ')
          ..write('category: $category, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RoutinesTable routines = $RoutinesTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $SetsTable sets = $SetsTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $SetLogsTable setLogs = $SetLogsTable(this);
  late final $LibraryExercisesTable libraryExercises =
      $LibraryExercisesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [routines, exercises, sets, sessions, setLogs, libraryExercises];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('routines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('exercises', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('exercises',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('sets', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('sessions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('set_logs', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$RoutinesTableCreateCompanionBuilder = RoutinesCompanion Function({
  required String id,
  required String name,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$RoutinesTableUpdateCompanionBuilder = RoutinesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$RoutinesTableReferences
    extends BaseReferences<_$AppDatabase, $RoutinesTable, RoutineData> {
  $$RoutinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExercisesTable, List<ExerciseData>>
      _exercisesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.exercises,
              aliasName:
                  $_aliasNameGenerator(db.routines.id, db.exercises.routineId));

  $$ExercisesTableProcessedTableManager get exercisesRefs {
    final manager = $$ExercisesTableTableManager($_db, $_db.exercises)
        .filter((f) => f.routineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_exercisesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SessionsTable, List<SessionData>>
      _sessionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.sessions,
              aliasName:
                  $_aliasNameGenerator(db.routines.id, db.sessions.routineId));

  $$SessionsTableProcessedTableManager get sessionsRefs {
    final manager = $$SessionsTableTableManager($_db, $_db.sessions)
        .filter((f) => f.routineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RoutinesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  Expression<bool> exercisesRefs(
      Expression<bool> Function($$ExercisesTableFilterComposer f) f) {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.routineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableFilterComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> sessionsRefs(
      Expression<bool> Function($$SessionsTableFilterComposer f) f) {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.routineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableFilterComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoutinesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));
}

class $$RoutinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> exercisesRefs<T extends Object>(
      Expression<T> Function($$ExercisesTableAnnotationComposer a) f) {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.routineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableAnnotationComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> sessionsRefs<T extends Object>(
      Expression<T> Function($$SessionsTableAnnotationComposer a) f) {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.routineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoutinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RoutinesTable,
    RoutineData,
    $$RoutinesTableFilterComposer,
    $$RoutinesTableOrderingComposer,
    $$RoutinesTableAnnotationComposer,
    $$RoutinesTableCreateCompanionBuilder,
    $$RoutinesTableUpdateCompanionBuilder,
    (RoutineData, $$RoutinesTableReferences),
    RoutineData,
    PrefetchHooks Function({bool exercisesRefs, bool sessionsRefs})> {
  $$RoutinesTableTableManager(_$AppDatabase db, $RoutinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RoutinesCompanion(
            id: id,
            name: name,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required int sortOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              RoutinesCompanion.insert(
            id: id,
            name: name,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$RoutinesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {exercisesRefs = false, sessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (exercisesRefs) db.exercises,
                if (sessionsRefs) db.sessions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (exercisesRefs)
                    await $_getPrefetchedData<RoutineData, $RoutinesTable,
                            ExerciseData>(
                        currentTable: table,
                        referencedTable:
                            $$RoutinesTableReferences._exercisesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RoutinesTableReferences(db, table, p0)
                                .exercisesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.routineId == item.id),
                        typedResults: items),
                  if (sessionsRefs)
                    await $_getPrefetchedData<RoutineData, $RoutinesTable,
                            SessionData>(
                        currentTable: table,
                        referencedTable:
                            $$RoutinesTableReferences._sessionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RoutinesTableReferences(db, table, p0)
                                .sessionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.routineId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RoutinesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RoutinesTable,
    RoutineData,
    $$RoutinesTableFilterComposer,
    $$RoutinesTableOrderingComposer,
    $$RoutinesTableAnnotationComposer,
    $$RoutinesTableCreateCompanionBuilder,
    $$RoutinesTableUpdateCompanionBuilder,
    (RoutineData, $$RoutinesTableReferences),
    RoutineData,
    PrefetchHooks Function({bool exercisesRefs, bool sessionsRefs})>;
typedef $$ExercisesTableCreateCompanionBuilder = ExercisesCompanion Function({
  required String id,
  required String routineId,
  required String name,
  Value<String?> notes,
  required int restTimeSeconds,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$ExercisesTableUpdateCompanionBuilder = ExercisesCompanion Function({
  Value<String> id,
  Value<String> routineId,
  Value<String> name,
  Value<String?> notes,
  Value<int> restTimeSeconds,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$ExercisesTableReferences
    extends BaseReferences<_$AppDatabase, $ExercisesTable, ExerciseData> {
  $$ExercisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RoutinesTable _routineIdTable(_$AppDatabase db) =>
      db.routines.createAlias(
          $_aliasNameGenerator(db.exercises.routineId, db.routines.id));

  $$RoutinesTableProcessedTableManager get routineId {
    final $_column = $_itemColumn<String>('routine_id')!;

    final manager = $$RoutinesTableTableManager($_db, $_db.routines)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SetsTable, List<SetData>> _setsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.sets,
          aliasName: $_aliasNameGenerator(db.exercises.id, db.sets.exerciseId));

  $$SetsTableProcessedTableManager get setsRefs {
    final manager = $$SetsTableTableManager($_db, $_db.sets)
        .filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_setsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get restTimeSeconds => $composableBuilder(
      column: $table.restTimeSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  $$RoutinesTableFilterComposer get routineId {
    final $$RoutinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $db.routines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoutinesTableFilterComposer(
              $db: $db,
              $table: $db.routines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> setsRefs(
      Expression<bool> Function($$SetsTableFilterComposer f) f) {
    final $$SetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sets,
        getReferencedColumn: (t) => t.exerciseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetsTableFilterComposer(
              $db: $db,
              $table: $db.sets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get restTimeSeconds => $composableBuilder(
      column: $table.restTimeSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  $$RoutinesTableOrderingComposer get routineId {
    final $$RoutinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $db.routines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoutinesTableOrderingComposer(
              $db: $db,
              $table: $db.routines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get restTimeSeconds => $composableBuilder(
      column: $table.restTimeSeconds, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$RoutinesTableAnnotationComposer get routineId {
    final $$RoutinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $db.routines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoutinesTableAnnotationComposer(
              $db: $db,
              $table: $db.routines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> setsRefs<T extends Object>(
      Expression<T> Function($$SetsTableAnnotationComposer a) f) {
    final $$SetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sets,
        getReferencedColumn: (t) => t.exerciseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetsTableAnnotationComposer(
              $db: $db,
              $table: $db.sets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExercisesTable,
    ExerciseData,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableAnnotationComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder,
    (ExerciseData, $$ExercisesTableReferences),
    ExerciseData,
    PrefetchHooks Function({bool routineId, bool setsRefs})> {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> routineId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> restTimeSeconds = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExercisesCompanion(
            id: id,
            routineId: routineId,
            name: name,
            notes: notes,
            restTimeSeconds: restTimeSeconds,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String routineId,
            required String name,
            Value<String?> notes = const Value.absent(),
            required int restTimeSeconds,
            required int sortOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              ExercisesCompanion.insert(
            id: id,
            routineId: routineId,
            name: name,
            notes: notes,
            restTimeSeconds: restTimeSeconds,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExercisesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({routineId = false, setsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (setsRefs) db.sets],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (routineId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.routineId,
                    referencedTable:
                        $$ExercisesTableReferences._routineIdTable(db),
                    referencedColumn:
                        $$ExercisesTableReferences._routineIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (setsRefs)
                    await $_getPrefetchedData<ExerciseData, $ExercisesTable,
                            SetData>(
                        currentTable: table,
                        referencedTable:
                            $$ExercisesTableReferences._setsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExercisesTableReferences(db, table, p0).setsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.exerciseId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExercisesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExercisesTable,
    ExerciseData,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableAnnotationComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder,
    (ExerciseData, $$ExercisesTableReferences),
    ExerciseData,
    PrefetchHooks Function({bool routineId, bool setsRefs})>;
typedef $$SetsTableCreateCompanionBuilder = SetsCompanion Function({
  required String id,
  required String exerciseId,
  Value<double?> targetValue1,
  Value<double?> targetValue2,
  Value<WorkoutUnit?> unit1,
  Value<WorkoutUnit?> unit2,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$SetsTableUpdateCompanionBuilder = SetsCompanion Function({
  Value<String> id,
  Value<String> exerciseId,
  Value<double?> targetValue1,
  Value<double?> targetValue2,
  Value<WorkoutUnit?> unit1,
  Value<WorkoutUnit?> unit2,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$SetsTableReferences
    extends BaseReferences<_$AppDatabase, $SetsTable, SetData> {
  $$SetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) => db.exercises
      .createAlias($_aliasNameGenerator(db.sets.exerciseId, db.exercises.id));

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<String>('exercise_id')!;

    final manager = $$ExercisesTableTableManager($_db, $_db.exercises)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SetsTableFilterComposer extends Composer<_$AppDatabase, $SetsTable> {
  $$SetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetValue1 => $composableBuilder(
      column: $table.targetValue1, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetValue2 => $composableBuilder(
      column: $table.targetValue2, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<WorkoutUnit?, WorkoutUnit, int> get unit1 =>
      $composableBuilder(
          column: $table.unit1,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<WorkoutUnit?, WorkoutUnit, int> get unit2 =>
      $composableBuilder(
          column: $table.unit2,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableFilterComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SetsTableOrderingComposer extends Composer<_$AppDatabase, $SetsTable> {
  $$SetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetValue1 => $composableBuilder(
      column: $table.targetValue1,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetValue2 => $composableBuilder(
      column: $table.targetValue2,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unit1 => $composableBuilder(
      column: $table.unit1, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unit2 => $composableBuilder(
      column: $table.unit2, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableOrderingComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SetsTable> {
  $$SetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get targetValue1 => $composableBuilder(
      column: $table.targetValue1, builder: (column) => column);

  GeneratedColumn<double> get targetValue2 => $composableBuilder(
      column: $table.targetValue2, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WorkoutUnit?, int> get unit1 =>
      $composableBuilder(column: $table.unit1, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WorkoutUnit?, int> get unit2 =>
      $composableBuilder(column: $table.unit2, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableAnnotationComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SetsTable,
    SetData,
    $$SetsTableFilterComposer,
    $$SetsTableOrderingComposer,
    $$SetsTableAnnotationComposer,
    $$SetsTableCreateCompanionBuilder,
    $$SetsTableUpdateCompanionBuilder,
    (SetData, $$SetsTableReferences),
    SetData,
    PrefetchHooks Function({bool exerciseId})> {
  $$SetsTableTableManager(_$AppDatabase db, $SetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> exerciseId = const Value.absent(),
            Value<double?> targetValue1 = const Value.absent(),
            Value<double?> targetValue2 = const Value.absent(),
            Value<WorkoutUnit?> unit1 = const Value.absent(),
            Value<WorkoutUnit?> unit2 = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SetsCompanion(
            id: id,
            exerciseId: exerciseId,
            targetValue1: targetValue1,
            targetValue2: targetValue2,
            unit1: unit1,
            unit2: unit2,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String exerciseId,
            Value<double?> targetValue1 = const Value.absent(),
            Value<double?> targetValue2 = const Value.absent(),
            Value<WorkoutUnit?> unit1 = const Value.absent(),
            Value<WorkoutUnit?> unit2 = const Value.absent(),
            required int sortOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              SetsCompanion.insert(
            id: id,
            exerciseId: exerciseId,
            targetValue1: targetValue1,
            targetValue2: targetValue2,
            unit1: unit1,
            unit2: unit2,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SetsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (exerciseId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.exerciseId,
                    referencedTable: $$SetsTableReferences._exerciseIdTable(db),
                    referencedColumn:
                        $$SetsTableReferences._exerciseIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SetsTable,
    SetData,
    $$SetsTableFilterComposer,
    $$SetsTableOrderingComposer,
    $$SetsTableAnnotationComposer,
    $$SetsTableCreateCompanionBuilder,
    $$SetsTableUpdateCompanionBuilder,
    (SetData, $$SetsTableReferences),
    SetData,
    PrefetchHooks Function({bool exerciseId})>;
typedef $$SessionsTableCreateCompanionBuilder = SessionsCompanion Function({
  required String id,
  required String routineId,
  required DateTime date,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$SessionsTableUpdateCompanionBuilder = SessionsCompanion Function({
  Value<String> id,
  Value<String> routineId,
  Value<DateTime> date,
  Value<String?> notes,
  Value<int> rowid,
});

final class $$SessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsTable, SessionData> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RoutinesTable _routineIdTable(_$AppDatabase db) => db.routines
      .createAlias($_aliasNameGenerator(db.sessions.routineId, db.routines.id));

  $$RoutinesTableProcessedTableManager get routineId {
    final $_column = $_itemColumn<String>('routine_id')!;

    final manager = $$RoutinesTableTableManager($_db, $_db.routines)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SetLogsTable, List<SetLogData>> _setLogsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.setLogs,
          aliasName:
              $_aliasNameGenerator(db.sessions.id, db.setLogs.sessionId));

  $$SetLogsTableProcessedTableManager get setLogsRefs {
    final manager = $$SetLogsTableTableManager($_db, $_db.setLogs)
        .filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_setLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  $$RoutinesTableFilterComposer get routineId {
    final $$RoutinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $db.routines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoutinesTableFilterComposer(
              $db: $db,
              $table: $db.routines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> setLogsRefs(
      Expression<bool> Function($$SetLogsTableFilterComposer f) f) {
    final $$SetLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.setLogs,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetLogsTableFilterComposer(
              $db: $db,
              $table: $db.setLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  $$RoutinesTableOrderingComposer get routineId {
    final $$RoutinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $db.routines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoutinesTableOrderingComposer(
              $db: $db,
              $table: $db.routines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$RoutinesTableAnnotationComposer get routineId {
    final $$RoutinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $db.routines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoutinesTableAnnotationComposer(
              $db: $db,
              $table: $db.routines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> setLogsRefs<T extends Object>(
      Expression<T> Function($$SetLogsTableAnnotationComposer a) f) {
    final $$SetLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.setLogs,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.setLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SessionsTable,
    SessionData,
    $$SessionsTableFilterComposer,
    $$SessionsTableOrderingComposer,
    $$SessionsTableAnnotationComposer,
    $$SessionsTableCreateCompanionBuilder,
    $$SessionsTableUpdateCompanionBuilder,
    (SessionData, $$SessionsTableReferences),
    SessionData,
    PrefetchHooks Function({bool routineId, bool setLogsRefs})> {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> routineId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SessionsCompanion(
            id: id,
            routineId: routineId,
            date: date,
            notes: notes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String routineId,
            required DateTime date,
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SessionsCompanion.insert(
            id: id,
            routineId: routineId,
            date: date,
            notes: notes,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SessionsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({routineId = false, setLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (setLogsRefs) db.setLogs],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (routineId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.routineId,
                    referencedTable:
                        $$SessionsTableReferences._routineIdTable(db),
                    referencedColumn:
                        $$SessionsTableReferences._routineIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (setLogsRefs)
                    await $_getPrefetchedData<SessionData, $SessionsTable,
                            SetLogData>(
                        currentTable: table,
                        referencedTable:
                            $$SessionsTableReferences._setLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SessionsTableReferences(db, table, p0)
                                .setLogsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sessionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SessionsTable,
    SessionData,
    $$SessionsTableFilterComposer,
    $$SessionsTableOrderingComposer,
    $$SessionsTableAnnotationComposer,
    $$SessionsTableCreateCompanionBuilder,
    $$SessionsTableUpdateCompanionBuilder,
    (SessionData, $$SessionsTableReferences),
    SessionData,
    PrefetchHooks Function({bool routineId, bool setLogsRefs})>;
typedef $$SetLogsTableCreateCompanionBuilder = SetLogsCompanion Function({
  required String id,
  required String sessionId,
  required String workoutExerciseId,
  required int setNumber,
  Value<double?> actualValue1,
  Value<double?> actualValue2,
  Value<WorkoutUnit?> unit1,
  Value<WorkoutUnit?> unit2,
  required bool isCompleted,
  required DateTime timestamp,
  Value<int> rowid,
});
typedef $$SetLogsTableUpdateCompanionBuilder = SetLogsCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<String> workoutExerciseId,
  Value<int> setNumber,
  Value<double?> actualValue1,
  Value<double?> actualValue2,
  Value<WorkoutUnit?> unit1,
  Value<WorkoutUnit?> unit2,
  Value<bool> isCompleted,
  Value<DateTime> timestamp,
  Value<int> rowid,
});

final class $$SetLogsTableReferences
    extends BaseReferences<_$AppDatabase, $SetLogsTable, SetLogData> {
  $$SetLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionsTable _sessionIdTable(_$AppDatabase db) => db.sessions
      .createAlias($_aliasNameGenerator(db.setLogs.sessionId, db.sessions.id));

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableManager($_db, $_db.sessions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SetLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SetLogsTable> {
  $$SetLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workoutExerciseId => $composableBuilder(
      column: $table.workoutExerciseId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get actualValue1 => $composableBuilder(
      column: $table.actualValue1, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get actualValue2 => $composableBuilder(
      column: $table.actualValue2, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<WorkoutUnit?, WorkoutUnit, int> get unit1 =>
      $composableBuilder(
          column: $table.unit1,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<WorkoutUnit?, WorkoutUnit, int> get unit2 =>
      $composableBuilder(
          column: $table.unit2,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableFilterComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SetLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SetLogsTable> {
  $$SetLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workoutExerciseId => $composableBuilder(
      column: $table.workoutExerciseId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get actualValue1 => $composableBuilder(
      column: $table.actualValue1,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get actualValue2 => $composableBuilder(
      column: $table.actualValue2,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unit1 => $composableBuilder(
      column: $table.unit1, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unit2 => $composableBuilder(
      column: $table.unit2, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableOrderingComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SetLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SetLogsTable> {
  $$SetLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workoutExerciseId => $composableBuilder(
      column: $table.workoutExerciseId, builder: (column) => column);

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<double> get actualValue1 => $composableBuilder(
      column: $table.actualValue1, builder: (column) => column);

  GeneratedColumn<double> get actualValue2 => $composableBuilder(
      column: $table.actualValue2, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WorkoutUnit?, int> get unit1 =>
      $composableBuilder(column: $table.unit1, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WorkoutUnit?, int> get unit2 =>
      $composableBuilder(column: $table.unit2, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SetLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SetLogsTable,
    SetLogData,
    $$SetLogsTableFilterComposer,
    $$SetLogsTableOrderingComposer,
    $$SetLogsTableAnnotationComposer,
    $$SetLogsTableCreateCompanionBuilder,
    $$SetLogsTableUpdateCompanionBuilder,
    (SetLogData, $$SetLogsTableReferences),
    SetLogData,
    PrefetchHooks Function({bool sessionId})> {
  $$SetLogsTableTableManager(_$AppDatabase db, $SetLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SetLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SetLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SetLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sessionId = const Value.absent(),
            Value<String> workoutExerciseId = const Value.absent(),
            Value<int> setNumber = const Value.absent(),
            Value<double?> actualValue1 = const Value.absent(),
            Value<double?> actualValue2 = const Value.absent(),
            Value<WorkoutUnit?> unit1 = const Value.absent(),
            Value<WorkoutUnit?> unit2 = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SetLogsCompanion(
            id: id,
            sessionId: sessionId,
            workoutExerciseId: workoutExerciseId,
            setNumber: setNumber,
            actualValue1: actualValue1,
            actualValue2: actualValue2,
            unit1: unit1,
            unit2: unit2,
            isCompleted: isCompleted,
            timestamp: timestamp,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sessionId,
            required String workoutExerciseId,
            required int setNumber,
            Value<double?> actualValue1 = const Value.absent(),
            Value<double?> actualValue2 = const Value.absent(),
            Value<WorkoutUnit?> unit1 = const Value.absent(),
            Value<WorkoutUnit?> unit2 = const Value.absent(),
            required bool isCompleted,
            required DateTime timestamp,
            Value<int> rowid = const Value.absent(),
          }) =>
              SetLogsCompanion.insert(
            id: id,
            sessionId: sessionId,
            workoutExerciseId: workoutExerciseId,
            setNumber: setNumber,
            actualValue1: actualValue1,
            actualValue2: actualValue2,
            unit1: unit1,
            unit2: unit2,
            isCompleted: isCompleted,
            timestamp: timestamp,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SetLogsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (sessionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sessionId,
                    referencedTable:
                        $$SetLogsTableReferences._sessionIdTable(db),
                    referencedColumn:
                        $$SetLogsTableReferences._sessionIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SetLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SetLogsTable,
    SetLogData,
    $$SetLogsTableFilterComposer,
    $$SetLogsTableOrderingComposer,
    $$SetLogsTableAnnotationComposer,
    $$SetLogsTableCreateCompanionBuilder,
    $$SetLogsTableUpdateCompanionBuilder,
    (SetLogData, $$SetLogsTableReferences),
    SetLogData,
    PrefetchHooks Function({bool sessionId})>;
typedef $$LibraryExercisesTableCreateCompanionBuilder
    = LibraryExercisesCompanion Function({
  required String id,
  required String name,
  required String nameEn,
  required String nameEs,
  required bool isCustom,
  Value<ExerciseCategory?> category,
  Value<int> rowid,
});
typedef $$LibraryExercisesTableUpdateCompanionBuilder
    = LibraryExercisesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> nameEn,
  Value<String> nameEs,
  Value<bool> isCustom,
  Value<ExerciseCategory?> category,
  Value<int> rowid,
});

class $$LibraryExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $LibraryExercisesTable> {
  $$LibraryExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEs => $composableBuilder(
      column: $table.nameEs, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCustom => $composableBuilder(
      column: $table.isCustom, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ExerciseCategory?, ExerciseCategory, int>
      get category => $composableBuilder(
          column: $table.category,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$LibraryExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $LibraryExercisesTable> {
  $$LibraryExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEs => $composableBuilder(
      column: $table.nameEs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCustom => $composableBuilder(
      column: $table.isCustom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));
}

class $$LibraryExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LibraryExercisesTable> {
  $$LibraryExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  GeneratedColumn<bool> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ExerciseCategory?, int> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);
}

class $$LibraryExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LibraryExercisesTable,
    LibraryExerciseData,
    $$LibraryExercisesTableFilterComposer,
    $$LibraryExercisesTableOrderingComposer,
    $$LibraryExercisesTableAnnotationComposer,
    $$LibraryExercisesTableCreateCompanionBuilder,
    $$LibraryExercisesTableUpdateCompanionBuilder,
    (
      LibraryExerciseData,
      BaseReferences<_$AppDatabase, $LibraryExercisesTable, LibraryExerciseData>
    ),
    LibraryExerciseData,
    PrefetchHooks Function()> {
  $$LibraryExercisesTableTableManager(
      _$AppDatabase db, $LibraryExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LibraryExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LibraryExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LibraryExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> nameEn = const Value.absent(),
            Value<String> nameEs = const Value.absent(),
            Value<bool> isCustom = const Value.absent(),
            Value<ExerciseCategory?> category = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LibraryExercisesCompanion(
            id: id,
            name: name,
            nameEn: nameEn,
            nameEs: nameEs,
            isCustom: isCustom,
            category: category,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String nameEn,
            required String nameEs,
            required bool isCustom,
            Value<ExerciseCategory?> category = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LibraryExercisesCompanion.insert(
            id: id,
            name: name,
            nameEn: nameEn,
            nameEs: nameEs,
            isCustom: isCustom,
            category: category,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LibraryExercisesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LibraryExercisesTable,
    LibraryExerciseData,
    $$LibraryExercisesTableFilterComposer,
    $$LibraryExercisesTableOrderingComposer,
    $$LibraryExercisesTableAnnotationComposer,
    $$LibraryExercisesTableCreateCompanionBuilder,
    $$LibraryExercisesTableUpdateCompanionBuilder,
    (
      LibraryExerciseData,
      BaseReferences<_$AppDatabase, $LibraryExercisesTable, LibraryExerciseData>
    ),
    LibraryExerciseData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db, _db.routines);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$SetsTableTableManager get sets => $$SetsTableTableManager(_db, _db.sets);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$SetLogsTableTableManager get setLogs =>
      $$SetLogsTableTableManager(_db, _db.setLogs);
  $$LibraryExercisesTableTableManager get libraryExercises =>
      $$LibraryExercisesTableTableManager(_db, _db.libraryExercises);
}
