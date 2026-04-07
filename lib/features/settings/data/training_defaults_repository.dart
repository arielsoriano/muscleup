import '../../workout/data/datasources/local/workout_database.dart';
import '../../workout/data/datasources/remote/workout_remote_data_source.dart';
import '../domain/entities/training_defaults.dart';

class TrainingDefaultsRepository {
  TrainingDefaultsRepository({
    required AppDatabase database,
    required WorkoutRemoteDataSource workoutRemoteDataSource,
  })  : _database = database,
        _workoutRemoteDataSource = workoutRemoteDataSource;

  final AppDatabase _database;
  final WorkoutRemoteDataSource _workoutRemoteDataSource;

  Future<TrainingDefaults> getLocalDefaults() async {
    final rows = await _database.customSelect(
      '''
      SELECT default_rest_seconds, default_repetitions, default_weight, updated_at
      FROM training_defaults
      WHERE id = 1
      LIMIT 1
      ''',
    ).get();

    if (rows.isEmpty) {
      final defaults = TrainingDefaults.fallback();
      await _upsertLocalDefaults(defaults);
      return defaults;
    }

    final row = rows.first.data;
    return TrainingDefaults(
      defaultRestSeconds: (row['default_rest_seconds'] as int?) ??
          TrainingDefaults.defaultRestSecondsFallback,
      defaultRepetitions: (row['default_repetitions'] as int?) ??
          TrainingDefaults.defaultRepetitionsFallback,
      defaultWeight: (row['default_weight'] as num?)?.toDouble() ??
          TrainingDefaults.defaultWeightFallback,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        (row['updated_at'] as int?) ?? DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<void> saveLocalDefaults(TrainingDefaults defaults) async {
    await _upsertLocalDefaults(defaults);
  }

  Future<void> pushDefaultsToCloud(String uid, TrainingDefaults defaults) async {
    await _workoutRemoteDataSource.upsertTrainingDefaults(
      uid,
      defaultRestSeconds: defaults.defaultRestSeconds,
      defaultRepetitions: defaults.defaultRepetitions,
      defaultWeight: defaults.defaultWeight,
      updatedAt: defaults.updatedAt,
    );
  }

  Future<TrainingDefaults?> fetchDefaultsFromCloud(String uid) async {
    final cloudData = await _workoutRemoteDataSource.fetchTrainingDefaults(uid);
    if (cloudData == null) {
      return null;
    }

    final updatedAtRaw = cloudData['updatedAt'];
    final updatedAt = updatedAtRaw is DateTime
        ? updatedAtRaw
        : DateTime.fromMillisecondsSinceEpoch(
            (updatedAtRaw as int?) ?? DateTime.now().millisecondsSinceEpoch,
          );

    return TrainingDefaults(
      defaultRestSeconds: (cloudData['defaultRestSeconds'] as int?) ??
          TrainingDefaults.defaultRestSecondsFallback,
      defaultRepetitions: (cloudData['defaultRepetitions'] as int?) ??
          TrainingDefaults.defaultRepetitionsFallback,
      defaultWeight: (cloudData['defaultWeight'] as num?)?.toDouble() ??
          TrainingDefaults.defaultWeightFallback,
      updatedAt: updatedAt,
    );
  }

  Future<void> _upsertLocalDefaults(TrainingDefaults defaults) async {
    await _database.customStatement(
      '''
      INSERT INTO training_defaults (
        id,
        default_rest_seconds,
        default_repetitions,
        default_weight,
        updated_at
      ) VALUES (1, ?, ?, ?, ?)
      ON CONFLICT(id) DO UPDATE SET
        default_rest_seconds = excluded.default_rest_seconds,
        default_repetitions = excluded.default_repetitions,
        default_weight = excluded.default_weight,
        updated_at = excluded.updated_at
      ''',
      [
        defaults.defaultRestSeconds,
        defaults.defaultRepetitions,
        defaults.defaultWeight,
        defaults.updatedAt.millisecondsSinceEpoch,
      ],
    );
  }
}
