import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/usecases/get_routine_by_id_usecase.dart';
import '../cubit/active_workout_cubit.dart';
import '../cubit/active_workout_state.dart';

class _SetEditorResult {
  const _SetEditorResult({
    required this.value,
    required this.saveAsTarget,
  });

  final double? value;
  final bool saveAsTarget;
}

class ActiveWorkoutPage extends StatelessWidget {
  const ActiveWorkoutPage({
    this.routine,
    this.routineId,
    this.sessionId,
    super.key,
  });

  final WorkoutRoutine? routine;
  final String? routineId;
  final String? sessionId;

  @override
  Widget build(BuildContext context) {
    if (routine != null) {
      return _buildWithRoutine(routine!);
    } else if (routineId != null) {
      return FutureBuilder(
        future: serviceLocator<GetRoutineByIdUseCase>()(
          GetRoutineByIdParams(id: routineId!),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(title: Text(context.l10n.activeWorkoutTitle)),
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(title: Text(context.l10n.activeWorkoutTitle)),
              body: Center(
                child: Text(
                  context.l10n.errorLoading,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ),
            );
          }

          return snapshot.data!.fold(
            (failure) => Scaffold(
              appBar: AppBar(title: Text(context.l10n.activeWorkoutTitle)),
              body: Center(
                child: Text(
                  context.l10n.errorLoading,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ),
            ),
            (loadedRoutine) => _buildWithRoutine(loadedRoutine),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.activeWorkoutTitle)),
      body: Center(
        child: Text(
          context.l10n.errorLoading,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  Widget _buildWithRoutine(WorkoutRoutine routine) {
    return BlocProvider(
      create: (context) => serviceLocator.get<ActiveWorkoutCubit>(
        param1: routine,
        param2: sessionId,
      ),
      child: const _ActiveWorkoutPageContent(),
    );
  }
}

class _ActiveWorkoutPageContent extends StatelessWidget {
  const _ActiveWorkoutPageContent();

  String _translateErrorMessage(BuildContext context, String messageKey) {
    switch (messageKey) {
      case 'error.noLogsFound':
        return context.l10n.noLogsFound;
      case 'error.noExercises':
        return context.l10n.noExercisesInRoutine;
      default:
        return messageKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActiveWorkoutCubit, ActiveWorkoutState>(
      listener: (context, state) {
        if (state is ActiveWorkoutStateSuccess) {
          context.showAppSnackBar(
            message: context.l10n.workoutSavedSuccess,
            type: SnackBarType.success,
          );
          context.pop();
        } else if (state is ActiveWorkoutStateError) {
          final translatedMessage =
              _translateErrorMessage(context, state.message);
          context.showAppSnackBar(
            message: translatedMessage,
            type: SnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        final isSaving = state is ActiveWorkoutStateSaving;
        final isLoading = state is ActiveWorkoutStateLoading;
        final isViewingHistory = state.maybeMap(
          tracking: (s) => s.isViewingHistory,
          initial: (s) => s.isViewingHistory,
          error: (s) => s.isViewingHistory,
          success: (s) => s.isViewingHistory,
          saving: (s) => s.isViewingHistory,
          orElse: () => false,
        );
        final displayTitle = state.maybeMap(
          tracking: (s) => s.displayTitle,
          initial: (s) => s.displayTitle,
          error: (s) => s.displayTitle,
          success: (s) => s.displayTitle,
          saving: (s) => s.displayTitle,
          orElse: () => null,
        );

        return PopScope(
          canPop: !isSaving,
          child: Scaffold(
            appBar: AppBar(
              title: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 250),
                child: Text(
                  displayTitle ?? state.routine.name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            body: Column(
              children: [
                if (isViewingHistory) _buildCompletedSessionBanner(context),
                Expanded(
                  child: isSaving || isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _buildWorkoutContent(context, state),
                ),
              ],
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!isSaving && !isLoading && !isViewingHistory)
                  _buildFinishButton(context),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildCompletedSessionBanner(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
        border: Border(
          bottom: BorderSide(
            color: colorScheme.primary.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.done_all_rounded,
            size: 20,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(
            context.l10n.completedSession,
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinishButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: FilledButton.icon(
            onPressed: () => _showFinishConfirmation(context),
            icon: const Icon(Icons.check_circle_outline_rounded),
            label: Text(context.l10n.finishWorkout),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutContent(BuildContext context, ActiveWorkoutState state) {
    final isViewingHistory = state.maybeMap(
      tracking: (s) => s.isViewingHistory,
      initial: (s) => s.isViewingHistory,
      orElse: () => false,
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: state.maybeMap(
        tracking: (s) => _buildExerciseList(
          context,
          s.routine,
          s.setLogs,
          isViewingHistory,
        ),
        initial: (s) => _buildExerciseList(
          context,
          s.routine,
          s.setLogs,
          isViewingHistory,
        ),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildExerciseList(
    BuildContext context,
    WorkoutRoutine routine,
    List<SetLog> setLogs,
    bool isViewingHistory,
  ) {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.all(16),
      itemCount: routine.exercises.length,
      itemBuilder: (context, index) {
        final exercise = routine.exercises[index];
        final exerciseLogs = setLogs
            .where((log) => log.workoutExerciseId == exercise.id)
            .toList();

        return _buildExerciseSection(
            context, exercise, exerciseLogs, isViewingHistory,);
      },
    );
  }

  Widget _buildExerciseSection(
    BuildContext context,
    WorkoutExercise exercise,
    List<SetLog> exerciseLogs,
    bool isViewingHistory,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    exercise.name,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (exercise.restTimeSeconds > 0)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => context
                          .read<ActiveWorkoutCubit>()
                          .startRestTimer(exercise.restTimeSeconds),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer
                              .withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: colorScheme.primary.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${exercise.restTimeSeconds}s',
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (exercise.notes != null && exercise.notes!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: colorScheme.outlineVariant,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.notes,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exercise.notes!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            if (exerciseLogs.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    context.l10n.noSetsDefined,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              )
            else
              ...exerciseLogs.asMap().entries.map((entry) {
                final templateSetIndex = entry.value.setNumber - 1;
                final templateSet = templateSetIndex >= 0 &&
                        templateSetIndex < exercise.templateSets.length
                    ? exercise.templateSets[templateSetIndex]
                    : null;
                return _buildSetRow(
                  context,
                  entry.value,
                  entry.key,
                  isViewingHistory,
                  templateSet: templateSet,
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildSetRow(
    BuildContext context,
    SetLog log,
    int index,
    bool isViewingHistory, {
    WorkoutSet? templateSet,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<ActiveWorkoutCubit>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: log.isCompleted
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: textTheme.labelLarge?.copyWith(
                  color: log.isCompleted
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatTargetValues(context, templateSet, log),
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (log.unit1 != null && log.unit1 != WorkoutUnit.none) ...[
                      Expanded(
                        child: _buildValueInput(
                          context,
                          log,
                          true,
                          isViewingHistory,
                          targetValue: templateSet?.targetValue1,
                        ),
                      ),
                      if (log.unit2 != null && log.unit2 != WorkoutUnit.none)
                        const SizedBox(width: 8),
                    ],
                    if (log.unit2 != null && log.unit2 != WorkoutUnit.none) ...[
                      Expanded(
                        child: _buildValueInput(
                          context,
                          log,
                          false,
                          isViewingHistory,
                          targetValue: templateSet?.targetValue2,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (!isViewingHistory)
            IconButton(
              onPressed: () {
                final updatedLog = log.copyWith(isCompleted: !log.isCompleted);
                cubit.updateSetLog(updatedLog);
              },
              icon: Icon(
                log.isCompleted
                    ? Icons.check_circle_rounded
                    : Icons.check_circle_outline_rounded,
                color: log.isCompleted
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildValueInput(
    BuildContext context,
    SetLog log,
    bool isFirstValue,
    bool isViewingHistory, {
    required double? targetValue,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<ActiveWorkoutCubit>();
    final unit = isFirstValue ? log.unit1 : log.unit2;
    final value = isFirstValue ? log.actualValue1 : log.actualValue2;
    final effectiveValue = value ?? targetValue;
    final unitText = _formatUnit(unit);
    final valueText = effectiveValue?.formatClean() ?? '-';

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: isViewingHistory
          ? null
          : () async {
              FocusScope.of(context).unfocus();
              final selectedAction = await _showSetValueEditorSheet(
                context,
                initialValue: value,
                targetValue: targetValue,
                unitText: unitText,
              );

              if (!context.mounted || selectedAction == null) {
                return;
              }

              final updatedLog = isFirstValue
                  ? log.copyWith(actualValue1: selectedAction.value)
                  : log.copyWith(actualValue2: selectedAction.value);

              cubit.updateSetLog(updatedLog);

              if (selectedAction.saveAsTarget) {
                final message = await cubit.saveSetAsRoutineTarget(updatedLog);
                if (!context.mounted) {
                  return;
                }

                if (message == null) {
                  context.showAppSnackBar(
                    message: context.l10n.saveAsRoutineTargetSuccess,
                  );
                } else {
                  context.showAppSnackBar(
                    message: _translateActiveWorkoutMessage(context, message),
                    type: SnackBarType.error,
                  );
                }
              }
            },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text(
                  valueText,
                  maxLines: 1,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            if (unitText.isNotEmpty) ...[
              const SizedBox(width: 6),
              Text(
                unitText,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<_SetEditorResult?> _showSetValueEditorSheet(
    BuildContext context, {
    required double? initialValue,
    required double? targetValue,
    required String unitText,
  }) async {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    var draftValueText = initialValue?.formatClean() ?? '';

    final result = await showModalBottomSheet<_SetEditorResult>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            8,
            16,
            MediaQuery.of(sheetContext).viewInsets.bottom + 16,
          ),
          child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.editSetValue,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${context.l10n.target}: ${targetValue?.formatClean() ?? '-'}$unitText',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    initialValue: draftValueText,
                    autofocus: true,
                    onTapOutside: (_) => FocusScope.of(sheetContext).unfocus(),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: targetValue?.formatClean() ?? '',
                      suffixText: unitText,
                    ),
                    onChanged: (value) {
                      draftValueText = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    leading: Icon(
                      Icons.check_circle_outline,
                      color: colorScheme.primary,
                    ),
                    title: Text(context.l10n.saveForToday),
                    subtitle: Text(context.l10n.saveForTodayDetail),
                    onTap: () {
                      final parsed = _parseSetValue(draftValueText);
                      Navigator.of(sheetContext).pop(
                        _SetEditorResult(
                          value: parsed,
                          saveAsTarget: false,
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    leading: Icon(
                      Icons.flag_outlined,
                      color: colorScheme.tertiary,
                    ),
                    title: Text(context.l10n.updateRoutineTarget),
                    subtitle: Text(context.l10n.updateRoutineTargetDetail),
                    onTap: () {
                      final parsed = _parseSetValue(draftValueText);
                      Navigator.of(sheetContext).pop(
                        _SetEditorResult(
                          value: parsed,
                          saveAsTarget: true,
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                ],
              ),
            );
      },
    );
    return result;
  }

  double? _parseSetValue(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      return null;
    }

    return double.tryParse(trimmed.replaceAll(',', '.'));
  }

  String _formatTargetValues(
    BuildContext context,
    WorkoutSet? templateSet,
    SetLog log,
  ) {
    final parts = <String>[];

    final targetValue1 = templateSet?.targetValue1 ?? log.actualValue1;
    final targetValue2 = templateSet?.targetValue2 ?? log.actualValue2;
    final targetUnit1 = templateSet?.unit1 ?? log.unit1;
    final targetUnit2 = templateSet?.unit2 ?? log.unit2;

    if (targetUnit1 != null && targetUnit1 != WorkoutUnit.none) {
      final value = targetValue1?.formatClean() ?? '0';
      final unit = _formatUnit(targetUnit1);
      parts.add('$value$unit');
    }

    if (targetUnit2 != null && targetUnit2 != WorkoutUnit.none) {
      final value = targetValue2?.formatClean() ?? '0';
      final unit = _formatUnit(targetUnit2);
      parts.add('$value$unit');
    }

    if (parts.isEmpty) {
      return context.l10n.target;
    }

    return '${context.l10n.target}: ${parts.join(' × ')}';
  }

  String _translateActiveWorkoutMessage(BuildContext context, String message) {
    switch (message) {
      case 'error.cannotUpdateHistoryTarget':
      case 'error.targetExerciseNotFound':
      case 'error.targetSetNotFound':
      case 'error.targetRoutineUnavailable':
        return context.l10n.saveAsRoutineTargetError;
      default:
        return message;
    }
  }

  String _formatUnit(WorkoutUnit? unit) {
    if (unit == null) return '';

    switch (unit) {
      case WorkoutUnit.kilograms:
        return 'kg';
      case WorkoutUnit.pounds:
        return 'lb';
      case WorkoutUnit.repetitions:
        return 'reps';
      case WorkoutUnit.seconds:
        return 's';
      case WorkoutUnit.minutes:
        return 'min';
      case WorkoutUnit.kilometers:
        return 'km';
      case WorkoutUnit.meters:
        return 'm';
      case WorkoutUnit.none:
        return '';
      case WorkoutUnit.level:
        return 'level';
      case WorkoutUnit.incline:
        return 'incline';
    }
  }

  Future<void> _showFinishConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.finishWorkout),
        content: Text(context.l10n.finishWorkoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(context.l10n.save),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<ActiveWorkoutCubit>().finishWorkout();
    }
  }
}
