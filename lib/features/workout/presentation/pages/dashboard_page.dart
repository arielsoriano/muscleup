import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../domain/entities/workout_entities.dart';
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

  void _handleTabSelected(int index) {
    setState(() {
      _currentIndex = index;
      if (index != 1) {
        _returnToTodayAfterRoutineDetails = false;
      }
    });
  }

  void _handleGoToRoutinesFromToday() {
    setState(() {
      _currentIndex = 1;
      _returnToTodayAfterRoutineDetails = true;
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
        onGoToRoutinesFromToday: _handleGoToRoutinesFromToday,
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
    required this.onGoToRoutinesFromToday,
    required this.onOpenRoutineDetails,
    required this.onStartRoutineFromList,
    required this.returnToTodayAfterRoutineDetails,
  });

  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onGoToRoutinesFromToday;
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
        indicatorColor: colorScheme.primaryContainer,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colorScheme.onPrimaryContainer);
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
            _TodayTab(onGoToRoutines: onGoToRoutinesFromToday),
            RoutinesPage(
              onOpenRoutineDetails: onOpenRoutineDetails,
              onStartRoutine: onStartRoutineFromList,
              returnToToday: returnToTodayAfterRoutineDetails,
            ),
            const _HistoryTab(),
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

class _DashboardTopMenu extends StatelessWidget {
  const _DashboardTopMenu();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert_rounded),
      onSelected: (value) {
        final currentLocale = Localizations.localeOf(context);
        if (value == 'language') {
          final newLanguageCode =
              currentLocale.languageCode == 'en' ? 'es' : 'en';
          context.read<SettingsCubit>().changeLanguage(newLanguageCode);
        } else if (value == 'appSkin') {
          _showSkinSelector(context);
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem<String>(
          value: 'appSkin',
          child: Row(
            children: [
              const Icon(Icons.palette_rounded),
              const SizedBox(width: 12),
              Text(context.l10n.appSkin),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'language',
          child: Row(
            children: [
              const Icon(Icons.language_rounded),
              const SizedBox(width: 12),
              Text(context.l10n.language),
            ],
          ),
        ),
      ],
    );
  }

  void _showSkinSelector(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    final currentSkin = settingsCubit.state.currentSkin;

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusLarge),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 24.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  context.l10n.selectSkin,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              ...AppSkin.values.map((skin) {
                final isSelected = skin == currentSkin;
                return ListTile(
                  onTap: () {
                    settingsCubit.changeSkin(skin);
                    Navigator.of(context).pop();
                  },
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: skin.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .outline
                            .withValues(alpha: 0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: skin.primaryColor.withValues(alpha: 0.4),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    _getSkinLocalizedName(context, skin),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: skin.primaryColor,
                          size: 28,
                        )
                      : Icon(
                          Icons.circle_outlined,
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 0.3),
                          size: 28,
                        ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor:
                      isSelected ? skin.primaryColor.withValues(alpha: 0.1) : null,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  String _getSkinLocalizedName(BuildContext context, AppSkin skin) {
    switch (skin) {
      case AppSkin.volt:
        return context.l10n.skinVolt;
      case AppSkin.cyan:
        return context.l10n.skinCyan;
      case AppSkin.crimson:
        return context.l10n.skinCrimson;
      case AppSkin.royalGold:
        return context.l10n.skinRoyalGold;
      case AppSkin.monochrome:
        return context.l10n.skinMonochrome;
    }
  }
}

class _TodayTab extends StatelessWidget {
  const _TodayTab({required this.onGoToRoutines});

  final VoidCallback onGoToRoutines;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Center(child: AppLogo()),
        ),
        title: Text(context.l10n.today),
        actions: const [_DashboardTopMenu()],
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const Center(child: CircularProgressIndicator()),
            loading: (_) => const Center(child: CircularProgressIndicator()),
            success: (s) => _buildBody(context, s.activeSessions),
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
      floatingActionButton: FloatingActionButton.extended(
        heroTag: const ValueKey('fab-today'),
        onPressed: onGoToRoutines,
        icon: const Icon(Icons.play_arrow_rounded),
        label: Text(context.l10n.startWorkout),
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<WorkoutSession> activeSessions) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (activeSessions.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fitness_center_rounded,
                size: 80,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.35),
              ),
              const SizedBox(height: 24),
              Text(
                context.l10n.noWorkoutToday,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: activeSessions.length,
      itemBuilder: (context, index) {
        return _ActiveSessionCard(session: activeSessions[index]);
      },
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
  const _HistoryTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Center(child: AppLogo()),
        ),
        title: Text(context.l10n.history),
        actions: const [_DashboardTopMenu()],
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const Center(child: CircularProgressIndicator()),
            loading: (_) => const Center(child: CircularProgressIndicator()),
            success: (s) => _buildHistory(
              context,
              selectedDate: s.selectedDate,
              completedSessions: s.completedSessions,
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
    required DateTime selectedDate,
    required List<WorkoutSession> completedSessions,
  }) {
    final sessionsForDay = completedSessions
        .where((session) => _isSameDay(session.createdAt, selectedDate))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return Column(
      children: [
        _WeeklyCalendarStrip(selectedDate: selectedDate),
        const Divider(height: 1),
        Expanded(
          child: sessionsForDay.isEmpty
              ? _buildEmptyState(context)
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: sessionsForDay.length,
                  itemBuilder: (context, index) {
                    final session = sessionsForDay[index];
                    return _buildSessionCard(context, session);
                  },
                ),
        ),
      ],
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

class _WeeklyCalendarStrip extends StatelessWidget {
  const _WeeklyCalendarStrip({required this.selectedDate});

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final days = _weekDaysFor(selectedDate);
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);

    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final isSelected = _isSameDay(day, selectedDate);
          final isToday = _isSameDay(day, normalizedToday);
          final isFuture = day.isAfter(normalizedToday);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: isFuture
                  ? null
                  : () => context.read<DashboardCubit>().selectDate(day),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 54,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: isSelected ? 1.4 : 1,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.E(Localizations.localeOf(context).languageCode)
                          .format(day),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: isFuture
                                ? Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant
                                    .withValues(alpha: 0.45)
                                : isSelected
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${day.day}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isFuture
                                ? Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant
                                    .withValues(alpha: 0.45)
                                : isSelected
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer
                                    : Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isToday
                            ? (isSelected
                                ? Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer
                                : Theme.of(context).colorScheme.primary)
                            : Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<DateTime> _weekDaysFor(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    final firstDay = normalized.subtract(Duration(days: normalized.weekday - 1));
    return List.generate(7, (index) => firstDay.add(Duration(days: index)));
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
