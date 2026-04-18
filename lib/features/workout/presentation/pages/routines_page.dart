import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../settings/presentation/cubit/sync_status_cubit.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/repositories/workout_repository.dart';
import '../cubit/workout_cubit.dart';
import '../cubit/workout_state.dart';

class RoutinesPage extends StatelessWidget {
  const RoutinesPage({
    this.onOpenRoutineDetails,
    this.onStartRoutine,
    this.returnToToday = false,
    super.key,
  });

  final Future<void> Function(BuildContext context, String routineId)?
      onOpenRoutineDetails;
  final Future<void> Function(
    BuildContext context,
    WorkoutRoutine routine, {
    String? sessionId,
  })? onStartRoutine;
  final bool returnToToday;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<WorkoutCubit>(),
      child: _RoutinesPageContent(
        onOpenRoutineDetails: onOpenRoutineDetails,
        onStartRoutine: onStartRoutine,
        returnToToday: returnToToday,
      ),
    );
  }
}

class _RoutinesPageContent extends StatelessWidget {
  const _RoutinesPageContent({
    this.onOpenRoutineDetails,
    this.onStartRoutine,
    this.returnToToday = false,
  });

  final Future<void> Function(BuildContext context, String routineId)?
      onOpenRoutineDetails;
  final Future<void> Function(
    BuildContext context,
    WorkoutRoutine routine, {
    String? sessionId,
  })? onStartRoutine;
  final bool returnToToday;

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
              // Show success message right after deletion
              context.showAppSnackBar(
                message: context.l10n.routineDeletedSuccess,
                type: SnackBarType.success,
              );
            },
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );
  }

  Future<void> _startRoutine(
    BuildContext context,
    WorkoutRoutine routine,
  ) async {
    final result = await serviceLocator<WorkoutRepository>()
        .getLatestActiveSessionForRoutine(routine.id);

    if (!context.mounted) return;

    result.fold(
      (_) {
        // No existing session - create new
        if (onStartRoutine != null) {
          onStartRoutine!(context, routine);
        } else {
          final baseExtra = <String, dynamic>{'routine': routine};
          if (returnToToday) {
            baseExtra['returnTo'] = 'today';
          }
          context.push(
            AppRoutes.activeWorkout,
            extra: baseExtra,
          );
        }
      },
      (activeSession) {
        if (activeSession != null) {
          // Existing session - show message and resume
          context.showAppSnackBar(
            message: context.l10n.routineAlreadyActive(routine.name),
            type: SnackBarType.info,
          );

          // Use callback with sessionId if available, else push directly
          if (onStartRoutine != null) {
            onStartRoutine!(context, routine, sessionId: activeSession.id);
          } else {
            context.push(
              AppRoutes.activeWorkout,
              extra: {
                'routine': routine,
                'sessionId': activeSession.id,
                if (returnToToday) 'returnTo': 'today',
              },
            );
          }
          return;
        }

        // No existing session found - create new (fallback)
        if (onStartRoutine != null) {
          onStartRoutine!(context, routine);
        } else {
          final baseExtra = <String, dynamic>{'routine': routine};
          if (returnToToday) {
            baseExtra['returnTo'] = 'today';
          }
          context.push(
            AppRoutes.activeWorkout,
            extra: baseExtra,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Center(child: AppLogo()),
        ),
        title: Text(context.l10n.routines),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (value) {
              if (value == 'settings') {
                context.push(AppRoutes.settings);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem<String>(
                value: 'settings',
                child: Row(
                  children: [
                    const Icon(Icons.settings_rounded),
                    const SizedBox(width: 12),
                    Text(context.l10n.settings),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          final isSyncing = context.select(
            (SyncStatusCubit cubit) => cubit.state.isSyncing,
          );

          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (routines) {
              if (routines.isEmpty) {
                if (isSyncing) {
                  return _SyncingRoutinesPlaceholder();
                }

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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.38)
                                  : null,
                            ),
                            onPressed: isEmptyRoutine
                                ? () {
                                    context.showAppSnackBar(
                                      message: context.l10n.addExercisesFirst,
                                      type: SnackBarType.info,
                                    );
                                  }
                                : () => _startRoutine(context, routine),
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
                      onTap: () async {
                        if (onOpenRoutineDetails != null) {
                          await onOpenRoutineDetails!(context, routine.id);
                          return;
                        }

                        context.push(
                          AppRoutes.routineDetailsPath(routine.id),
                        );
                      },
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
        heroTag: const ValueKey('fab-routines'),
        onPressed: () => context.push(AppRoutes.manageRoutine),
        icon: const Icon(Icons.add_rounded),
        label: Text(context.l10n.addRoutine),
      ),
    );
  }
}

class _SyncingRoutinesPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(strokeWidth: 2.5),
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.syncing,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.routinesSyncingPlaceholder,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
