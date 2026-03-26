import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muscleup/features/workout/data/dtos/exercise_remote_dto.dart';
import 'package:muscleup/features/workout/data/dtos/library_exercise_remote_dto.dart';
import 'package:muscleup/features/workout/data/dtos/routine_remote_dto.dart';
import 'package:muscleup/features/workout/data/dtos/session_remote_dto.dart';
import 'package:muscleup/features/workout/data/dtos/set_log_remote_dto.dart';
import 'package:muscleup/features/workout/data/dtos/set_remote_dto.dart';
import 'package:muscleup/features/workout/domain/entities/workout_entities.dart';
import 'package:muscleup/features/workout/domain/repositories/workout_repository.dart';

void main() {
  group('Remote DTO serialization', () {
    test('RoutineRemoteDto roundtrip preserves sync metadata', () {
      final now = DateTime(2025, 1, 1, 12, 30);
      final routine = WorkoutRoutine(
        id: 'routine-1',
        name: 'Push Day',
        sortOrder: 1,
        exercises: const <WorkoutExercise>[],
        syncMetadata: SyncMetadata(
          updatedAt: now,
          deletedAt: null,
          syncStatus: 'synced',
          remoteVersion: 7,
        ),
      );

      final dto = RoutineRemoteDto.fromDomain(routine);
      final map = dto.toFirestore();
      final fromFirestore = RoutineRemoteDto.fromFirestore(map, routine.id);
      final backToDomain = fromFirestore.toDomain();

      expect(map['updatedAt'], isA<Timestamp>());
      expect(backToDomain.id, routine.id);
      expect(backToDomain.name, routine.name);
      expect(backToDomain.syncMetadata?.remoteVersion, 7);
      expect(backToDomain.syncMetadata?.syncStatus, 'synced');
    });

    test('ExerciseRemoteDto includes relation and nullable notes', () {
      final now = DateTime(2025, 1, 2, 8, 0);
      final exercise = WorkoutExercise(
        id: 'exercise-1',
        name: 'Bench Press',
        sortOrder: 2,
        notes: null,
        restTimeSeconds: 90,
        templateSets: const <WorkoutSet>[],
        syncMetadata: SyncMetadata(
          updatedAt: now,
          deletedAt: null,
          syncStatus: 'pending',
          remoteVersion: 2,
        ),
      );

      final dto = ExerciseRemoteDto.fromDomain(exercise, 'routine-1');
      final map = dto.toFirestore();
      final fromFirestore = ExerciseRemoteDto.fromFirestore(map, exercise.id);

      expect(fromFirestore.routineId, 'routine-1');
      expect(fromFirestore.notes, isNull);
      expect(fromFirestore.toDomain().restTimeSeconds, 90);
    });

    test('SetRemoteDto serializes enum unit names and nullable values', () {
      final now = DateTime(2025, 1, 3, 10, 45);
      final workoutSet = WorkoutSet(
        id: 'set-1',
        sortOrder: 1,
        targetValue1: 12,
        targetValue2: null,
        unit1: WorkoutUnit.repetitions,
        unit2: null,
        syncMetadata: SyncMetadata(
          updatedAt: now,
          deletedAt: null,
          syncStatus: 'synced',
          remoteVersion: 5,
        ),
      );

      final dto = SetRemoteDto.fromDomain(workoutSet, 'exercise-1');
      final map = dto.toFirestore();
      final fromFirestore = SetRemoteDto.fromFirestore(map, workoutSet.id);

      expect(map['unit1'], 'repetitions');
      expect(fromFirestore.unit1, WorkoutUnit.repetitions);
      expect(fromFirestore.unit2, isNull);
      expect(fromFirestore.toDomain().targetValue1, 12);
      expect(fromFirestore.toDomain().targetValue2, isNull);
    });

    test('SessionRemoteDto roundtrip preserves completion and notes', () {
      final now = DateTime(2025, 1, 4, 18, 20);
      final session = WorkoutSession(
        id: 'session-1',
        routineId: 'routine-1',
        routineName: 'Push Day',
        createdAt: now,
        notes: 'Felt strong',
        isCompleted: false,
        syncMetadata: SyncMetadata(
          updatedAt: now,
          deletedAt: null,
          syncStatus: 'synced',
          remoteVersion: 3,
        ),
      );

      final dto = SessionRemoteDto.fromDomain(session);
      final fromFirestore = SessionRemoteDto.fromFirestore(dto.toFirestore(), session.id);
      final backToDomain = fromFirestore.toDomain();

      expect(backToDomain.isCompleted, isFalse);
      expect(backToDomain.notes, 'Felt strong');
      expect(backToDomain.syncMetadata?.remoteVersion, 3);
    });

    test('SetLogRemoteDto roundtrip preserves timestamp and unit enums', () {
      final now = DateTime(2025, 1, 5, 7, 15);
      final setLog = SetLog(
        id: 'log-1',
        sessionId: 'session-1',
        workoutExerciseId: 'exercise-1',
        setNumber: 1,
        actualValue1: 80,
        actualValue2: 8,
        unit1: WorkoutUnit.kilograms,
        unit2: WorkoutUnit.repetitions,
        isCompleted: true,
        timestamp: now,
        syncMetadata: SyncMetadata(
          updatedAt: now,
          deletedAt: null,
          syncStatus: 'synced',
          remoteVersion: 9,
        ),
      );

      final dto = SetLogRemoteDto.fromDomain(setLog);
      final fromFirestore = SetLogRemoteDto.fromFirestore(dto.toFirestore(), setLog.id);
      final backToDomain = fromFirestore.toDomain();

      expect(backToDomain.unit1, WorkoutUnit.kilograms);
      expect(backToDomain.unit2, WorkoutUnit.repetitions);
      expect(backToDomain.timestamp, now);
      expect(backToDomain.syncMetadata?.remoteVersion, 9);
    });

    test('LibraryExerciseRemoteDto handles sync metadata and soft delete timestamp', () {
      final now = DateTime(2025, 1, 6, 14, 5);
      final deletedAt = DateTime(2025, 1, 7, 9, 0);
      final libraryExercise = LibraryExerciseEntity(
        id: 'lib-1',
        name: 'Dominadas',
        nameEn: 'Pull-up',
        nameEs: 'Dominadas',
        isCustom: true,
        syncMetadata: SyncMetadata(
          updatedAt: now,
          deletedAt: deletedAt,
          syncStatus: 'synced',
          remoteVersion: 11,
        ),
      );

      final dto = LibraryExerciseRemoteDto.fromDomain(libraryExercise);
      final map = dto.toFirestore();
      final fromFirestore = LibraryExerciseRemoteDto.fromFirestore(map, libraryExercise.id);
      final backToDomain = fromFirestore.toDomain();

      expect(map['deletedAt'], isA<Timestamp>());
      expect(backToDomain.nameEn, 'Pull-up');
      expect(backToDomain.syncMetadata?.deletedAt, deletedAt);
      expect(backToDomain.syncMetadata?.remoteVersion, 11);
    });
  });
}
