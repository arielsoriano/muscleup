import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../settings/presentation/cubit/sync_status_cubit.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/repositories/workout_repository.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import 'routines_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  bool _returnToTodayAfterRoutineDetails = false;

  void _handleGoToToday() {
    setState(() {
      _currentIndex = 0;
      _returnToTodayAfterRoutineDetails = false;
    });
  }

  void _handleTabSelected(int index) {
    setState(() {
      _currentIndex = index;
      if (index != 1) {
        _returnToTodayAfterRoutineDetails = false;
      }
    });
  }

  Future<void> _handleOpenRoutineDetails(
    BuildContext context,
    String routineId,
  ) async {
    await context.push(AppRoutes.routineDetailsPath(routineId));

    if (!mounted) return;

    if (_returnToTodayAfterRoutineDetails) {
      setState(() {
        _currentIndex = 0;
        _returnToTodayAfterRoutineDetails = false;
      });
    }
  }

  Future<void> _handleStartRoutineFromRoutinesList(
    BuildContext context,
    WorkoutRoutine routine, {
    String? sessionId,
  }) async {
    await context.push(
      AppRoutes.activeWorkout,
      extra: {
        'routine': routine,
        if (sessionId != null) 'sessionId': sessionId,
        if (_returnToTodayAfterRoutineDetails) 'returnTo': 'today',
      },
    );

    if (!mounted) return;

    if (_returnToTodayAfterRoutineDetails) {
      setState(() {
        _currentIndex = 0;
        _returnToTodayAfterRoutineDetails = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<DashboardCubit>(),
      child: _ShellContent(
        currentIndex: _currentIndex,
        onTabSelected: _handleTabSelected,
        onGoToToday: _handleGoToToday,
        onOpenRoutineDetails: _handleOpenRoutineDetails,
        onStartRoutineFromList: _handleStartRoutineFromRoutinesList,
        returnToTodayAfterRoutineDetails: _returnToTodayAfterRoutineDetails,
      ),
    );
  }
}

class _ShellContent extends StatelessWidget {
  const _ShellContent({
    required this.currentIndex,
    required this.onTabSelected,
    required this.onGoToToday,
    required this.onOpenRoutineDetails,
    required this.onStartRoutineFromList,
    required this.returnToTodayAfterRoutineDetails,
  });

  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onGoToToday;
  final Future<void> Function(BuildContext context, String routineId)
      onOpenRoutineDetails;
  final Future<void> Function(
    BuildContext context,
    WorkoutRoutine routine, {
    String? sessionId,
  }) onStartRoutineFromList;
  final bool returnToTodayAfterRoutineDetails;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: colorScheme.primary,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colorScheme.onPrimary);
          }
          return IconThemeData(color: colorScheme.onSurfaceVariant);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final baseStyle = Theme.of(context).textTheme.labelMedium;
          if (states.contains(WidgetState.selected)) {
            return baseStyle?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
            );
          }
          return baseStyle?.copyWith(color: colorScheme.onSurfaceVariant);
        }),
      ),
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: [
            _TodayTab(
              onGoToToday: onGoToToday,
              onStartRoutine: onStartRoutineFromList,
            ),
            RoutinesPage(
              onGoToToday: onGoToToday,
              onOpenRoutineDetails: onOpenRoutineDetails,
              onStartRoutine: onStartRoutineFromList,
              returnToToday: returnToTodayAfterRoutineDetails,
            ),
            _HistoryTab(onGoToToday: onGoToToday),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          backgroundColor: colorScheme.surface,
          onDestinationSelected: onTabSelected,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.today_outlined),
              selectedIcon: const Icon(Icons.today_rounded),
              label: context.l10n.today,
            ),
            NavigationDestination(
              icon: const Icon(Icons.fitness_center_outlined),
              selectedIcon: const Icon(Icons.fitness_center_rounded),
              label: context.l10n.routines,
            ),
            NavigationDestination(
              icon: const Icon(Icons.history_outlined),
              selectedIcon: const Icon(Icons.history_rounded),
              label: context.l10n.history,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings_rounded),
      tooltip: context.l10n.settings,
      onPressed: () => context.push(AppRoutes.settings),
    );
  }
}

class _TodayTab extends StatelessWidget {
  const _TodayTab({
    required this.onGoToToday,
    required this.onStartRoutine,
  });

  final VoidCallback onGoToToday;
  final Future<void> Function(
    BuildContext context,
    WorkoutRoutine routine, {
    String? sessionId,
  }) onStartRoutine;

  Future<void> _startRoutine(
    BuildContext context,
    WorkoutRoutine routine,
  ) async {
    if (routine.exercises.isEmpty) {
      context.showAppSnackBar(
        message: context.l10n.addExercisesFirst,
        type: SnackBarType.info,
      );
      return;
    }

    final result = await serviceLocator<WorkoutRepository>()
        .getLatestActiveSessionForRoutine(routine.id);

    if (!context.mounted) return;

    result.fold(
      (_) => onStartRoutine(context, routine),
      (activeSession) {
        if (activeSession != null) {
          onStartRoutine(context, routine, sessionId: activeSession.id);
        } else {
          onStartRoutine(context, routine);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: _AppLogoLeadingButton(onTap: onGoToToday),
        ),
        title: Text(context.l10n.today),
        actions: const [_SettingsButton()],
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const Center(child: CircularProgressIndicator()),
            loading: (_) => const Center(child: CircularProgressIndicator()),
            success: (s) => _buildBody(context, s.activeSessions, s.routines),
            error: (s) => Center(
              child: Text(
                s.message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    List<WorkoutSession> activeSessions,
    List<WorkoutRoutine> routines,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (activeSessions.isEmpty && routines.isEmpty) {
      final isSyncing =
          context.select((SyncStatusCubit cubit) => cubit.state.isSyncing);

      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 48,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: isSyncing
                      ? [
                          const SizedBox(
                            width: 28,
                            height: 28,
                            child:
                                CircularProgressIndicator(strokeWidth: 2.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            context.l10n.syncing,
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ]
                      : [
                          Icon(
                            Icons.fitness_center_rounded,
                            size: 80,
                            color: colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.35),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            context.l10n.noRoutines,
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                ),
              ),
            ),
          );
        },
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        if (activeSessions.isNotEmpty) ...[
          _TodaySectionHeader(
            icon: Icons.play_circle_outline_rounded,
            label: context.l10n.inProgress,
          ),
          const SizedBox(height: 8),
          ...activeSessions.map(
            (session) => _ActiveSessionCard(session: session),
          ),
          const SizedBox(height: 16),
        ],
        if (routines.isNotEmpty) ...[
          _TodaySectionHeader(
            icon: Icons.fitness_center_rounded,
            label: context.l10n.startWorkout,
          ),
          const SizedBox(height: 8),
          ...routines.map(
            (routine) => _StartRoutineCard(
              routine: routine,
              onTap: () => _startRoutine(context, routine),
            ),
          ),
        ],
      ],
    );
  }
}

class _TodaySectionHeader extends StatelessWidget {
  const _TodaySectionHeader({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 18, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Text(
          label,
          style: textTheme.titleSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _StartRoutineCard extends StatelessWidget {
  const _StartRoutineCard({required this.routine, required this.onTap});

  final WorkoutRoutine routine;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isEmptyRoutine = routine.exercises.isEmpty;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: isEmptyRoutine
                      ? colorScheme.surfaceContainerHighest
                      : colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: isEmptyRoutine
                      ? colorScheme.onSurfaceVariant
                      : colorScheme.onPrimary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      routine.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isEmptyRoutine
                          ? context.l10n.emptyRoutine
                          : '${routine.exercises.length} ${context.l10n.exercises}',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActiveSessionCard extends StatelessWidget {
  const _ActiveSessionCard({required this.session});

  final WorkoutSession session;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).languageCode;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: colorScheme.primaryContainer.withValues(alpha: 0.35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.primary, width: 1.2),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(
          AppRoutes.activeWorkout,
          extra: {
            'routineId': session.routineId,
            'sessionId': session.id,
          },
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: colorScheme.onPrimary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.inProgress,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      session.routineName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat.yMMMd(locale).add_jm().format(session.createdAt),
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _confirmDelete(context),
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final accepted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(context.l10n.delete),
          content: Text(context.l10n.deleteSessionConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(context.l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(context.l10n.delete),
            ),
          ],
        );
      },
    );

    if (accepted != true || !context.mounted) {
      return;
    }

    await context.read<DashboardCubit>().deleteSession(session.id);
    if (!context.mounted) {
      return;
    }

    context.showAppSnackBar(
      message: context.l10n.sessionDeleted,
      type: SnackBarType.success,
    );
  }
}

class _HistoryTab extends StatelessWidget {
  const _HistoryTab({required this.onGoToToday});

  final VoidCallback onGoToToday;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: _AppLogoLeadingButton(onTap: onGoToToday),
        ),
        title: Text(context.l10n.history),
        actions: const [_SettingsButton()],
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const Center(child: CircularProgressIndicator()),
            loading: (_) => const Center(child: CircularProgressIndicator()),
            success: (s) => _buildHistory(
              context,
              completedSessions: s.allCompletedSessions,
            ),
            error: (s) => Center(
              child: Text(
                s.message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHistory(
    BuildContext context, {
    required List<WorkoutSession> completedSessions,
  }) {
    if (completedSessions.isEmpty) {
      return _buildEmptyState(context);
    }

    // completedSessions arrive sorted by date descending. Build a flat list
    // with a lightweight date header whenever the day changes, so the user
    // can scroll back through their whole training history.
    final locale = Localizations.localeOf(context).languageCode;
    final items = <Widget>[];
    DateTime? lastHeaderDay;

    for (final session in completedSessions) {
      final day = DateTime(
        session.createdAt.year,
        session.createdAt.month,
        session.createdAt.day,
      );

      if (lastHeaderDay == null || !_isSameDay(day, lastHeaderDay)) {
        items.add(_buildDayHeader(context, day, locale));
        lastHeaderDay = day;
      }

      items.add(_buildSessionCard(context, session));
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: items,
    );
  }

  Widget _buildDayHeader(BuildContext context, DateTime day, String locale) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 8),
      child: Text(
        DateFormat.yMMMMEEEEd(locale).format(day),
        style: textTheme.labelLarge?.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy_rounded,
              size: 72,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.noWorkoutToday,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionCard(BuildContext context, WorkoutSession session) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).languageCode;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.check_rounded,
            color: colorScheme.primary,
          ),
        ),
        title: Text(
          session.routineName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(DateFormat.yMMMd(locale).add_jm().format(session.createdAt)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _confirmDeleteSession(context, session.id),
              icon: Icon(
                Icons.delete_outline_rounded,
                color: colorScheme.error,
              ),
              tooltip: context.l10n.delete,
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
        onTap: () {
          context.push(
            AppRoutes.activeWorkout,
            extra: {
              'routineId': session.routineId,
              'sessionId': session.id,
            },
          );
        },
      ),
    );
  }

  Future<void> _confirmDeleteSession(BuildContext context, String sessionId) async {
    final accepted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(context.l10n.delete),
          content: Text(context.l10n.deleteSessionConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(context.l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(context.l10n.delete),
            ),
          ],
        );
      },
    );

    if (accepted != true || !context.mounted) {
      return;
    }

    await context.read<DashboardCubit>().deleteSession(sessionId);
    if (!context.mounted) {
      return;
    }

    context.showAppSnackBar(
      message: context.l10n.sessionDeleted,
      type: SnackBarType.success,
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

class _AppLogoLeadingButton extends StatelessWidget {
  const _AppLogoLeadingButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: context.l10n.today,
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      splashRadius: 22,
      onPressed: onTap,
      icon: const AppLogo(),
    );
  }
}
