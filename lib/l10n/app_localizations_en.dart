// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Muscleup';

  @override
  String get workouts => 'Workouts';

  @override
  String get exercises => 'Exercises';

  @override
  String get history => 'History';

  @override
  String get settings => 'Settings';

  @override
  String get routines => 'Routines';

  @override
  String get sets => 'Sets';

  @override
  String get weight => 'Weight';

  @override
  String get reps => 'Reps';

  @override
  String get addRoutine => 'Add Routine';

  @override
  String get addExercise => 'Add Exercise';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get back => 'Back';

  @override
  String get routineDetailsTitle => 'Routine Details';

  @override
  String get noRoutines => 'No routines found';

  @override
  String get errorLoading => 'Error loading routines';

  @override
  String get retry => 'Retry';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get today => 'Today';

  @override
  String get noWorkoutToday => 'No workout recorded for this day';

  @override
  String get startWorkout => 'Start a Routine';

  @override
  String get finishWorkout => 'Finish Workout';

  @override
  String get workoutSavedSuccess => 'Workout saved successfully!';

  @override
  String get activeWorkoutTitle => 'Active Workout';

  @override
  String get set => 'Set';

  @override
  String get target => 'Target';

  @override
  String get actual => 'Actual';

  @override
  String get routineName => 'Routine Name';

  @override
  String get exerciseName => 'Exercise Name';

  @override
  String get removeExercise => 'Remove Exercise';

  @override
  String get addSet => 'Add Set';

  @override
  String get saveRoutineSuccess => 'Routine saved successfully!';

  @override
  String get editRoutine => 'Edit Routine';

  @override
  String get routineNameHint => 'e.g. Leg Day, Monday';

  @override
  String get searchExercises => 'Search exercises...';

  @override
  String get noResults => 'No exercises found';

  @override
  String get noExercisesAdded => 'No exercises added yet';

  @override
  String addCustomExercise(String name) {
    return 'Add \'$name\'';
  }

  @override
  String get searchHelper => 'Type to search or add...';

  @override
  String get noSetsAdded => 'No sets added';

  @override
  String get restTimeSeconds => 'Rest Time (seconds)';

  @override
  String removeConfirmation(String name) {
    return 'Are you sure you want to remove $name?';
  }

  @override
  String get remove => 'Remove';

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
  String get unitNone => 'none';

  @override
  String setsCount(int count) {
    return '$count sets';
  }

  @override
  String get language => 'Language';

  @override
  String get noExercisesInRoutine => 'No exercises in this routine';

  @override
  String get deleteRoutineConfirm =>
      'Are you sure you want to delete this routine?';

  @override
  String get delete => 'Delete';

  @override
  String get emptyRoutine => 'Empty';

  @override
  String get startNewSession => 'Start New Session';

  @override
  String startRoutineName(String name) {
    return 'Start $name';
  }

  @override
  String get addExercisesFirst => 'Add exercises first';

  @override
  String get deleteSessionConfirm =>
      'Are you sure you want to delete this workout session?';

  @override
  String get sessionDeleted => 'Session deleted';

  @override
  String get resting => 'Resting';

  @override
  String get add30Seconds => '+30s';
}
