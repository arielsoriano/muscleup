import 'package:flutter_test/flutter_test.dart';
import 'package:muscleup/features/workout/data/sync/sync_conflict_policy.dart';

void main() {
  group('SyncConflictPolicy', () {
    late SyncConflictPolicy policy;

    setUp(() {
      policy = SyncConflictPolicy();
    });

    test('local newer update wins over remote update', () {
      final winner = policy.resolve(
        localUpdatedAt: DateTime(2025, 1, 1, 10, 1),
        localDeletedAt: null,
        remoteUpdatedAt: DateTime(2025, 1, 1, 10, 0),
        remoteDeletedAt: null,
      );

      expect(winner, SyncConflictWinner.local);
    });

    test('remote newer update wins over local update', () {
      final winner = policy.resolve(
        localUpdatedAt: DateTime(2025, 1, 1, 10, 0),
        localDeletedAt: null,
        remoteUpdatedAt: DateTime(2025, 1, 1, 10, 1),
        remoteDeletedAt: null,
      );

      expect(winner, SyncConflictWinner.remote);
    });

    test('remote tombstone newer than local update wins', () {
      final winner = policy.resolve(
        localUpdatedAt: DateTime(2025, 1, 1, 10, 0),
        localDeletedAt: null,
        remoteUpdatedAt: DateTime(2025, 1, 1, 10, 0),
        remoteDeletedAt: DateTime(2025, 1, 1, 10, 2),
      );

      expect(winner, SyncConflictWinner.remote);
    });

    test('local tombstone newer than remote update wins', () {
      final winner = policy.resolve(
        localUpdatedAt: DateTime(2025, 1, 1, 10, 0),
        localDeletedAt: DateTime(2025, 1, 1, 10, 2),
        remoteUpdatedAt: DateTime(2025, 1, 1, 10, 1),
        remoteDeletedAt: null,
      );

      expect(winner, SyncConflictWinner.local);
    });

    test('tie on updatedAt prefers remote for deterministic convergence', () {
      final sharedTimestamp = DateTime(2025, 1, 1, 10, 0);

      final winner = policy.resolve(
        localUpdatedAt: sharedTimestamp,
        localDeletedAt: null,
        remoteUpdatedAt: sharedTimestamp,
        remoteDeletedAt: null,
      );

      expect(winner, SyncConflictWinner.remote);
    });
  });
}
