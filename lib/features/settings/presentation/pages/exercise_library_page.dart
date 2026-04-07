import 'package:flutter/material.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
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
    final isSpanish = Localizations.localeOf(context).languageCode == 'es';
    final name = await _showExerciseNameDialog(
      title: isSpanish ? 'Nuevo ejercicio' : 'New exercise',
      initialValue: '',
    );

    if (name == null || name.trim().isEmpty) {
      return;
    }

    await _runMutation(() => _repository.saveLibraryExercise(name.trim()));
  }

  Future<void> _editExercise(LibraryExerciseEntity exercise) async {
    final isSpanish = Localizations.localeOf(context).languageCode == 'es';
    final name = await _showExerciseNameDialog(
      title: isSpanish ? 'Editar ejercicio' : 'Edit exercise',
      initialValue: exercise.getLocalizedName(
        Localizations.localeOf(context).languageCode,
      ),
    );

    if (name == null || name.trim().isEmpty) {
      return;
    }

    await _runMutation(
      () => _repository.updateLibraryExercise(
        exercise.id,
        name.trim(),
        nameEn: name.trim(),
        nameEs: name.trim(),
      ),
    );
  }

  Future<void> _deleteExercise(LibraryExerciseEntity exercise) async {
    final isSpanish = Localizations.localeOf(context).languageCode == 'es';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(isSpanish ? 'Eliminar ejercicio' : 'Delete exercise'),
          content: Text(
            isSpanish
                ? '¿Seguro que quieres eliminar ${exercise.getLocalizedName('es')}?'
                : 'Are you sure you want to delete ${exercise.getLocalizedName('en')}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(isSpanish ? 'Cancelar' : 'Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(isSpanish ? 'Eliminar' : 'Delete'),
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
        final isSpanish = Localizations.localeOf(context).languageCode == 'es';
        context.showAppSnackBar(
          message: isSpanish ? 'Cambios guardados' : 'Changes saved',
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
    final controller = TextEditingController(text: initialValue);
    final isSpanish = Localizations.localeOf(context).languageCode == 'es';

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: isSpanish ? 'Nombre del ejercicio' : 'Exercise name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(isSpanish ? 'Cancelar' : 'Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(controller.text),
              child: Text(isSpanish ? 'Guardar' : 'Save'),
            ),
          ],
        );
      },
    );

    controller.dispose();
    return result;
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
    final isSpanish = Localizations.localeOf(context).languageCode == 'es';
    final languageCode = Localizations.localeOf(context).languageCode;
    final filteredExercises = _allExercises.where((exercise) {
      final localizedName = exercise.getLocalizedName(languageCode).toLowerCase();
      return localizedName.contains(_query.toLowerCase());
    }).toList()
      ..sort((left, right) => left
          .getLocalizedName(languageCode)
          .toLowerCase()
          .compareTo(right.getLocalizedName(languageCode).toLowerCase()),);

    return Scaffold(
      appBar: AppBar(
        title: Text(isSpanish ? 'Gestion de ejercicios' : 'Exercise library'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isMutating ? null : _createExercise,
        icon: const Icon(Icons.add_rounded),
        label: Text(isSpanish ? 'Nuevo' : 'New'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: SearchBar(
              controller: _searchController,
              hintText: isSpanish ? 'Buscar ejercicios' : 'Search exercises',
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
                child: Text(
                  isSpanish ? 'No hay ejercicios para mostrar' : 'No exercises to show',
                ),
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
                              ? (isSpanish ? 'Personalizado' : 'Custom')
                              : (isSpanish ? 'Biblioteca' : 'Library'),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: _isMutating ? null : () => _editExercise(exercise),
                              icon: const Icon(Icons.edit_rounded),
                            ),
                            IconButton(
                              onPressed: _isMutating ? null : () => _deleteExercise(exercise),
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
