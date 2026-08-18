import 'package:freezed_annotation/freezed_annotation.dart';

part 'routine_export_state.freezed.dart';

@freezed
class RoutineExportState with _$RoutineExportState {
  const factory RoutineExportState({
    @Default(true) bool isLoading,

    /// The serialized routines, ready to be copied. Empty while loading, and
    /// also when the user has no routines at all.
    @Default('') String json,
    @Default(0) int routineCount,
    @Default(0) int exerciseCount,
    @Default(0) int setCount,
    String? errorMessage,
  }) = _RoutineExportState;
}

extension RoutineExportStateX on RoutineExportState {
  bool get hasExport => !isLoading && routineCount > 0 && json.isNotEmpty;

  bool get isEmpty => !isLoading && errorMessage == null && routineCount == 0;
}
