import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/export/routine_export_serializer.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/repositories/workout_repository.dart';
import 'routine_export_state.dart';

/// Builds the JSON copy of everything the user has, for the export screen.
///
/// Read-only: it never writes to the database, so there is nothing here to
/// undo and no reason to make the user confirm anything. That is the whole
/// difference in shape from [RoutineImportCubit], which has to preview before
/// it commits.
class RoutineExportCubit extends Cubit<RoutineExportState> {
  RoutineExportCubit({
    required WorkoutRepository repository,
    RoutineExportSerializer serializer = const RoutineExportSerializer(),
  })  : _repository = repository,
        _serializer = serializer,
        super(const RoutineExportState());

  final WorkoutRepository _repository;
  final RoutineExportSerializer _serializer;

  /// [languageCode] decides how catalog exercises are spelled in the output.
  /// The import recovers the catalog link from the name whatever language it
  /// is in, so this only affects how the file reads, never what it restores.
  Future<void> load(String languageCode) async {
    emit(const RoutineExportState());

    try {
      final result = await _repository.watchRoutines().first;

      final routines = result.fold<List<WorkoutRoutine>?>(
        (_) => null,
        (routines) => routines,
      );

      if (routines == null) {
        emit(
          const RoutineExportState(isLoading: false, errorMessage: 'load-failed'),
        );
        return;
      }

      emit(
        RoutineExportState(
          isLoading: false,
          json: _serializer.serialize(routines, languageCode: languageCode),
          routineCount: routines.length,
          exerciseCount: routines.fold(
            0,
            (total, routine) => total + routine.exercises.length,
          ),
          setCount: routines.fold(
            0,
            (total, routine) =>
                total +
                routine.exercises.fold<int>(
                  0,
                  (subtotal, exercise) =>
                      subtotal + exercise.templateSets.length,
                ),
          ),
        ),
      );
    } catch (_) {
      emit(
        const RoutineExportState(isLoading: false, errorMessage: 'load-failed'),
      );
    }
  }
}
