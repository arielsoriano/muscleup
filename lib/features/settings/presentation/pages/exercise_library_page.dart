import 'package:flutter/material.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../../workout/domain/repositories/workout_repository.dart';

class ExerciseLibraryPage extends StatefulWidget {
  const ExerciseLibraryPage({super.key});

  @override
  State<ExerciseLibraryPage> createState() => _ExerciseLibraryPageState();
}

class _ExerciseLibraryPageState extends State<ExerciseLibraryPage> {
  final WorkoutRepository _repository = serviceLocator<WorkoutRepository>();
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = true;
  bool _isMutating = false;
  String _query = '';
  List<LibraryExerciseEntity> _allExercises = const [];

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadExercises() async {
    setState(() {
      _isLoading = true;
    });

    final result = await _repository.getLibraryExercises();
    if (!mounted) {
      return;
    }

    result.fold(
      (failure) {
        context.showAppSnackBar(
          message: _failureMessage(failure),
          type: SnackBarType.error,
        );
      },
      (exercises) {
        setState(() {
          _allExercises = exercises;
        });
      },
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _createExercise() async {
    final name = await _showExerciseNameDialog(
      title: context.l10n.newExerciseTitle,
      initialValue: '',
    );

    if (name == null || name.trim().isEmpty) {
      return;
    }

    await _runMutation(() => _repository.saveLibraryExercise(name.trim()));
  }

  Future<void> _editExercise(LibraryExerciseEntity exercise) async {
    final languageCode = Localizations.localeOf(context).languageCode;
    final name = await _showExerciseNameDialog(
      title: context.l10n.editExerciseTitle,
      initialValue: exercise.getLocalizedName(languageCode),
    );

    if (name == null || name.trim().isEmpty) {
      return;
    }

    // Only the language being edited is replaced. Renaming an exercise while
    // the app is in Spanish used to overwrite its English name with the Spanish
    // text, which then surfaced as the English name on every other device.
    //
    // A seeded exercise keeps its canonical English name: that is what links
    // the row to the shipped catalog, so renaming it would cut the row off from
    // translations added in later releases. A custom exercise has no catalog
    // entry behind it, so its canonical name follows the edit.
    await _runMutation(
      () => _repository.updateLibraryExercise(
        exercise.id,
        exercise.isCustom ? name.trim() : exercise.name,
        names: exercise.names.withValue(languageCode, name.trim()),
      ),
    );
  }

  Future<void> _deleteExercise(LibraryExerciseEntity exercise) async {
    final languageCode = Localizations.localeOf(context).languageCode;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(context.l10n.deleteExerciseTitle),
          content: Text(
            context.l10n.deleteExerciseConfirm(
              exercise.getLocalizedName(languageCode),
            ),
          ),
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

    if (confirmed != true) {
      return;
    }

    await _runMutation(() => _repository.deleteLibraryExercise(exercise.id));
  }

  Future<void> _runMutation(
    Future<Either<Failure, void>> Function() action,
  ) async {
    setState(() {
      _isMutating = true;
    });

    final result = await action();
    if (!mounted) {
      return;
    }

    result.fold(
      (failure) {
        context.showAppSnackBar(
          message: _failureMessage(failure),
          type: SnackBarType.error,
        );
      },
      (_) async {
        await _loadExercises();
        if (!mounted) {
          return;
        }
        context.showAppSnackBar(
          message: context.l10n.changesSaved,
        );
      },
    );

    if (mounted) {
      setState(() {
        _isMutating = false;
      });
    }
  }

  Future<String?> _showExerciseNameDialog({
    required String title,
    required String initialValue,
  }) async {
    return showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return _ExerciseNameDialog(
          title: Text(title),
          initialValue: initialValue,
          hintText: context.l10n.exerciseNameHint,
          cancelLabel: context.l10n.cancel,
          saveLabel: context.l10n.save,
        );
      },
    );
  }

  String _failureMessage(Failure failure) {
    return switch (failure) {
      DatabaseFailure(message: final message) => message,
      UnexpectedFailure(message: final message) => message,
      _ => failure.toString(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final filteredExercises = _allExercises.where((exercise) {
      final localizedName = exercise.getLocalizedName(languageCode).toLowerCase();
      return localizedName.contains(_query.toLowerCase());
    }).toList()
      ..sort(
        (left, right) => left
            .getLocalizedName(languageCode)
            .toLowerCase()
            .compareTo(right.getLocalizedName(languageCode).toLowerCase()),
      );

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.exerciseLibraryTitle),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isMutating ? null : _createExercise,
        icon: const Icon(Icons.add_rounded),
        label: Text(context.l10n.newLabel),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: SearchBar(
              controller: _searchController,
              hintText: context.l10n.searchExercises,
              onChanged: (value) {
                setState(() {
                  _query = value.trim();
                });
              },
              leading: const Icon(Icons.search_rounded),
              trailing: [
                if (_query.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _query = '';
                      });
                    },
                    icon: const Icon(Icons.clear_rounded),
                  ),
              ],
            ),
          ),
          if (_isLoading)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (filteredExercises.isEmpty)
            Expanded(
              child: Center(
                child: Text(context.l10n.noExercisesToShow),
              ),
            )
          else
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadExercises,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                  itemCount: filteredExercises.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final exercise = filteredExercises[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          exercise.isCustom
                              ? Icons.edit_note_rounded
                              : Icons.fitness_center_rounded,
                        ),
                        title: Text(exercise.getLocalizedName(languageCode)),
                        subtitle: Text(
                          exercise.isCustom
                              ? context.l10n.customLabel
                              : context.l10n.libraryLabel,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: _isMutating
                                  ? null
                                  : () => _editExercise(exercise),
                              icon: const Icon(Icons.edit_rounded),
                            ),
                            IconButton(
                              onPressed: _isMutating
                                  ? null
                                  : () => _deleteExercise(exercise),
                              icon: const Icon(Icons.delete_outline_rounded),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ExerciseNameDialog extends StatefulWidget {
  const _ExerciseNameDialog({
    required this.title,
    required this.initialValue,
    required this.hintText,
    required this.cancelLabel,
    required this.saveLabel,
  });

  final Widget title;
  final String initialValue;
  final String hintText;
  final String cancelLabel;
  final String saveLabel;

  @override
  State<_ExerciseNameDialog> createState() => _ExerciseNameDialogState();
}

class _ExerciseNameDialogState extends State<_ExerciseNameDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: InputDecoration(
          hintText: widget.hintText,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(widget.cancelLabel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: Text(widget.saveLabel),
        ),
      ],
    );
  }
}
