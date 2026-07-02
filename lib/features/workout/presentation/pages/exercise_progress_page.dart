import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../domain/entities/workout_entities.dart';
import '../../domain/repositories/workout_repository.dart';

/// Read-only progression view for a single routine exercise: shows what was
/// done for it in every completed session, most recent first.
class ExerciseProgressPage extends StatelessWidget {
  const ExerciseProgressPage({
    required this.workoutExerciseId,
    required this.exerciseName,
    super.key,
  });

  final String workoutExerciseId;
  final String exerciseName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exerciseName),
      ),
      body: FutureBuilder(
        future: serviceLocator<WorkoutRepository>()
            .getExerciseHistory(workoutExerciseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final entries = snapshot.data?.fold(
                (_) => <ExerciseHistoryEntry>[],
                (list) => list,
              ) ??
              <ExerciseHistoryEntry>[];

          if (entries.isEmpty) {
            return _buildEmptyState(context);
          }

          final locale = Localizations.localeOf(context).languageCode;

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: entries.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 4, top: 4),
                  child: Text(
                    context.l10n.progressSessionsCount(entries.length),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                );
              }

              return _ProgressEntryCard(
                entry: entries[index - 1],
                locale: locale,
              );
            },
          );
        },
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
              Icons.show_chart_rounded,
              size: 72,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.noProgressYet,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressEntryCard extends StatelessWidget {
  const _ProgressEntryCard({required this.entry, required this.locale});

  final ExerciseHistoryEntry entry;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final setTexts = entry.sets
        .map(_formatSet)
        .where((text) => text.isNotEmpty)
        .toList();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMEEEEd(locale).format(entry.date),
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var i = 0; i < setTexts.length; i++)
                  _SetChip(index: i + 1, label: setTexts[i]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatSet(SetLog log) {
    final parts = <String>[];

    if (log.unit1 != null && log.unit1 != WorkoutUnit.none) {
      final value = log.actualValue1?.formatClean();
      if (value != null) {
        parts.add('$value${_formatUnit(log.unit1)}');
      }
    }

    if (log.unit2 != null && log.unit2 != WorkoutUnit.none) {
      final value = log.actualValue2?.formatClean();
      if (value != null) {
        parts.add('$value${_formatUnit(log.unit2)}');
      }
    }

    return parts.join(' × ');
  }

  String _formatUnit(WorkoutUnit? unit) {
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
      case WorkoutUnit.level:
        return 'level';
      case WorkoutUnit.incline:
        return 'incline';
      case WorkoutUnit.none:
      case null:
        return '';
    }
  }
}

class _SetChip extends StatelessWidget {
  const _SetChip({required this.index, required this.label});

  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$index',
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
