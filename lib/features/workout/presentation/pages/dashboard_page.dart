import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
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
                final newLanguageCode = currentLocale.languageCode == 'en'
                    ? 'es'
                    : 'en';
                context.read<SettingsCubit>().changeLanguage(newLanguageCode);
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
          return state.when(
            initial: (selectedDate, sessions) => const SizedBox.shrink(),
            loading: (selectedDate, sessions) => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (selectedDate, sessions) => _buildSuccessContent(
              context,
              selectedDate,
              sessions,
            ),
            error: (selectedDate, message, sessions) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.errorLoading,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
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
    List<WorkoutSession> sessions,
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
          child: sessions.isEmpty
              ? _buildEmptySessionsList(context)
              : _buildSessionsList(context, sessions),
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

  Widget _buildSessionsList(
    BuildContext context,
    List<WorkoutSession> sessions,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        return _buildSessionCard(context, sessions[index]);
      },
    );
  }

  Widget _buildSessionCard(BuildContext context, WorkoutSession session) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          context.push(AppRoutes.routineDetailsPath(session.routineId));
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.fitness_center_rounded,
                    color: colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMd(
                            Localizations.localeOf(context).languageCode,
                          ).format(session.date),
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (session.notes != null && session.notes!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              session.notes!,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptySessionsList(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_available_rounded,
              size: 80,
              color: colorScheme.onSurfaceVariant.withValues(
                alpha: 0.5,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.noWorkoutToday,
              style: textTheme.titleLarge?.copyWith(
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
}
