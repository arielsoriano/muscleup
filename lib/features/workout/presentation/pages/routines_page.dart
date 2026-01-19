import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../cubit/workout_cubit.dart';
import '../cubit/workout_state.dart';

class RoutinesPage extends StatelessWidget {
  const RoutinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<WorkoutCubit>(),
      child: const _RoutinesPageContent(),
    );
  }
}

class _RoutinesPageContent extends StatelessWidget {
  const _RoutinesPageContent();

  void _showDeleteDialog(BuildContext context, String routineId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.delete),
        content: Text(context.l10n.deleteRoutineConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              context.read<WorkoutCubit>().deleteRoutine(routineId);
              Navigator.of(dialogContext).pop();
            },
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.routines),
      ),
      body: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (routines) {
              if (routines.isEmpty) {
                return Center(
                  child: Text(
                    context.l10n.noRoutines,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }
              
              return ListView.builder(
                itemCount: routines.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final routine = routines[index];
                  final isEmptyRoutine = routine.exercises.isEmpty;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(child: Text(routine.name)),
                          if (isEmptyRoutine)
                            Chip(
                              label: Text(
                                context.l10n.emptyRoutine,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              visualDensity: VisualDensity.compact,
                            ),
                        ],
                      ),
                      subtitle: Text(
                        '${routine.exercises.length} ${context.l10n.exercises}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.play_arrow_rounded,
                              color: isEmptyRoutine
                                  ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38)
                                  : null,
                            ),
                            onPressed: isEmptyRoutine
                                ? () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(context.l10n.addExercisesFirst),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                : () => context.push(
                                      AppRoutes.activeWorkout,
                                      extra: routine,
                                    ),
                            tooltip: context.l10n.startWorkout,
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded),
                            onPressed: () => _showDeleteDialog(
                              context,
                              routine.id,
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                      onTap: () => context.push(
                        AppRoutes.routineDetailsPath(routine.id),
                      ),
                    ),
                  );
                },
              );
            },
            error: (message) => Center(
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
                    onPressed: () => context.read<WorkoutCubit>(),
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.manageRoutine),
        icon: const Icon(Icons.add_rounded),
        label: Text(context.l10n.addRoutine),
      ),
    );
  }
}
