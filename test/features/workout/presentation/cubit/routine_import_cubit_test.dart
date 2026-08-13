import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:muscleup/features/settings/data/training_defaults_repository.dart';
import 'package:muscleup/features/settings/domain/entities/training_defaults.dart';
import 'package:muscleup/features/workout/data/datasources/local/workout_database.dart';
import 'package:muscleup/features/workout/data/datasources/remote/firestore_workout_remote_data_source.dart';
import 'package:muscleup/features/workout/data/repositories/workout_repository_impl.dart';
import 'package:muscleup/features/workout/domain/entities/workout_entities.dart';
import 'package:muscleup/features/workout/domain/usecases/save_routine_usecase.dart';
import 'package:muscleup/features/workout/presentation/cubit/routine_import_cubit.dart';
import 'package:muscleup/features/workout/presentation/cubit/routine_import_state.dart';

/// Exercises the import against a real database, because the parser being right
/// is only half of it: the routines have to come back out of Drift with their
/// exercises, sets and catalog links intact.
void main() {
  late AppDatabase database;
  late WorkoutRepositoryImpl repository;
  late TrainingDefaultsRepository defaultsRepository;
  late RoutineImportCubit cubit;

  setUp(() async {
    database = AppDatabase.forExecutor(NativeDatabase.memory());
    repository = WorkoutRepositoryImpl(database);
    // Touch the database so onCreate (and the library seed) runs.
    await database.select(database.libraryExercises).get();

    defaultsRepository = TrainingDefaultsRepository(
      database: database,
      workoutRemoteDataSource: NoopWorkoutRemoteDataSource(),
    );

    cubit = RoutineImportCubit(
      saveRoutineUseCase: SaveRoutineUseCase(repository),
      repository: repository,
      trainingDefaultsRepository: defaultsRepository,
    );
  });

  tearDown(() async {
    await cubit.close();
    await database.close();
  });

  Future<List<WorkoutRoutine>> readRoutines() async {
    final result = await repository.watchRoutines().first;
    return result.fold((failure) => throw Exception(failure), (r) => r);
  }

  Future<void> importText(String text) async {
    cubit.updatePastedText(text);
    await cubit.check();
    await cubit.importPreviewed();
  }

  test('writes the pasted plan to the database', () async {
    await importText('''
{"routines":[
  {"name":"Lunes — Torso","exercises":[
    {"name":"Press de banca","sets":4,"reps":8,"weight":60,"restSeconds":120,"notes":"Bajada lenta"},
    {"name":"Jalón al pecho","sets":3,"reps":12}
  ]},
  {"name":"Martes — Piernas","exercises":[{"name":"Sentadilla","sets":5,"reps":5,"weight":80}]}
]}
''');

    expect(cubit.state.importedCount, 2);
    expect(cubit.state.errorMessage, isNull);

    final routines = await readRoutines();
    expect(
      routines.map((routine) => routine.name),
      ['Lunes — Torso', 'Martes — Piernas'],
    );

    final torso = routines.first;
    expect(torso.exercises, hasLength(2));

    final bench = torso.exercises.first;
    expect(bench.name, 'Press de banca');
    expect(bench.canonicalName, 'Bench Press');
    expect(bench.notes, 'Bajada lenta');
    expect(bench.restTimeSeconds, 120);
    expect(bench.templateSets, hasLength(4));
    expect(bench.templateSets.first.targetValue1, 60);
    expect(bench.templateSets.first.targetValue2, 8);
    expect(bench.templateSets.first.unit1, WorkoutUnit.kilograms);
    expect(bench.templateSets.first.unit2, WorkoutUnit.repetitions);

    // The catalog link survives the round trip, which is the point of storing
    // it: the same routine reads in another language.
    expect(bench.displayName('de'), 'Bankdrücken');
  });

  test('leaves a load the notes never gave empty, even with a default set',
      () async {
    await defaultsRepository.saveLocalDefaults(
      TrainingDefaults(
        defaultRestSeconds: 90,
        defaultRepetitions: 12,
        defaultWeight: 60,
        autoStartRestTimerOnSetCompleted: false,
        updatedAt: DateTime.now(),
      ),
    );

    await importText(
      '{"routines":[{"name":"A","exercises":['
      '{"name":"Elevación de Talones","sets":3},'
      '{"name":"Sentadilla","sets":3,"weight":80}]}]}',
    );

    final exercises = (await readRoutines()).single.exercises;

    // Notes without weights used to import as 60 kg on everything, which then
    // shows up mid-workout as a target the user never chose.
    expect(exercises.first.templateSets.first.targetValue1, isNull);
    // Repetitions and rest are generic enough to take from the defaults.
    expect(exercises.first.templateSets.first.targetValue2, 12);
    expect(exercises.first.restTimeSeconds, 90);
    // A weight the notes did give is still honoured.
    expect(exercises.last.templateSets.first.targetValue1, 80);
  });

  test('appends imported routines after the ones already saved', () async {
    await repository.saveRoutine(
      const WorkoutRoutine(
        id: 'existing',
        name: 'Mine',
        sortOrder: 3,
        exercises: <WorkoutExercise>[],
      ),
    );

    await importText(
      '{"routines":[{"name":"A","exercises":[{"name":"Squat"}]},'
      '{"name":"B","exercises":[{"name":"Deadlift"}]}]}',
    );

    final routines = await readRoutines();
    final imported = {
      for (final routine in routines) routine.name: routine.sortOrder,
    };
    expect(imported['A'], 4);
    expect(imported['B'], 5);
  });

  test('files an invented exercise in the library exactly once', () async {
    await importText('''
{"routines":[
  {"name":"A","exercises":[{"name":"Sillón de cuádriceps"},{"name":"Press de banca"}]},
  {"name":"B","exercises":[{"name":"sillón de cuádriceps"}]}
]}
''');

    final result = await repository.getLibraryExercises();
    final library = result.fold((failure) => throw Exception(failure), (e) => e);

    final custom = library.where((exercise) => exercise.isCustom).toList();
    expect(custom, hasLength(1));
    expect(custom.single.name, 'Sillón de cuádriceps');

    // A catalog exercise was already seeded, so the import must not add a
    // second row for it.
    expect(
      library.where((exercise) => exercise.allNames.contains('Bench Press')),
      hasLength(1),
    );
  });

  test('checking does not write anything on its own', () async {
    cubit.updatePastedText(
      '{"routines":[{"name":"A","exercises":[{"name":"Squat"}]}]}',
    );
    await cubit.check();

    expect(cubit.state.hasPreview, isTrue);
    expect(cubit.state.previewRoutineCount, 1);
    expect(await readRoutines(), isEmpty);
  });

  test('editing the text drops a preview that no longer describes it', () async {
    cubit.updatePastedText(
      '{"routines":[{"name":"A","exercises":[{"name":"Squat"}]}]}',
    );
    await cubit.check();
    expect(cubit.state.hasPreview, isTrue);

    cubit.updatePastedText('{"routines":');
    expect(cubit.state.preview, isNull);
    expect(cubit.state.failure, isNull);

    // Importing is a no-op without a preview, so a stale preview can never be
    // written after the text changed.
    await cubit.importPreviewed();
    expect(await readRoutines(), isEmpty);
  });

  test('reports unusable text without touching the database', () async {
    cubit.updatePastedText('LUNES — Torso\n1. Press inclinado');
    await cubit.check();

    expect(cubit.state.failure, isNotNull);
    expect(cubit.state.hasPreview, isFalse);
    expect(await readRoutines(), isEmpty);
  });
}
