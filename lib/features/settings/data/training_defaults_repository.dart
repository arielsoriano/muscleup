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
  static const int _emptyIntSentinel = -1;
  static const double _emptyDoubleSentinel = -1;

  Future<TrainingDefaults> getLocalDefaults() async {
    final rows = await _database.customSelect(
      '''
      SELECT
        default_rest_seconds,
        default_repetitions,
        default_weight,
        auto_start_rest_timer_on_set_completed,
        updated_at
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
    final restRaw = row['default_rest_seconds'] as int?;
    final repsRaw = row['default_repetitions'] as int?;
    final weightRaw = (row['default_weight'] as num?)?.toDouble();
    final autoStartRestTimerRaw =
      row['auto_start_rest_timer_on_set_completed'] as int?;

    return TrainingDefaults(
      defaultRestSeconds: restRaw == null
          ? TrainingDefaults.defaultRestSecondsFallback
          : (restRaw == _emptyIntSentinel ? null : restRaw),
      defaultRepetitions: repsRaw == null
          ? TrainingDefaults.defaultRepetitionsFallback
          : (repsRaw == _emptyIntSentinel ? null : repsRaw),
      defaultWeight: weightRaw == null
          ? TrainingDefaults.defaultWeightFallback
          : (weightRaw == _emptyDoubleSentinel ? null : weightRaw),
      autoStartRestTimerOnSetCompleted: autoStartRestTimerRaw == null
          ? TrainingDefaults.autoStartRestTimerOnSetCompletedFallback
          : autoStartRestTimerRaw == 1,
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
      autoStartRestTimerOnSetCompleted:
          defaults.autoStartRestTimerOnSetCompleted,
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
      defaultRestSeconds: cloudData['defaultRestSeconds'] as int?,
      defaultRepetitions: cloudData['defaultRepetitions'] as int?,
      defaultWeight: (cloudData['defaultWeight'] as num?)?.toDouble(),
      autoStartRestTimerOnSetCompleted:
          cloudData['autoStartRestTimerOnSetCompleted'] as bool? ??
              TrainingDefaults.autoStartRestTimerOnSetCompletedFallback,
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
        auto_start_rest_timer_on_set_completed,
        updated_at
      ) VALUES (1, ?, ?, ?, ?, ?)
      ON CONFLICT(id) DO UPDATE SET
        default_rest_seconds = excluded.default_rest_seconds,
        default_repetitions = excluded.default_repetitions,
        default_weight = excluded.default_weight,
        auto_start_rest_timer_on_set_completed = excluded.auto_start_rest_timer_on_set_completed,
        updated_at = excluded.updated_at
      ''',
      [
        defaults.defaultRestSeconds ?? _emptyIntSentinel,
        defaults.defaultRepetitions ?? _emptyIntSentinel,
        defaults.defaultWeight ?? _emptyDoubleSentinel,
        defaults.autoStartRestTimerOnSetCompleted ? 1 : 0,
        defaults.updatedAt.millisecondsSinceEpoch,
      ],
    );
  }
}
