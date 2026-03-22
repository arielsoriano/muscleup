import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/repositories/workout_repository.dart';
import '../../domain/usecases/get_routine_by_id_usecase.dart';

class WorkoutDetailsPage extends StatelessWidget {
  const WorkoutDetailsPage({
    required this.routineId,
    super.key,
  });

  final String routineId;

  Future<void> _startRoutine(
    BuildContext context,
    WorkoutRoutine routine,
  ) async {
    final result = await serviceLocator<WorkoutRepository>()
        .getLatestActiveSessionForRoutine(routine.id);

    if (!context.mounted) return;

    result.fold(
      (_) {
        context.push(
          AppRoutes.activeWorkout,
          extra: {'routine': routine},
        );
      },
      (activeSession) {
        if (activeSession != null) {
          context.showAppSnackBar(
            message: context.l10n.routineAlreadyActive(routine.name),
            type: SnackBarType.info,
          );

          context.push(
            AppRoutes.activeWorkout,
            extra: {
              'routine': routine,
              'sessionId': activeSession.id,
            },
          );
          return;
        }

        context.push(
          AppRoutes.activeWorkout,
          extra: {'routine': routine},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: serviceLocator<GetRoutineByIdUseCase>()(
        GetRoutineByIdParams(id: routineId),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text(context.l10n.routineDetailsTitle),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(context.l10n.routineDetailsTitle),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.errorLoading,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context.pop(),
                    child: Text(context.l10n.back),
                  ),
                ],
              ),
            ),
          );
        }

        return snapshot.data!.fold(
          (failure) => Scaffold(
            appBar: AppBar(
              title: Text(context.l10n.routineDetailsTitle),
            ),
            body: Center(
              child: Text(
                context.l10n.errorLoading,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            ),
          ),
          (routine) => Scaffold(
            appBar: AppBar(
              title: Text(routine.name),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit_rounded),
                  onPressed: () => context.push(
                    AppRoutes.editRoutinePath(routine.id),
                    extra: routine,
                  ),
                  tooltip: context.l10n.editRoutine,
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: routine.exercises.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.fitness_center_outlined,
                                  size: 64,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  context.l10n.noExercisesInRoutine,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: routine.exercises.length,
                          itemBuilder: (context, index) {
                            final exercise = routine.exercises[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ExpansionTile(
                                title: Text(
                                  exercise.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                subtitle: Text(
                                  '${exercise.templateSets.length} ${context.l10n.sets}',
                                ),
                                children: [
                                  if (exercise.notes != null &&
                                      exercise.notes!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surfaceContainerHighest
                                              .withValues(alpha: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outlineVariant,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              context.l10n.notes,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurfaceVariant,
                                                    fontWeight:
                                                        FontWeight.w700,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              exercise.notes!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (exercise.templateSets.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Column(
                                        children: exercise.templateSets
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          final setIndex = entry.key + 1;
                                          final set = entry.value;
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 8,
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      setIndex.toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                            color: Theme.of(
                                                                    context,)
                                                                .colorScheme
                                                                .onPrimaryContainer,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Builder(
                                                  builder: (context) {
                                                    final parts = <String>[];

                                                    if (set.unit1 != null &&
                                                        set.unit1 !=
                                                            WorkoutUnit.none) {
                                                      final value = set
                                                              .targetValue1
                                                              ?.formatClean() ??
                                                          '0';
                                                      final unit = _formatUnit(
                                                        set.unit1,
                                                      );
                                                      parts.add('$value $unit');
                                                    }

                                                    if (set.unit2 != null &&
                                                        set.unit2 !=
                                                            WorkoutUnit.none) {
                                                      final value = set
                                                              .targetValue2
                                                              ?.formatClean() ??
                                                          '0';
                                                      final unit = _formatUnit(
                                                        set.unit2,
                                                      );
                                                      parts.add('$value $unit');
                                                    }

                                                    return Text(
                                                      parts.isEmpty
                                                          ? '-'
                                                          : parts
                                                              .join(' \u00d7 '),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: FilledButton.tonal(
                      onPressed: routine.exercises.isEmpty
                          ? null
                          : () => _startRoutine(context, routine),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.play_arrow_rounded),
                          const SizedBox(width: 8),
                          Text(context.l10n.startRoutineName(routine.name)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
}
