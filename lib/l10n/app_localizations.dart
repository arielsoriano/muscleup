import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'Muscleup'**
  String get appTitle;

  /// Workouts label
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get workouts;

  /// Exercises label
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get exercises;

  /// History label
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// Settings label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Routines label
  ///
  /// In en, this message translates to:
  /// **'Routines'**
  String get routines;

  /// Sets label
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get sets;

  /// Weight label
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// Reps label
  ///
  /// In en, this message translates to:
  /// **'Reps'**
  String get reps;

  /// Add routine action
  ///
  /// In en, this message translates to:
  /// **'Add Routine'**
  String get addRoutine;

  /// Add exercise action
  ///
  /// In en, this message translates to:
  /// **'Add Exercise'**
  String get addExercise;

  /// Save action
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Back action
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Routine details page title
  ///
  /// In en, this message translates to:
  /// **'Routine Details'**
  String get routineDetailsTitle;

  /// Empty state message when no routines exist
  ///
  /// In en, this message translates to:
  /// **'No routines found'**
  String get noRoutines;

  /// Error message when routines fail to load
  ///
  /// In en, this message translates to:
  /// **'Error loading routines'**
  String get errorLoading;

  /// Retry action
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Dashboard page title
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// Today label
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Empty state message when no workout exists for selected day
  ///
  /// In en, this message translates to:
  /// **'No workout recorded for this day'**
  String get noWorkoutToday;

  /// Start workout action
  ///
  /// In en, this message translates to:
  /// **'Start a Routine'**
  String get startWorkout;

  /// Finish workout action
  ///
  /// In en, this message translates to:
  /// **'Finish Workout'**
  String get finishWorkout;

  /// Success message when workout is saved
  ///
  /// In en, this message translates to:
  /// **'Workout saved successfully!'**
  String get workoutSavedSuccess;

  /// Active workout page title
  ///
  /// In en, this message translates to:
  /// **'Active Workout'**
  String get activeWorkoutTitle;

  /// Set label for workout
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get set;

  /// Target label for workout
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get target;

  /// Actual label for workout
  ///
  /// In en, this message translates to:
  /// **'Actual'**
  String get actual;

  /// Routine name label
  ///
  /// In en, this message translates to:
  /// **'Routine Name'**
  String get routineName;

  /// Exercise name label
  ///
  /// In en, this message translates to:
  /// **'Exercise Name'**
  String get exerciseName;

  /// Remove exercise action
  ///
  /// In en, this message translates to:
  /// **'Remove Exercise'**
  String get removeExercise;

  /// Add set action
  ///
  /// In en, this message translates to:
  /// **'Add Set'**
  String get addSet;

  /// Success message when routine is saved
  ///
  /// In en, this message translates to:
  /// **'Routine saved successfully!'**
  String get saveRoutineSuccess;

  /// Edit routine title
  ///
  /// In en, this message translates to:
  /// **'Edit Routine'**
  String get editRoutine;

  /// Hint text for routine name field
  ///
  /// In en, this message translates to:
  /// **'e.g. Leg Day, Monday'**
  String get routineNameHint;

  /// Hint text for exercise search
  ///
  /// In en, this message translates to:
  /// **'Search exercises...'**
  String get searchExercises;

  /// Empty state when no search results
  ///
  /// In en, this message translates to:
  /// **'No exercises found'**
  String get noResults;

  /// Empty state when no exercises in routine
  ///
  /// In en, this message translates to:
  /// **'No exercises added yet'**
  String get noExercisesAdded;

  /// Option to add custom exercise name
  ///
  /// In en, this message translates to:
  /// **'Add \'{name}\''**
  String addCustomExercise(String name);

  /// Helper text for exercise search when empty
  ///
  /// In en, this message translates to:
  /// **'Type to search or add...'**
  String get searchHelper;

  /// Empty state when no sets in exercise
  ///
  /// In en, this message translates to:
  /// **'No sets added'**
  String get noSetsAdded;

  /// Label for rest time input field
  ///
  /// In en, this message translates to:
  /// **'Rest Time (seconds)'**
  String get restTimeSeconds;

  /// Confirmation message for removing an exercise
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove {name}?'**
  String removeConfirmation(String name);

  /// Remove action
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// Kilograms unit
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unitKg;

  /// Pounds unit
  ///
  /// In en, this message translates to:
  /// **'lb'**
  String get unitLb;

  /// Repetitions unit
  ///
  /// In en, this message translates to:
  /// **'reps'**
  String get unitReps;

  /// Seconds unit
  ///
  /// In en, this message translates to:
  /// **'s'**
  String get unitSeconds;

  /// Minutes unit
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get unitMinutes;

  /// Kilometers unit
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get unitKm;

  /// Meters unit
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get unitMeters;

  /// No unit
  ///
  /// In en, this message translates to:
  /// **'none'**
  String get unitNone;

  /// Number of sets in exercise
  ///
  /// In en, this message translates to:
  /// **'{count} sets'**
  String setsCount(int count);

  /// Language menu item
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Empty state message when routine has no exercises
  ///
  /// In en, this message translates to:
  /// **'No exercises in this routine'**
  String get noExercisesInRoutine;

  /// Confirmation message for deleting a routine
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this routine?'**
  String get deleteRoutineConfirm;

  /// Delete action
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Label for routines with no exercises
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get emptyRoutine;

  /// Button label for starting a new workout session
  ///
  /// In en, this message translates to:
  /// **'Start New Session'**
  String get startNewSession;

  /// Button label for starting a specific routine by name
  ///
  /// In en, this message translates to:
  /// **'Start {name}'**
  String startRoutineName(String name);

  /// Warning message when trying to start a routine without exercises
  ///
  /// In en, this message translates to:
  /// **'Add exercises first'**
  String get addExercisesFirst;

  /// Confirmation message for deleting a workout session
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this workout session?'**
  String get deleteSessionConfirm;

  /// Success message after deleting a workout session
  ///
  /// In en, this message translates to:
  /// **'Session deleted'**
  String get sessionDeleted;

  /// Rest timer label
  ///
  /// In en, this message translates to:
  /// **'Resting'**
  String get resting;

  /// Add 30 seconds to rest timer action
  ///
  /// In en, this message translates to:
  /// **'+30s'**
  String get add30Seconds;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
