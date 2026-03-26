enum SyncConflictWinner {
  local,
  remote,
}

class SyncConflictPolicy {
  SyncConflictWinner resolve({
    required DateTime localUpdatedAt,
    required DateTime? localDeletedAt,
    required DateTime remoteUpdatedAt,
    required DateTime? remoteDeletedAt,
  }) {
    final localEventTimestamp = localDeletedAt ?? localUpdatedAt;
    final remoteEventTimestamp = remoteDeletedAt ?? remoteUpdatedAt;

    if (remoteEventTimestamp.isAfter(localEventTimestamp)) {
      return SyncConflictWinner.remote;
    }
    if (localEventTimestamp.isAfter(remoteEventTimestamp)) {
      return SyncConflictWinner.local;
    }
    return SyncConflictWinner.remote;
  }

  bool isConflict({
    required DateTime localUpdatedAt,
    required DateTime? localDeletedAt,
    required DateTime remoteUpdatedAt,
    required DateTime? remoteDeletedAt,
  }) {
    return localUpdatedAt != remoteUpdatedAt || localDeletedAt != remoteDeletedAt;
  }
}
