import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../domain/entities/workout_entities.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<DashboardCubit>(),
      child: const _DashboardPageContent(),
    );
  }
}

class _DashboardPageContent extends StatelessWidget {
  const _DashboardPageContent();

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.dashboardTitle),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (value) {
              if (value == 'routines') {
                context.push(AppRoutes.routines);
              } else if (value == 'language') {
                final newLanguageCode =
                    currentLocale.languageCode == 'en' ? 'es' : 'en';
                context.read<SettingsCubit>().changeLanguage(newLanguageCode);
              } else if (value == 'appSkin') {
                _showSkinSelector(context);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'routines',
                child: Row(
                  children: [
                    const Icon(Icons.list_alt_rounded),
                    const SizedBox(width: 12),
                    Text(context.l10n.routines),
                  ],
                ),
              ),
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
          ),
        ],
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return state.map(
            initial: (state) => const SizedBox.shrink(),
            loading: (state) => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (state) => _buildSuccessContent(
              context,
              state.selectedDate,
              state.routines,
              state.activeSessions,
            ),
            error: (state) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.errorLoading,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuccessContent(
    BuildContext context,
    DateTime selectedDate,
    List<WorkoutRoutine> routines,
    List<WorkoutSession> activeSessions,
  ) {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final normalizedSelected = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    final isFutureDate = normalizedSelected.isAfter(normalizedToday);

    return Column(
      children: [
        _buildWeeklyCalendarStrip(context, selectedDate),
        const Divider(height: 1),
        Expanded(
          child: routines.isEmpty
              ? _buildEmptyRoutinesList(context)
              : BlocBuilder<DashboardCubit, DashboardState>(
                  builder: (context, state) {
                    return state.map(
                      initial: (_) => const SizedBox.shrink(),
                      loading: (_) => const SizedBox.shrink(),
                      success: (state) => _buildRoutinesList(
                        context,
                        routines,
                        activeSessions,
                        state.completedSessions,
                      ),
                      error: (_) => const SizedBox.shrink(),
                    );
                  },
                ),
        ),
        if (!isFutureDate) _buildStartButton(context),
      ],
    );
  }



  Widget _buildWeeklyCalendarStrip(
    BuildContext context,
    DateTime selectedDate,
  ) {
    final weekDays = _getWeekDaysFromDate(selectedDate);
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);

    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weekDays.length,
        itemBuilder: (context, index) {
          final date = weekDays[index];
          final isSelected = _isSameDay(date, selectedDate);
          final isToday = _isSameDay(date, normalizedToday);

          return _buildDayCard(context, date, isSelected, isToday);
        },
      ),
    );
  }

  Widget _buildDayCard(
    BuildContext context,
    DateTime date,
    bool isSelected,
    bool isToday,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => context.read<DashboardCubit>().selectDate(date),
      child: Container(
        width: 64,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color:
              isSelected ? colorScheme.primaryContainer : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? colorScheme.primary : colorScheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat.E(Localizations.localeOf(context).languageCode)
                  .format(date),
              style: textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date.day.toString(),
              style: textTheme.titleLarge?.copyWith(
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isToday) ...[
              const SizedBox(height: 4),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isSelected
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRoutinesList(
    BuildContext context,
    List<WorkoutRoutine> routines,
    List<WorkoutSession> activeSessions,
    List<WorkoutSession> completedSessions,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: routines.length,
      itemBuilder: (context, index) {
        final routine = routines[index];
        final activeSession = activeSessions.firstWhereOrNull(
          (s) => s.routineId == routine.id,
        );
        final completedSession = completedSessions.firstWhereOrNull(
          (s) => s.routineId == routine.id,
        );
        return _buildRoutineCard(
          context,
          routine,
          activeSession,
          completedSession,
        );
      },
    );
  }

  Widget _buildRoutineCard(
    BuildContext context,
    WorkoutRoutine routine,
    WorkoutSession? activeSession,
    WorkoutSession? completedSession,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isActive = activeSession != null;
    final isCompleted = completedSession != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: isActive
          ? colorScheme.surface
          : colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          if (isCompleted) {
            context.push(
              AppRoutes.activeWorkout,
              extra: {
                'routineId': routine.id,
                'sessionId': completedSession.id,
              },
            );
          } else if (isActive) {
            context.push(
              AppRoutes.activeWorkout,
              extra: {
                'routineId': routine.id,
                'sessionId': activeSession.id,
              },
            );
          } else {
            context.push(
              AppRoutes.activeWorkout,
              extra: {
                'routine': routine,
              },
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            border: isActive && !isCompleted
                ? Border(
                    left: BorderSide(
                      color: colorScheme.primary,
                      width: 4,
                    ),
                  )
                : null,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? colorScheme.surfaceContainerHigh
                      : colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isCompleted
                      ? Icons.done_all_rounded
                      : isActive
                          ? Icons.play_arrow_rounded
                          : Icons.fitness_center_rounded,
                  color: isCompleted
                      ? colorScheme.primary
                      : colorScheme.onPrimaryContainer,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isCompleted) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.check,
                            size: 16,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            context.l10n.completed,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                    ] else if (isActive) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            context.l10n.inProgress,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                    ],
                    Text(
                      routine.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    if (!isActive && !isCompleted) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${routine.exercises.length} ${context.l10n.exercises}',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyRoutinesList(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center_rounded,
              size: 80,
              color: colorScheme.onSurfaceVariant.withValues(
                alpha: 0.5,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.noRoutinesAvailable,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.createRoutineToGetStarted,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: FilledButton.icon(
        onPressed: () => context.push(AppRoutes.routines),
        icon: const Icon(Icons.play_arrow_rounded),
        label: Text(context.l10n.startNewSession),
      ),
    );
  }

  List<DateTime> _getWeekDaysFromDate(DateTime date) {
    final weekday = date.weekday;
    final firstDayOfWeek = date.subtract(Duration(days: weekday - 1));

    return List.generate(7, (index) {
      return firstDayOfWeek.add(Duration(days: index));
    });
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
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
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
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
                  tileColor: isSelected
                      ? skin.primaryColor.withValues(alpha: 0.1)
                      : null,
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
