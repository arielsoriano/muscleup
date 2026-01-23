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
          context.showAppSnackBar(context.l10n.workoutSavedSuccess);
          context.pop();
        } else if (state is ActiveWorkoutStateError) {
          final translatedMessage = _translateErrorMessage(context, state.message);
          context.showAppSnackBar(translatedMessage, isError: true);
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
        final isResting = state.maybeMap(
          tracking: (s) => s.isResting,
          initial: (s) => s.isResting,
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
            body: isSaving || isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildWorkoutContent(context, state),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isResting)
                  _buildRestTimerOverlay(context, state),
                if (!isSaving && !isLoading && !isViewingHistory)
                  _buildFinishButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRestTimerOverlay(
      BuildContext context, ActiveWorkoutState state,) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final restTimerSeconds = state.maybeMap(
      tracking: (s) => s.restTimerSeconds,
      initial: (s) => s.restTimerSeconds,
      orElse: () => null,
    );

    final totalRestTime = state.maybeMap(
      tracking: (s) => s.totalRestTime,
      initial: (s) => s.totalRestTime,
      orElse: () => null,
    );

    if (restTimerSeconds == null || totalRestTime == null) {
      return const SizedBox.shrink();
    }

    final progress = totalRestTime > 0
        ? (totalRestTime - restTimerSeconds) / totalRestTime
        : 0.0;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.resting,
                              style: textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${restTimerSeconds}s',
                              style: textTheme.headlineMedium?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FilledButton.tonal(
                        onPressed: () =>
                            context.read<ActiveWorkoutCubit>().add30Seconds(),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12,),
                        ),
                        child: Text(context.l10n.add30Seconds),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () =>
                            context.read<ActiveWorkoutCubit>().stopRestTimer(),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12,),
                        ),
                        child: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                ),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 4,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(colorScheme.primary),
                ),
              ],
            ),
          ),
        ),
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
    return state.maybeMap(
      tracking: (s) => _buildExerciseList(
        context,
        s.routine,
        s.setLogs,
      ),
      initial: (s) => _buildExerciseList(
        context,
        s.routine,
        s.setLogs,
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildExerciseList(
    BuildContext context,
    WorkoutRoutine routine,
    List<SetLog> setLogs,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: routine.exercises.length,
      itemBuilder: (context, index) {
        final exercise = routine.exercises[index];
        final exerciseLogs = setLogs
            .where((log) => log.workoutExerciseId == exercise.id)
            .toList();

        return _buildExerciseSection(context, exercise, exerciseLogs);
      },
    );
  }

  Widget _buildExerciseSection(
    BuildContext context,
    WorkoutExercise exercise,
    List<SetLog> exerciseLogs,
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
              Text(
                exercise.notes!,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
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
                return _buildSetRow(context, entry.value, entry.key);
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildSetRow(BuildContext context, SetLog log, int index) {
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
                  _formatTargetValues(context, log),
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
                          onChanged: (value) {
                            final updatedLog = log.copyWith(
                              actualValue1: double.tryParse(value),
                            );
                            cubit.updateSetLog(updatedLog);
                          },
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
                          onChanged: (value) {
                            final updatedLog = log.copyWith(
                              actualValue2: double.tryParse(value),
                            );
                            cubit.updateSetLog(updatedLog);
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
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
    bool isFirstValue, {
    required ValueChanged<String> onChanged,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final unit = isFirstValue ? log.unit1 : log.unit2;
    final value = isFirstValue ? log.actualValue1 : log.actualValue2;

    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textAlign: TextAlign.center,
      style: textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: value?.formatClean() ?? '0',
        suffixText: _formatUnit(unit),
        suffixStyle: textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      onChanged: onChanged,
    );
  }

  String _formatTargetValues(BuildContext context, SetLog log) {
    final parts = <String>[];

    if (log.unit1 != null && log.unit1 != WorkoutUnit.none) {
      final value = log.actualValue1?.formatClean() ?? '0';
      final unit = _formatUnit(log.unit1);
      parts.add('$value$unit');
    }

    if (log.unit2 != null && log.unit2 != WorkoutUnit.none) {
      final value = log.actualValue2?.formatClean() ?? '0';
      final unit = _formatUnit(log.unit2);
      parts.add('$value$unit');
    }

    if (parts.isEmpty) {
      return context.l10n.target;
    }

    return '${context.l10n.target}: ${parts.join(' × ')}';
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
    }
  }

  Future<void> _showFinishConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.finishWorkout),
        content: Text(context.l10n.workoutSavedSuccess),
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
