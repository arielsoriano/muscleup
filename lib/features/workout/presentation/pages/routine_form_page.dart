import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../domain/entities/workout_entities.dart';
import '../cubit/routine_form_cubit.dart';
import '../cubit/routine_form_state.dart';

class RoutineFormPage extends StatelessWidget {
  const RoutineFormPage({
    this.routine,
    super.key,
  });

  final WorkoutRoutine? routine;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<RoutineFormCubit>(
        param1: routine,
      ),
      child: const _RoutineFormPageContent(),
    );
  }
}

class _RoutineFormPageContent extends StatelessWidget {
  const _RoutineFormPageContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoutineFormCubit, RoutineFormState>(
      listener: (context, state) {
        if (state is RoutineFormStateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.saveRoutineSuccess),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
          context.pop();
        } else if (state is RoutineFormStateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isSaving = state is RoutineFormStateSaving;

        return PopScope(
          canPop: !isSaving,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                state.isNew ? context.l10n.addRoutine : context.l10n.editRoutine,
              ),
            ),
            body: isSaving
                ? const Center(child: CircularProgressIndicator())
                : _buildFormContent(context, state),
            floatingActionButton: isSaving
                ? null
                : FloatingActionButton.extended(
                    onPressed: () => context.read<RoutineFormCubit>().saveRoutine(),
                    icon: const Icon(Icons.check_rounded),
                    label: Text(context.l10n.save),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildFormContent(BuildContext context, RoutineFormState state) {
    final routine = state.routine;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRoutineNameField(context, routine),
          const SizedBox(height: 24),
          _buildExercisesList(context, routine),
          const SizedBox(height: 16),
          _buildAddExerciseButton(context),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildRoutineNameField(BuildContext context, WorkoutRoutine routine) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      controller: TextEditingController(text: routine.name),
      style: textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        labelText: context.l10n.routineName,
        filled: true,
        fillColor: colorScheme.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
      onChanged: (value) => context.read<RoutineFormCubit>().updateName(value),
    );
  }

  Widget _buildExercisesList(BuildContext context, WorkoutRoutine routine) {
    if (routine.exercises.isEmpty) {
      return _buildEmptyExercisesState(context);
    }

    return Column(
      children: routine.exercises.map((exercise) {
        return _ExerciseFormItem(
          key: ValueKey(exercise.id),
          exercise: exercise,
        );
      }).toList(),
    );
  }

  Widget _buildEmptyExercisesState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.fitness_center_outlined,
              size: 48,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No exercises added yet',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddExerciseButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _showAddExerciseDialog(context),
      icon: const Icon(Icons.add_rounded),
      label: Text(context.l10n.addExercise),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> _showAddExerciseDialog(BuildContext context) async {
    final controller = TextEditingController();
    final exerciseName = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.addExercise),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            labelText: context.l10n.exerciseName,
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              Navigator.of(dialogContext).pop(value);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                Navigator.of(dialogContext).pop(controller.text);
              }
            },
            child: Text(context.l10n.save),
          ),
        ],
      ),
    );

    if (exerciseName != null && exerciseName.isNotEmpty && context.mounted) {
      context.read<RoutineFormCubit>().addExercise(exerciseName);
    }
  }
}

class _ExerciseFormItem extends StatefulWidget {
  const _ExerciseFormItem({
    required this.exercise,
    super.key,
  });

  final WorkoutExercise exercise;

  @override
  State<_ExerciseFormItem> createState() => _ExerciseFormItemState();
}

class _ExerciseFormItemState extends State<_ExerciseFormItem> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            title: Text(
              widget.exercise.name,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: widget.exercise.templateSets.isEmpty
                ? Text(
                    'No sets added',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  )
                : Text(
                    '${widget.exercise.templateSets.length} sets',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: () => _showDeleteExerciseConfirmation(context),
                ),
              ],
            ),
          ),
          if (_isExpanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildRestTimeField(context),
                  const SizedBox(height: 16),
                  if (widget.exercise.templateSets.isNotEmpty)
                    _buildSetsTable(context),
                  const SizedBox(height: 12),
                  _buildAddSetButton(context),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRestTimeField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          Icons.timer_outlined,
          size: 20,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: TextEditingController(
              text: widget.exercise.restTimeSeconds.toString(),
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Rest Time (seconds)',
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              final seconds = int.tryParse(value);
              if (seconds != null) {
                context.read<RoutineFormCubit>().updateExercise(
                      widget.exercise.id,
                      restTimeSeconds: seconds,
                    );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSetsTable(BuildContext context) {
    return Column(
      children: widget.exercise.templateSets.asMap().entries.map((entry) {
        final index = entry.key;
        final set = entry.value;
        return _SetFormRow(
          key: ValueKey(set.id),
          setNumber: index + 1,
          set: set,
          exerciseId: widget.exercise.id,
        );
      }).toList(),
    );
  }

  Widget _buildAddSetButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        context.read<RoutineFormCubit>().addSet(widget.exercise.id);
      },
      icon: const Icon(Icons.add_rounded, size: 18),
      label: Text(context.l10n.addSet),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  Future<void> _showDeleteExerciseConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.removeExercise),
        content: Text('Are you sure you want to remove ${widget.exercise.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<RoutineFormCubit>().removeExercise(widget.exercise.id);
    }
  }
}

class _SetFormRow extends StatelessWidget {
  const _SetFormRow({
    required this.setNumber,
    required this.set,
    required this.exerciseId,
    super.key,
  });

  final int setNumber;
  final WorkoutSet set;
  final String exerciseId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                setNumber.toString(),
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildValueField(
                    context,
                    label: 'Value 1',
                    value: set.targetValue1,
                    unit: set.unit1,
                    onValueChanged: (value) {
                      context.read<RoutineFormCubit>().updateSetValues(
                            exerciseId: exerciseId,
                            setId: set.id,
                            targetValue1: value,
                          );
                    },
                    onUnitChanged: (unit) {
                      context.read<RoutineFormCubit>().updateSetValues(
                            exerciseId: exerciseId,
                            setId: set.id,
                            unit1: unit,
                          );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildValueField(
                    context,
                    label: 'Value 2',
                    value: set.targetValue2,
                    unit: set.unit2,
                    onValueChanged: (value) {
                      context.read<RoutineFormCubit>().updateSetValues(
                            exerciseId: exerciseId,
                            setId: set.id,
                            targetValue2: value,
                          );
                    },
                    onUnitChanged: (unit) {
                      context.read<RoutineFormCubit>().updateSetValues(
                            exerciseId: exerciseId,
                            setId: set.id,
                            unit2: unit,
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 20),
            onPressed: () {
              context.read<RoutineFormCubit>().removeSet(exerciseId, set.id);
            },
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }

  Widget _buildValueField(
    BuildContext context, {
    required String label,
    required double? value,
    required WorkoutUnit? unit,
    required ValueChanged<double> onValueChanged,
    required ValueChanged<WorkoutUnit> onUnitChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: TextEditingController(text: value?.toString() ?? '0'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onChanged: (text) {
            final parsedValue = double.tryParse(text);
            if (parsedValue != null) {
              onValueChanged(parsedValue);
            }
          },
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<WorkoutUnit>(
          value: unit,
          isDense: true,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          items: WorkoutUnit.values.map((unit) {
            return DropdownMenuItem(
              value: unit,
              child: Text(
                _formatUnit(unit),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }).toList(),
          onChanged: (newUnit) {
            if (newUnit != null) {
              onUnitChanged(newUnit);
            }
          },
        ),
      ],
    );
  }

  String _formatUnit(WorkoutUnit unit) {
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
        return 'none';
    }
  }
}
