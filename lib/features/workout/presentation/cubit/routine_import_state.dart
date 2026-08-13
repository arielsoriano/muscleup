import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/import/routine_import_parser.dart';

part 'routine_import_state.freezed.dart';

@freezed
class RoutineImportState with _$RoutineImportState {
  const factory RoutineImportState({
    @Default('') String pastedText,

    /// The parsed routines waiting for the user to confirm. Null until the text
    /// has been checked, and cleared again on every edit so the preview can
    /// never describe text that is no longer in the field.
    RoutineImportResult? preview,
    RoutineImportFailure? failure,
    @Default(false) bool isChecking,
    @Default(false) bool isImporting,
    @Default(0) int importedCount,
    String? errorMessage,
  }) = _RoutineImportState;
}

extension RoutineImportStateX on RoutineImportState {
  bool get hasPreview => preview?.isSuccess ?? false;

  bool get isBusy => isChecking || isImporting;

  bool get didImport => importedCount > 0;

  int get previewRoutineCount => preview?.routines.length ?? 0;
}
