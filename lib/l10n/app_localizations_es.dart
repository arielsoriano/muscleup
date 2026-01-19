// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Muscleup';

  @override
  String get workouts => 'Entrenamientos';

  @override
  String get exercises => 'Ejercicios';

  @override
  String get history => 'Historial';

  @override
  String get settings => 'Ajustes';

  @override
  String get routines => 'Rutinas';

  @override
  String get sets => 'Series';

  @override
  String get weight => 'Peso';

  @override
  String get reps => 'Repeticiones';

  @override
  String get addRoutine => 'Añadir Rutina';

  @override
  String get addExercise => 'Añadir Ejercicio';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get back => 'Atrás';

  @override
  String get routineDetailsTitle => 'Detalles de Rutina';

  @override
  String get noRoutines => 'No se encontraron rutinas';

  @override
  String get errorLoading => 'Error al cargar las rutinas';

  @override
  String get retry => 'Reintentar';

  @override
  String get dashboardTitle => 'Panel Principal';

  @override
  String get today => 'Hoy';

  @override
  String get noWorkoutToday => 'No hay entrenamiento registrado para este día';

  @override
  String get startWorkout => 'Iniciar una Rutina';

  @override
  String get finishWorkout => 'Finalizar Entrenamiento';

  @override
  String get workoutSavedSuccess => '¡Entrenamiento guardado exitosamente!';

  @override
  String get activeWorkoutTitle => 'Entrenamiento Activo';

  @override
  String get set => 'Serie';

  @override
  String get target => 'Objetivo';

  @override
  String get actual => 'Real';

  @override
  String get routineName => 'Nombre de Rutina';

  @override
  String get exerciseName => 'Nombre de Ejercicio';

  @override
  String get removeExercise => 'Eliminar Ejercicio';

  @override
  String get addSet => 'Añadir Serie';

  @override
  String get saveRoutineSuccess => '¡Rutina guardada exitosamente!';

  @override
  String get editRoutine => 'Editar Rutina';

  @override
  String get routineNameHint => 'ej. Día de pierna, Lunes';

  @override
  String get searchExercises => 'Buscar ejercicios...';

  @override
  String get noResults => 'No se encontraron ejercicios';

  @override
  String get noExercisesAdded => 'No se han añadido ejercicios';

  @override
  String addCustomExercise(String name) {
    return 'Añadir \'$name\'';
  }

  @override
  String get searchHelper => 'Escribe para buscar o añadir...';

  @override
  String get noSetsAdded => 'No se han añadido series';

  @override
  String get restTimeSeconds => 'Tiempo de descanso (segundos)';

  @override
  String removeConfirmation(String name) {
    return '¿Estás seguro de que quieres eliminar $name?';
  }

  @override
  String get remove => 'Eliminar';

  @override
  String get unitKg => 'kg';

  @override
  String get unitLb => 'lb';

  @override
  String get unitReps => 'reps';

  @override
  String get unitSeconds => 's';

  @override
  String get unitMinutes => 'min';

  @override
  String get unitKm => 'km';

  @override
  String get unitMeters => 'm';

  @override
  String get unitNone => 'ninguno';

  @override
  String setsCount(int count) {
    return '$count series';
  }

  @override
  String get language => 'Idioma';

  @override
  String get noExercisesInRoutine => 'No hay ejercicios en esta rutina';

  @override
  String get deleteRoutineConfirm =>
      '¿Estás seguro de que quieres eliminar esta rutina?';

  @override
  String get delete => 'Eliminar';

  @override
  String get emptyRoutine => 'Vacía';

  @override
  String get startNewSession => 'Iniciar Nueva Sesión';

  @override
  String startRoutineName(String name) {
    return 'Iniciar $name';
  }

  @override
  String get addExercisesFirst => 'Añade ejercicios primero';
}
