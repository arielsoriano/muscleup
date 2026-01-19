import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/ui_helpers.dart';
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

class _RoutineFormPageContent extends StatefulWidget {
  const _RoutineFormPageContent();

  @override
  State<_RoutineFormPageContent> createState() =>
      _RoutineFormPageContentState();
}

class _RoutineFormPageContentState extends State<_RoutineFormPageContent> {
  late final TextEditingController _routineNameController;
  final SearchController _exerciseSearchController = SearchController();

  @override
  void initState() {
    super.initState();
    final initialRoutine = context.read<RoutineFormCubit>().state.routine;
    _routineNameController = TextEditingController(text: initialRoutine.name);
  }

  @override
  void dispose() {
    _routineNameController.dispose();
    _exerciseSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoutineFormCubit, RoutineFormState>(
      listener: (context, state) {
        if (state is RoutineFormStateSuccess) {
          context.showAppSnackBar(context.l10n.saveRoutineSuccess);
          context.pop();
        } else if (state is RoutineFormStateError) {
          context.showAppSnackBar(state.message, isError: true);
        }
      },
      builder: (context, state) {
        final isSaving = state is RoutineFormStateSaving;

        return PopScope(
          canPop: !isSaving,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                state.isNew
                    ? context.l10n.addRoutine
                    : context.l10n.editRoutine,
              ),
            ),
            body: isSaving
                ? const Center(child: CircularProgressIndicator())
                : _buildFormContent(context, state),
            floatingActionButton: isSaving
                ? null
                : FloatingActionButton.extended(
                    onPressed: () =>
                        context.read<RoutineFormCubit>().saveRoutine(),
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
          BlocBuilder<RoutineFormCubit, RoutineFormState>(
            builder: (context, state) {
              return _buildExercisesList(context, state.routine);
            },
          ),
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
      controller: _routineNameController,
      style: textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        labelText: context.l10n.routineName,
        hintText: context.l10n.routineNameHint,
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
              context.l10n.noExercisesAdded,
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
    final languageCode = Localizations.localeOf(context).languageCode;
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<RoutineFormCubit>();

    return SearchAnchor(
      searchController: _exerciseSearchController,
      viewHintText: context.l10n.searchExercises,
      isFullScreen: false,
      viewConstraints: const BoxConstraints(maxHeight: 400),
      builder: (BuildContext context, SearchController controller) {
        return OutlinedButton.icon(
          onPressed: () {
            controller.openView();
          },
          icon: const Icon(Icons.add_rounded),
          label: Text(context.l10n.addExercise),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
      suggestionsBuilder:
          (BuildContext searchContext, SearchController controller) async {
        final query = controller.text.trim();
        final suggestions = <Widget>[];

        if (query.isEmpty) {
          suggestions.add(
            ListTile(
              leading: Icon(
                Icons.edit_outlined,
                color: colorScheme.onSurfaceVariant,
              ),
              title: Text(
                context.l10n.searchHelper,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
              enabled: false,
            ),
          );

          final result = await cubit.getLibraryExercises();
          result.fold(
            (failure) {},
            (exercises) {
              suggestions.addAll(
                exercises.take(10).map((exercise) {
                  final exerciseName = exercise.getLocalizedName(languageCode);
                  return ListTile(
                    leading: Icon(
                      Icons.fitness_center_rounded,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    title: Text(exerciseName),
                    onTap: () {
                      cubit.addExercise(exerciseName);
                      controller.closeView(null);
                      controller.clear();
                    },
                  );
                }),
              );
            },
          );
        } else {
          suggestions.add(
            ListTile(
              leading: Icon(
                Icons.add_circle_outline_rounded,
                color: colorScheme.primary,
              ),
              title: Text(
                context.l10n.addCustomExercise(query),
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                cubit.addExercise(query);
                controller.closeView(null);
                controller.clear();
              },
            ),
          );

          final result =
              await cubit.searchLibraryExercises(query, languageCode);
          result.fold(
            (failure) {},
            (exercises) {
              suggestions.addAll(
                exercises.map((exercise) {
                  final exerciseName = exercise.getLocalizedName(languageCode);
                  return ListTile(
                    leading: Icon(
                      Icons.fitness_center_rounded,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    title: Text(exerciseName),
                    onTap: () {
                      cubit.addExercise(exerciseName);
                      controller.closeView(null);
                      controller.clear();
                    },
                  );
                }),
              );
            },
          );
        }

        return suggestions;
      },
    );
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
  late final TextEditingController _restTimeController;

  @override
  void initState() {
    super.initState();
    _restTimeController = TextEditingController(
      text: widget.exercise.restTimeSeconds.toString(),
    );
  }

  @override
  void dispose() {
    _restTimeController.dispose();
    super.dispose();
  }

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
                    context.l10n.noSetsAdded,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  )
                : Text(
                    context.l10n.setsCount(widget.exercise.templateSets.length),
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon:
                      Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
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
            controller: _restTimeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: context.l10n.restTimeSeconds,
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
        content: Text(context.l10n.removeConfirmation(widget.exercise.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(context.l10n.remove),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<RoutineFormCubit>().removeExercise(widget.exercise.id);
    }
  }
}

class _SetFormRow extends StatefulWidget {
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
  State<_SetFormRow> createState() => _SetFormRowState();
}

class _SetFormRowState extends State<_SetFormRow> {
  late final TextEditingController _value1Controller;
  late final TextEditingController _value2Controller;

  @override
  void initState() {
    super.initState();
    _value1Controller = TextEditingController(
      text: widget.set.targetValue1?.toString() ?? '0',
    );
    _value2Controller = TextEditingController(
      text: widget.set.targetValue2?.toString() ?? '0',
    );
  }

  @override
  void dispose() {
    _value1Controller.dispose();
    _value2Controller.dispose();
    super.dispose();
  }

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
                widget.setNumber.toString(),
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
                    controller: _value1Controller,
                    label: 'Value 1',
                    value: widget.set.targetValue1,
                    unit: widget.set.unit1,
                    onValueChanged: (value) {
                      context.read<RoutineFormCubit>().updateSetValues(
                            exerciseId: widget.exerciseId,
                            setId: widget.set.id,
                            targetValue1: value,
                          );
                    },
                    onUnitChanged: (unit) {
                      context.read<RoutineFormCubit>().updateSetValues(
                            exerciseId: widget.exerciseId,
                            setId: widget.set.id,
                            unit1: unit,
                          );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildValueField(
                    context,
                    controller: _value2Controller,
                    label: 'Value 2',
                    value: widget.set.targetValue2,
                    unit: widget.set.unit2,
                    onValueChanged: (value) {
                      context.read<RoutineFormCubit>().updateSetValues(
                            exerciseId: widget.exerciseId,
                            setId: widget.set.id,
                            targetValue2: value,
                          );
                    },
                    onUnitChanged: (unit) {
                      context.read<RoutineFormCubit>().updateSetValues(
                            exerciseId: widget.exerciseId,
                            setId: widget.set.id,
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
              context
                  .read<RoutineFormCubit>()
                  .removeSet(widget.exerciseId, widget.set.id);
            },
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }

  Widget _buildValueField(
    BuildContext context, {
    required TextEditingController controller,
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
          controller: controller,
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
        return context.l10n.unitKg;
      case WorkoutUnit.pounds:
        return context.l10n.unitLb;
      case WorkoutUnit.repetitions:
        return context.l10n.unitReps;
      case WorkoutUnit.seconds:
        return context.l10n.unitSeconds;
      case WorkoutUnit.minutes:
        return context.l10n.unitMinutes;
      case WorkoutUnit.kilometers:
        return context.l10n.unitKm;
      case WorkoutUnit.meters:
        return context.l10n.unitMeters;
      case WorkoutUnit.none:
        return context.l10n.unitNone;
    }
  }
}
