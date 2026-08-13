import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../settings/data/training_defaults_repository.dart';
import '../../data/import/routine_import_parser.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/repositories/workout_repository.dart';
import '../../domain/usecases/save_routine_usecase.dart';
import 'routine_import_state.dart';

/// Drives the paste-a-workout screen: check what was pasted, show what it would
/// create, then write it.
///
/// The check is deliberately a separate step from the write. An import can
/// create a dozen routines at once, and the preview is the only chance the user
/// gets to notice that the assistant mangled something before it lands in their
/// library.
class RoutineImportCubit extends Cubit<RoutineImportState> {
  RoutineImportCubit({
    required SaveRoutineUseCase saveRoutineUseCase,
    required WorkoutRepository repository,
    required TrainingDefaultsRepository trainingDefaultsRepository,
    RoutineImportParser? parser,
  })  : _saveRoutineUseCase = saveRoutineUseCase,
        _repository = repository,
        _trainingDefaultsRepository = trainingDefaultsRepository,
        _parser = parser ?? RoutineImportParser(),
        super(const RoutineImportState());

  final SaveRoutineUseCase _saveRoutineUseCase;
  final WorkoutRepository _repository;
  final TrainingDefaultsRepository _trainingDefaultsRepository;
  final RoutineImportParser _parser;

  void updatePastedText(String text) {
    emit(
      state.copyWith(
        pastedText: text,
        preview: null,
        failure: null,
        errorMessage: null,
      ),
    );
  }

  void clear() {
    emit(const RoutineImportState());
  }

  Future<void> check() async {
    if (state.isBusy) return;

    emit(
      state.copyWith(
        isChecking: true,
        preview: null,
        failure: null,
        errorMessage: null,
      ),
    );

    final defaults = await _trainingDefaultsRepository.getLocalDefaults();
    final existing = await _existingRoutines();

    final result = _parser.parse(
      state.pastedText,
      defaults: RoutineImportDefaults(
        restSeconds: defaults.defaultRestSeconds ?? 0,
        repetitions: defaults.defaultRepetitions,
      ),
      existingRoutineNames: existing.map((routine) => routine.name).toSet(),
      // Imported routines are appended, so an import never reshuffles the list
      // the user already has.
      startSortOrder: existing.fold<int>(
            -1,
            (highest, routine) =>
                routine.sortOrder > highest ? routine.sortOrder : highest,
          ) +
          1,
    );

    emit(
      state.copyWith(
        isChecking: false,
        preview: result.failure == null ? result : null,
        failure: result.failure,
      ),
    );
  }

  Future<void> importPreviewed() async {
    final preview = state.preview;
    if (preview == null || !preview.isSuccess || state.isBusy) return;

    emit(state.copyWith(isImporting: true, errorMessage: null));

    var imported = 0;
    for (final routine in preview.routines) {
      final result = await _saveRoutineUseCase(
        SaveRoutineParams(routine: routine),
      );

      final failure = result.fold<Failure?>((failure) => failure, (_) => null);
      if (failure != null) {
        emit(
          state.copyWith(
            isImporting: false,
            errorMessage: _mapFailureToMessage(failure),
          ),
        );
        return;
      }

      imported++;
    }

    await _rememberCustomExercises(preview.routines);

    emit(state.copyWith(isImporting: false, importedCount: imported));
  }

  Future<List<WorkoutRoutine>> _existingRoutines() async {
    try {
      final result = await _repository.watchRoutines().first;
      return result.fold((_) => const <WorkoutRoutine>[], (routines) => routines);
    } catch (_) {
      // Only feeds sort order and the duplicate-name warning; neither is worth
      // failing an import over.
      return const <WorkoutRoutine>[];
    }
  }

  /// Files the exercises the user invented under their own library, so they can
  /// be picked again when editing a routine by hand.
  ///
  /// Catalog exercises are skipped — they are seeded already. The awaits are
  /// sequential and the names deduplicated on purpose: `saveLibraryExercise`
  /// decides whether a name is new by reading the table, so firing several
  /// calls for the same name at once would insert it more than once.
  Future<void> _rememberCustomExercises(List<WorkoutRoutine> routines) async {
    final seen = <String>{};
    for (final routine in routines) {
      for (final exercise in routine.exercises) {
        if (exercise.canonicalName != null) continue;
        if (!seen.add(exercise.name.trim().toLowerCase())) continue;
        await _repository.saveLibraryExercise(exercise.name);
      }
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is DatabaseFailure) {
      return failure.message;
    } else if (failure is UnexpectedFailure) {
      return failure.message;
    }
    return 'An unexpected error occurred';
  }
}
