import 'package:equatable/equatable.dart';

class SyncRunMetrics extends Equatable {
  const SyncRunMetrics({
    required this.pushedCount,
    required this.pulledCount,
    required this.conflictsResolvedCount,
    required this.failedCount,
    required this.startedAt,
    required this.endedAt,
  });

  final int pushedCount;
  final int pulledCount;
  final int conflictsResolvedCount;
  final int failedCount;
  final DateTime startedAt;
  final DateTime endedAt;

  @override
  List<Object> get props => <Object>[
        pushedCount,
        pulledCount,
        conflictsResolvedCount,
        failedCount,
        startedAt,
        endedAt,
      ];
}

sealed class SyncRunState extends Equatable {
  const SyncRunState();

  @override
  List<Object?> get props => <Object?>[];
}

final class SyncIdle extends SyncRunState {
  const SyncIdle();
}

final class Syncing extends SyncRunState {
  const Syncing({required this.startedAt});

  final DateTime startedAt;

  @override
  List<Object?> get props => <Object?>[startedAt];
}

final class SyncSuccess extends SyncRunState {
  const SyncSuccess({required this.metrics});

  final SyncRunMetrics metrics;

  @override
  List<Object?> get props => <Object?>[metrics];
}

final class SyncError extends SyncRunState {
  const SyncError({required this.message, this.metrics});

  final String message;
  final SyncRunMetrics? metrics;

  @override
  List<Object?> get props => <Object?>[message, metrics];
}

class SyncRunResult extends Equatable {
  const SyncRunResult({
    required this.success,
    this.metrics,
    this.message,
  });

  final bool success;
  final SyncRunMetrics? metrics;
  final String? message;

  @override
  List<Object?> get props => <Object?>[success, metrics, message];
}
