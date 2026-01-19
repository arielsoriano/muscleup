import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/usecases/get_routine_by_id_usecase.dart';

class WorkoutDetailsPage extends StatelessWidget {
  const WorkoutDetailsPage({
    required this.routineId,
    super.key,
  });

  final String routineId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: serviceLocator<GetRoutineByIdUseCase>()(GetRoutineByIdParams(id: routineId)),
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
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  context.l10n.noExercisesInRoutine,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                subtitle: Text(
                                  '${exercise.templateSets.length} ${context.l10n.sets}',
                                ),
                                children: [
                                  if (exercise.notes != null && exercise.notes!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        exercise.notes!,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ),
                                  if (exercise.templateSets.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Column(
                                        children: exercise.templateSets.asMap().entries.map((entry) {
                                          final setIndex = entry.key + 1;
                                          final set = entry.value;
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 8),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).colorScheme.primaryContainer,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      setIndex.toString(),
                                                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Text(
                                                  '${set.targetValue1?.toString() ?? '0'} ${_formatUnit(set.unit1)} × ${set.targetValue2?.toString() ?? '0'} ${_formatUnit(set.unit2)}',
                                                  style: Theme.of(context).textTheme.bodyLarge,
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
                    child: FilledButton(
                      onPressed: () => context.push(
                        AppRoutes.activeWorkout,
                        extra: routine,
                      ),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.play_arrow_rounded),
                          const SizedBox(width: 8),
                          Text(context.l10n.startWorkout),
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
