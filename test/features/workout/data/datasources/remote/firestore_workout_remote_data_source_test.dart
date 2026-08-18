import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muscleup/features/workout/data/datasources/remote/firestore_workout_remote_data_source.dart';
import 'package:muscleup/features/workout/domain/entities/workout_entities.dart';

void main() {
  group('FirestoreWorkoutRemoteDataSource', () {
    late FakeFirebaseFirestore firestore;
    late FirestoreWorkoutRemoteDataSource dataSource;

    setUp(() {
      firestore = FakeFirebaseFirestore();
      dataSource = FirestoreWorkoutRemoteDataSource(firestore);
    });

    /// Reproduces the shape of a real import: saveRoutine stamps one
    /// DateTime.now() on the whole routine, so every exercise and set it writes
    /// shares one identical updatedAt. Four saved routines therefore produce
    /// four large groups of documents with four distinct timestamps between
    /// them — and any pagination that resumes from "updatedAt greater than the
    /// last one I saw" silently drops whatever is left of a group when a page
    /// boundary lands inside it.
    Future<void> seedSets({
      required int groups,
      required int perGroup,
    }) async {
      for (var group = 0; group < groups; group++) {
        final sharedUpdatedAt = DateTime(2025, 1, 1, 10, group);
        for (var index = 0; index < perGroup; index++) {
          await firestore
              .collection('users')
              .doc('user-a')
              .collection('sets')
              .doc('set-$group-$index')
              .set(<String, Object?>{
            'exerciseId': 'exercise-$group',
            'sortOrder': index,
            'targetValue1': 60,
            'targetValue2': 12,
            'unit1': 'kilograms',
            'unit2': 'repetitions',
            'updatedAt': Timestamp.fromDate(sharedUpdatedAt),
            'deletedAt': null,
            'syncStatus': 'synced',
            'remoteVersion': 1,
          });
        }
      }
    }

    test('fetches every document when many share one updatedAt', () async {
      await seedSets(groups: 4, perGroup: 18);

      final fetched = await dataSource.fetchSetsUpdatedSince(
        'user-a',
        null,
        pageSize: 25,
      );

      expect(fetched, hasLength(72));
      expect(
        fetched.map((dto) => dto.id).toSet(),
        hasLength(72),
        reason: 'no document may be returned twice',
      );
    });

    test('a page boundary inside a timestamp group loses nothing', () async {
      // 25 documents on one timestamp with a page size of 10: the boundary
      // falls inside the group twice over.
      await seedSets(groups: 1, perGroup: 25);

      final fetched = await dataSource.fetchSetsUpdatedSince(
        'user-a',
        null,
        pageSize: 10,
      );

      expect(fetched, hasLength(25));
    });

    test('updatedSince still excludes everything already seen', () async {
      await seedSets(groups: 4, perGroup: 18);

      final fetched = await dataSource.fetchSetsUpdatedSince(
        'user-a',
        DateTime(2025, 1, 1, 10, 1),
        pageSize: 25,
      );

      // The first two groups are at 10:00 and 10:01, so only the last two
      // remain.
      expect(fetched, hasLength(36));
    });

    test('upsertRoutine writes under users/{uid}/routines/{id}', () async {
      const uid = 'user-a';
      final routine = WorkoutRoutine(
        id: 'routine-1',
        name: 'Leg Day',
        sortOrder: 0,
        exercises: const <WorkoutExercise>[],
        syncMetadata: SyncMetadata(
          updatedAt: DateTime(2025, 1, 1),
          deletedAt: null,
          syncStatus: 'synced',
          remoteVersion: 1,
        ),
      );

      await dataSource.upsertRoutine(uid, routine);

      final doc = await firestore
          .collection('users')
          .doc(uid)
          .collection('routines')
          .doc(routine.id)
          .get();

      expect(doc.exists, isTrue);
      expect(doc.data()?['name'], 'Leg Day');
      expect(doc.data()?['updatedAt'], isA<Timestamp>());
    });

    test('fetchRoutinesUpdatedSince returns only newer docs', () async {
      const uid = 'user-a';
      final base = DateTime(2025, 1, 1, 0, 0);

      await firestore
          .collection('users')
          .doc(uid)
          .collection('routines')
          .doc('old')
          .set(<String, dynamic>{
        'name': 'Old',
        'sortOrder': 0,
        'updatedAt': Timestamp.fromDate(base),
        'deletedAt': null,
        'syncStatus': 'synced',
        'remoteVersion': 1,
      });

      await firestore
          .collection('users')
          .doc(uid)
          .collection('routines')
          .doc('new')
          .set(<String, dynamic>{
        'name': 'New',
        'sortOrder': 1,
        'updatedAt': Timestamp.fromDate(base.add(const Duration(minutes: 1))),
        'deletedAt': null,
        'syncStatus': 'synced',
        'remoteVersion': 2,
      });

      final result = await dataSource.fetchRoutinesUpdatedSince(
        uid,
        base,
      );

      expect(result.length, 1);
      expect(result.first.id, 'new');
    });

    test('markRoutineDeleted sets deletedAt and increments remoteVersion', () async {
      const uid = 'user-a';
      final ref = firestore
          .collection('users')
          .doc(uid)
          .collection('routines')
          .doc('routine-1');

      await ref.set(<String, dynamic>{
        'name': 'Push',
        'sortOrder': 0,
        'updatedAt': Timestamp.fromDate(DateTime(2025, 1, 1)),
        'deletedAt': null,
        'syncStatus': 'synced',
        'remoteVersion': 3,
      });

      await dataSource.markRoutineDeleted(uid, 'routine-1');

      final updated = await ref.get();
      expect(updated.data()?['deletedAt'], isA<Timestamp>());
      expect(updated.data()?['remoteVersion'], 4);
    });

    test('data is scoped per uid', () async {
      final routine = WorkoutRoutine(
        id: 'routine-shared-id',
        name: 'Scoped',
        sortOrder: 0,
        exercises: const <WorkoutExercise>[],
        syncMetadata: SyncMetadata(
          updatedAt: DateTime(2025, 1, 1),
          deletedAt: null,
          syncStatus: 'synced',
          remoteVersion: 1,
        ),
      );

      await dataSource.upsertRoutine('uid-1', routine);
      await dataSource.upsertRoutine(
        'uid-2',
        routine.copyWith(name: 'Scoped 2'),
      );

      final uid1 = await dataSource.fetchRoutinesUpdatedSince('uid-1', null);
      final uid2 = await dataSource.fetchRoutinesUpdatedSince('uid-2', null);

      expect(uid1.single.name, 'Scoped');
      expect(uid2.single.name, 'Scoped 2');
    });
  });
}
