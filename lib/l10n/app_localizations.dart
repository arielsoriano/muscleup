import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_vi.dart';

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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('vi')
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

  /// Confirmation message for finishing and saving a workout
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to finish and save this workout?'**
  String get finishWorkoutConfirmation;

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

  /// Generic notes label
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// Label for exercise notes field in routine form
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get exerciseNotesLabel;

  /// Hint for exercise notes field in routine form
  ///
  /// In en, this message translates to:
  /// **'e.g. Elliptical or bike'**
  String get exerciseNotesHint;

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

  /// Machine resistance/difficulty level (e.g. elliptical, bike)
  ///
  /// In en, this message translates to:
  /// **'level'**
  String get unitLevel;

  /// Treadmill or machine incline
  ///
  /// In en, this message translates to:
  /// **'incline'**
  String get unitIncline;

  /// Number of sets in exercise. Written as an ICU plural: languages with more than two plural forms (Russian, Polish, Arabic, Czech...) must supply their own categories (one/few/many/other) when translating, not just the two English needs. Zero never reaches this message; it is handled by noSetsAdded.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 set} other{{count} sets}}'**
  String setsCount(int count);

  /// Language menu item
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// App skin menu item
  ///
  /// In en, this message translates to:
  /// **'App Skin'**
  String get appSkin;

  /// Volt skin name
  ///
  /// In en, this message translates to:
  /// **'Volt'**
  String get skinVolt;

  /// Cyan skin name
  ///
  /// In en, this message translates to:
  /// **'Cyan'**
  String get skinCyan;

  /// Crimson skin name
  ///
  /// In en, this message translates to:
  /// **'Crimson'**
  String get skinCrimson;

  /// Royal Gold skin name
  ///
  /// In en, this message translates to:
  /// **'Royal Gold'**
  String get skinRoyalGold;

  /// Monochrome skin name
  ///
  /// In en, this message translates to:
  /// **'Monochrome'**
  String get skinMonochrome;

  /// Select skin dialog title
  ///
  /// In en, this message translates to:
  /// **'Select App Skin'**
  String get selectSkin;

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

  /// Success message when a routine is deleted
  ///
  /// In en, this message translates to:
  /// **'Routine deleted successfully!'**
  String get routineDeletedSuccess;

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

  /// Label for resuming an incomplete workout session
  ///
  /// In en, this message translates to:
  /// **'Resume Current Workout'**
  String get resumeWorkout;

  /// Message shown when routine already has an active session
  ///
  /// In en, this message translates to:
  /// **'You already have {name} in progress. Resuming it.'**
  String routineAlreadyActive(String name);

  /// Message when workout session has no set logs
  ///
  /// In en, this message translates to:
  /// **'No logs found for this session'**
  String get noLogsFound;

  /// Label for currently active workout
  ///
  /// In en, this message translates to:
  /// **'Active Workout'**
  String get activeWorkout;

  /// Status text for incomplete workout session
  ///
  /// In en, this message translates to:
  /// **'In progress...'**
  String get inProgress;

  /// Status label for a finished session
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @pendingExercises.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingExercises;

  /// No description provided for @completedExercises.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedExercises;

  /// No description provided for @showCompletedExercises.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get showCompletedExercises;

  /// No description provided for @hideCompletedExercises.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hideCompletedExercises;

  /// Header label indicating a workout session is already finished
  ///
  /// In en, this message translates to:
  /// **'Completed Session'**
  String get completedSession;

  /// Action to save current set values as future routine targets
  ///
  /// In en, this message translates to:
  /// **'Save as routine target'**
  String get saveAsRoutineTarget;

  /// Success message when current set values are saved as routine targets
  ///
  /// In en, this message translates to:
  /// **'Target updated for future workouts'**
  String get saveAsRoutineTargetSuccess;

  /// Error message when saving current set values as routine targets fails
  ///
  /// In en, this message translates to:
  /// **'Could not update the routine target'**
  String get saveAsRoutineTargetError;

  /// Title of the bottom sheet modal for editing a set value
  ///
  /// In en, this message translates to:
  /// **'Edit value'**
  String get editSetValue;

  /// Button label to save the actual value for today's session only
  ///
  /// In en, this message translates to:
  /// **'Save for today'**
  String get saveForToday;

  /// Subtitle explaining that saving for today does not affect the routine target
  ///
  /// In en, this message translates to:
  /// **'Only records the value for this workout'**
  String get saveForTodayDetail;

  /// Button label to update the routine target permanently
  ///
  /// In en, this message translates to:
  /// **'Update target'**
  String get updateRoutineTarget;

  /// Subtitle explaining that updating the target affects all future workouts
  ///
  /// In en, this message translates to:
  /// **'Changes the target for future workouts'**
  String get updateRoutineTargetDetail;

  /// Error message when routine name is empty
  ///
  /// In en, this message translates to:
  /// **'Routine name cannot be empty'**
  String get errorEmptyName;

  /// Empty state message when no routines exist
  ///
  /// In en, this message translates to:
  /// **'No routines available'**
  String get noRoutinesAvailable;

  /// Helper text for creating first routine
  ///
  /// In en, this message translates to:
  /// **'Create a routine to get started'**
  String get createRoutineToGetStarted;

  /// Error message when routine has no exercises
  ///
  /// In en, this message translates to:
  /// **'Routine must have at least one exercise'**
  String get errorNoExercises;

  /// Error message when an exercise has no sets
  ///
  /// In en, this message translates to:
  /// **'Each exercise must have at least one set'**
  String get errorEmptySets;

  /// Message when an exercise has no sets
  ///
  /// In en, this message translates to:
  /// **'No sets defined'**
  String get noSetsDefined;

  /// Account section header in settings
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get authAccount;

  /// Label for anonymous auth state
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get authAnonymous;

  /// Subtitle shown under anonymous state
  ///
  /// In en, this message translates to:
  /// **'Your data is stored locally. Link an account to sync.'**
  String get authAnonymousSubtitle;

  /// Label when account is linked with Google
  ///
  /// In en, this message translates to:
  /// **'Linked with Google'**
  String get authLinkedWithGoogle;

  /// Button to link Google account
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authContinueWithGoogle;

  /// Button to unlink Google account
  ///
  /// In en, this message translates to:
  /// **'Disconnect Google'**
  String get authDisconnectGoogle;

  /// Success message after linking Google account
  ///
  /// In en, this message translates to:
  /// **'Account linked successfully!'**
  String get authLinkSuccess;

  /// Error shown when Google Sign-In fails because Android release OAuth fingerprints are missing
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In is not configured for this release build. Add the release and Play App Signing SHA fingerprints in Firebase.'**
  String get authGoogleSignInConfigurationError;

  /// Error shown when Google Sign-In does not complete within the timeout
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In took too long. Please try again.'**
  String get authGoogleSignInTimeout;

  /// Message when Firebase is not configured
  ///
  /// In en, this message translates to:
  /// **'Cloud auth unavailable'**
  String get authUnavailable;

  /// Section header for app information in settings
  ///
  /// In en, this message translates to:
  /// **'APP'**
  String get appInfoSection;

  /// Label for the app version value
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get appVersionLabel;

  /// Label for the app build number value
  ///
  /// In en, this message translates to:
  /// **'Build'**
  String get appBuildLabel;

  /// Dark mode toggle label
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @trainingDefaultsSection.
  ///
  /// In en, this message translates to:
  /// **'DEFAULT TRAINING VALUES'**
  String get trainingDefaultsSection;

  /// No description provided for @defaultRest.
  ///
  /// In en, this message translates to:
  /// **'Default rest'**
  String get defaultRest;

  /// No description provided for @defaultRepetitions.
  ///
  /// In en, this message translates to:
  /// **'Default reps'**
  String get defaultRepetitions;

  /// No description provided for @defaultWeight.
  ///
  /// In en, this message translates to:
  /// **'Default weight'**
  String get defaultWeight;

  /// No description provided for @autoStartRestTimerOnComplete.
  ///
  /// In en, this message translates to:
  /// **'Auto-start rest timer on set completion'**
  String get autoStartRestTimerOnComplete;

  /// No description provided for @autoStartRestTimerOnCompleteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'When you mark a set as completed, the timer starts automatically'**
  String get autoStartRestTimerOnCompleteSubtitle;

  /// No description provided for @restSecondsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Rest (seconds)'**
  String get restSecondsDialogTitle;

  /// No description provided for @repetitionsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Repetitions'**
  String get repetitionsDialogTitle;

  /// No description provided for @weightKgDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightKgDialogTitle;

  /// No description provided for @globalManagementSection.
  ///
  /// In en, this message translates to:
  /// **'GLOBAL MANAGEMENT'**
  String get globalManagementSection;

  /// No description provided for @manageExercises.
  ///
  /// In en, this message translates to:
  /// **'Manage exercises'**
  String get manageExercises;

  /// No description provided for @manageExercisesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Edit, delete, and create exercises from one place'**
  String get manageExercisesSubtitle;

  /// No description provided for @exerciseLibraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Exercise library'**
  String get exerciseLibraryTitle;

  /// No description provided for @newLabel.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newLabel;

  /// No description provided for @newExerciseTitle.
  ///
  /// In en, this message translates to:
  /// **'New exercise'**
  String get newExerciseTitle;

  /// No description provided for @editExerciseTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit exercise'**
  String get editExerciseTitle;

  /// No description provided for @deleteExerciseTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete exercise'**
  String get deleteExerciseTitle;

  /// No description provided for @deleteExerciseConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {name}?'**
  String deleteExerciseConfirm(String name);

  /// No description provided for @changesSaved.
  ///
  /// In en, this message translates to:
  /// **'Changes saved'**
  String get changesSaved;

  /// No description provided for @exerciseNameHint.
  ///
  /// In en, this message translates to:
  /// **'Exercise name'**
  String get exerciseNameHint;

  /// No description provided for @noExercisesToShow.
  ///
  /// In en, this message translates to:
  /// **'No exercises to show'**
  String get noExercisesToShow;

  /// No description provided for @customLabel.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customLabel;

  /// No description provided for @libraryLabel.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryLabel;

  /// No description provided for @syncCloudSection.
  ///
  /// In en, this message translates to:
  /// **'CLOUD SYNC'**
  String get syncCloudSection;

  /// No description provided for @neverSynced.
  ///
  /// In en, this message translates to:
  /// **'Never synced'**
  String get neverSynced;

  /// No description provided for @syncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get syncing;

  /// No description provided for @globalSyncOverlayTitle.
  ///
  /// In en, this message translates to:
  /// **'Syncing your data'**
  String get globalSyncOverlayTitle;

  /// No description provided for @globalSyncOverlaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Preparing routines and history from the cloud...'**
  String get globalSyncOverlaySubtitle;

  /// No description provided for @routinesSyncingPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Fetching your routines from the cloud...'**
  String get routinesSyncingPlaceholder;

  /// No description provided for @syncPending.
  ///
  /// In en, this message translates to:
  /// **'Sync pending'**
  String get syncPending;

  /// No description provided for @synced.
  ///
  /// In en, this message translates to:
  /// **'Backed up'**
  String get synced;

  /// No description provided for @syncLocked.
  ///
  /// In en, this message translates to:
  /// **'Backup off'**
  String get syncLocked;

  /// No description provided for @lastSync.
  ///
  /// In en, this message translates to:
  /// **'Last sync: {date}'**
  String lastSync(String date);

  /// No description provided for @linkGoogleForSync.
  ///
  /// In en, this message translates to:
  /// **'Link your Google account to enable cloud sync'**
  String get linkGoogleForSync;

  /// No description provided for @refreshNow.
  ///
  /// In en, this message translates to:
  /// **'Refresh now'**
  String get refreshNow;

  /// Reference showing what was performed for this set in the previous session
  ///
  /// In en, this message translates to:
  /// **'Last time: {value}'**
  String lastTimeValue(String value);

  /// No description provided for @exerciseProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get exerciseProgressTitle;

  /// No description provided for @viewProgress.
  ///
  /// In en, this message translates to:
  /// **'View progress'**
  String get viewProgress;

  /// No description provided for @noProgressYet.
  ///
  /// In en, this message translates to:
  /// **'No records yet. Finish a workout with this exercise to see your progress here.'**
  String get noProgressYet;

  /// No description provided for @progressSessionsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 session} other{{count} sessions}}'**
  String progressSessionsCount(int count);

  /// No description provided for @helpFeedbackSection.
  ///
  /// In en, this message translates to:
  /// **'Help & feedback'**
  String get helpFeedbackSection;

  /// No description provided for @sendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send feedback'**
  String get sendFeedback;

  /// No description provided for @sendFeedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Suggestions, ideas or report a problem'**
  String get sendFeedbackSubtitle;

  /// No description provided for @feedbackEmailSubject.
  ///
  /// In en, this message translates to:
  /// **'Muscleup — Feedback'**
  String get feedbackEmailSubject;

  /// No description provided for @feedbackEmailBody.
  ///
  /// In en, this message translates to:
  /// **'Write your feedback, idea or problem here:'**
  String get feedbackEmailBody;

  /// No description provided for @emailCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open your email app. The address was copied to your clipboard.'**
  String get emailCopiedToClipboard;

  /// No description provided for @legalSection.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get legalSection;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicySubtitle.
  ///
  /// In en, this message translates to:
  /// **'How Muscleup handles your data'**
  String get privacyPolicySubtitle;

  /// No description provided for @privacyPolicyLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: {date}'**
  String privacyPolicyLastUpdated(DateTime date);

  /// No description provided for @privacyPolicyIntro.
  ///
  /// In en, this message translates to:
  /// **'Muscleup is a workout tracking app. This policy explains what data the app may collect, how it is used, and what choices you have regarding that data.'**
  String get privacyPolicyIntro;

  /// No description provided for @privacyPolicyDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Data we collect'**
  String get privacyPolicyDataTitle;

  /// No description provided for @privacyPolicyDataItem1.
  ///
  /// In en, this message translates to:
  /// **'Account information such as name, email address, and user ID.'**
  String get privacyPolicyDataItem1;

  /// No description provided for @privacyPolicyDataItem2.
  ///
  /// In en, this message translates to:
  /// **'Workout data such as routines, exercises, sets, weight, repetitions, sessions, history, and optional notes you enter in the app.'**
  String get privacyPolicyDataItem2;

  /// No description provided for @privacyPolicyDataItem3.
  ///
  /// In en, this message translates to:
  /// **'App settings such as language, theme, and workout-related preferences.'**
  String get privacyPolicyDataItem3;

  /// No description provided for @privacyPolicyCollectionTitle.
  ///
  /// In en, this message translates to:
  /// **'How data is collected'**
  String get privacyPolicyCollectionTitle;

  /// No description provided for @privacyPolicyCollectionItem1.
  ///
  /// In en, this message translates to:
  /// **'The app can be used locally without linking an account.'**
  String get privacyPolicyCollectionItem1;

  /// No description provided for @privacyPolicyCollectionItem2.
  ///
  /// In en, this message translates to:
  /// **'If you choose to link your account with Google, Muscleup uses Firebase Authentication for sign-in.'**
  String get privacyPolicyCollectionItem2;

  /// No description provided for @privacyPolicyCollectionItem3.
  ///
  /// In en, this message translates to:
  /// **'If you choose cloud sync, data is stored in Google Firebase Cloud Firestore and associated with your account.'**
  String get privacyPolicyCollectionItem3;

  /// No description provided for @privacyPolicyUsageTitle.
  ///
  /// In en, this message translates to:
  /// **'How we use data'**
  String get privacyPolicyUsageTitle;

  /// No description provided for @privacyPolicyUsageItem1.
  ///
  /// In en, this message translates to:
  /// **'To enable sign-in and account management.'**
  String get privacyPolicyUsageItem1;

  /// No description provided for @privacyPolicyUsageItem2.
  ///
  /// In en, this message translates to:
  /// **'To save, sync, and restore your routines and workout history.'**
  String get privacyPolicyUsageItem2;

  /// No description provided for @privacyPolicyUsageItem3.
  ///
  /// In en, this message translates to:
  /// **'To store your preferences and provide the core app functionality.'**
  String get privacyPolicyUsageItem3;

  /// No description provided for @privacyPolicySharingTitle.
  ///
  /// In en, this message translates to:
  /// **'Data sharing'**
  String get privacyPolicySharingTitle;

  /// No description provided for @privacyPolicySharingBody.
  ///
  /// In en, this message translates to:
  /// **'Muscleup does not sell your data or share it with third parties for advertising or marketing purposes. Data may be processed by infrastructure providers required to run the app, such as Firebase Authentication and Cloud Firestore.'**
  String get privacyPolicySharingBody;

  /// No description provided for @privacyPolicySecurityTitle.
  ///
  /// In en, this message translates to:
  /// **'Encryption and security'**
  String get privacyPolicySecurityTitle;

  /// No description provided for @privacyPolicySecurityBody.
  ///
  /// In en, this message translates to:
  /// **'Data is transferred over secure encrypted connections. Access to synced data is restricted to the authenticated user who owns it.'**
  String get privacyPolicySecurityBody;

  /// No description provided for @privacyPolicyRetentionTitle.
  ///
  /// In en, this message translates to:
  /// **'Data retention'**
  String get privacyPolicyRetentionTitle;

  /// No description provided for @privacyPolicyRetentionBody.
  ///
  /// In en, this message translates to:
  /// **'Data is retained while you keep your account and use cloud synchronization, unless you request deletion. Some minimal technical data may remain temporarily in infrastructure backups for a limited period.'**
  String get privacyPolicyRetentionBody;

  /// No description provided for @privacyPolicyDeletionTitle.
  ///
  /// In en, this message translates to:
  /// **'Account and data deletion'**
  String get privacyPolicyDeletionTitle;

  /// No description provided for @privacyPolicyDeletionBody.
  ///
  /// In en, this message translates to:
  /// **'You can request deletion of your account and all associated data at any time. The account deletion page lists the full instructions, exactly what gets deleted, and how long it takes. We confirm by email once your data has been deleted.'**
  String get privacyPolicyDeletionBody;

  /// No description provided for @privacyPolicyChildrenTitle.
  ///
  /// In en, this message translates to:
  /// **'Children\'s privacy'**
  String get privacyPolicyChildrenTitle;

  /// No description provided for @privacyPolicyChildrenBody.
  ///
  /// In en, this message translates to:
  /// **'Muscleup is not specifically directed to children under 13.'**
  String get privacyPolicyChildrenBody;

  /// No description provided for @privacyPolicyContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get privacyPolicyContactTitle;

  /// No description provided for @privacyPolicyContactBody.
  ///
  /// In en, this message translates to:
  /// **'If you have questions about this policy, write to us at:'**
  String get privacyPolicyContactBody;

  /// No description provided for @privacyPolicyOpenOnline.
  ///
  /// In en, this message translates to:
  /// **'View the online version'**
  String get privacyPolicyOpenOnline;

  /// No description provided for @privacyPolicyAccountDeletionPage.
  ///
  /// In en, this message translates to:
  /// **'Open the account deletion page'**
  String get privacyPolicyAccountDeletionPage;

  /// No description provided for @privacyPolicyAccountDeletion.
  ///
  /// In en, this message translates to:
  /// **'Request deletion by email'**
  String get privacyPolicyAccountDeletion;

  /// No description provided for @accountDeletionEmailSubject.
  ///
  /// In en, this message translates to:
  /// **'Muscleup — Account deletion request'**
  String get accountDeletionEmailSubject;

  /// No description provided for @accountDeletionEmailBody.
  ///
  /// In en, this message translates to:
  /// **'I would like to request the deletion of my Muscleup account and all associated data.'**
  String get accountDeletionEmailBody;

  /// No description provided for @couldNotOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the link on this device.'**
  String get couldNotOpenLink;

  /// No description provided for @exitAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Exit Muscleup?'**
  String get exitAppTitle;

  /// No description provided for @exitAppMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to close the app?'**
  String get exitAppMessage;

  /// No description provided for @exitAppConfirm.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exitAppConfirm;

  /// Title of the routine import screen
  ///
  /// In en, this message translates to:
  /// **'Import routines'**
  String get importTitle;

  /// Headline on the routine import screen
  ///
  /// In en, this message translates to:
  /// **'Bring your whole plan in one step'**
  String get importHeadline;

  /// Explains what the routine import does
  ///
  /// In en, this message translates to:
  /// **'Paste your training plan and Muscleup creates every routine, with its exercises, sets, weights, repetitions and notes. Any AI assistant can put your notes into the format the app expects.'**
  String get importIntro;

  /// First step of the import instructions
  ///
  /// In en, this message translates to:
  /// **'Copy the instructions.'**
  String get importStep1;

  /// Second step of the import instructions
  ///
  /// In en, this message translates to:
  /// **'Paste them into an AI chat — ChatGPT, Claude, Gemini — followed by your workout notes, exactly as you have them written.'**
  String get importStep2;

  /// Third step of the import instructions
  ///
  /// In en, this message translates to:
  /// **'Copy the reply, paste it below and check it before importing.'**
  String get importStep3;

  /// Copies the AI prompt to the clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy instructions'**
  String get importCopyInstructions;

  /// Confirmation that the prompt was copied
  ///
  /// In en, this message translates to:
  /// **'Instructions copied. Paste them into an AI chat along with your notes.'**
  String get importInstructionsCopied;

  /// Explains why the copied prompt is in English
  ///
  /// In en, this message translates to:
  /// **'The instructions are in English because assistants follow them most accurately that way. Your routines come back in {language}.'**
  String importInstructionsLanguageNote(String language);

  /// Label above the paste field
  ///
  /// In en, this message translates to:
  /// **'The assistant\'s reply'**
  String get importPasteLabel;

  /// Hint inside the paste field
  ///
  /// In en, this message translates to:
  /// **'Paste the JSON here'**
  String get importPasteHint;

  /// Pastes the clipboard into the field
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get importPasteFromClipboard;

  /// Shown when the clipboard has no text
  ///
  /// In en, this message translates to:
  /// **'There is nothing to paste.'**
  String get importClipboardEmpty;

  /// Checks the pasted text before importing
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get importCheck;

  /// Empties the paste field
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get importClear;

  /// Confirms the import
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importAction;

  /// Heading above the routines about to be created
  ///
  /// In en, this message translates to:
  /// **'This is what will be created'**
  String get importPreviewTitle;

  /// Exercise and set totals of a routine about to be imported
  ///
  /// In en, this message translates to:
  /// **'Exercises: {exerciseCount} · Sets: {setCount}'**
  String importRoutineSummary(int exerciseCount, int setCount);

  /// Heading above the import warnings
  ///
  /// In en, this message translates to:
  /// **'Worth a look'**
  String get importNoticesTitle;

  /// Confirmation that the routines were imported
  ///
  /// In en, this message translates to:
  /// **'Routines imported'**
  String get importSuccess;

  /// Shown when nothing was pasted
  ///
  /// In en, this message translates to:
  /// **'Paste the assistant\'s reply first.'**
  String get importErrorEmptyInput;

  /// Shown when the pasted text is not valid JSON
  ///
  /// In en, this message translates to:
  /// **'That text is not valid JSON. Copy the reply again including the braces, or ask the assistant to reply with the JSON only.'**
  String get importErrorInvalidJson;

  /// Shown when the JSON contains no routines
  ///
  /// In en, this message translates to:
  /// **'No routines were found in that text. It needs a “routines” list with at least one day that has exercises.'**
  String get importErrorNoRoutines;

  /// Warning that a day was skipped for having no exercises
  ///
  /// In en, this message translates to:
  /// **'“{name}” was left out: it has no exercises.'**
  String importNoticeNoExercises(String name);

  /// Warning that unnamed routines were skipped
  ///
  /// In en, this message translates to:
  /// **'Entries left out for having no name: {count}.'**
  String importNoticeSkippedRoutines(int count);

  /// Warning that unnamed exercises were skipped from a routine
  ///
  /// In en, this message translates to:
  /// **'Exercises left out of “{name}” for having no name: {count}.'**
  String importNoticeSkippedExercises(String name, int count);

  /// Warning that a routine with the same name already exists
  ///
  /// In en, this message translates to:
  /// **'You already have a routine called “{name}”. This one is added as well.'**
  String importNoticeDuplicateName(String name);

  /// Subtitle of the import entry in settings
  ///
  /// In en, this message translates to:
  /// **'Paste a plan and create every routine at once'**
  String get importSettingsSubtitle;

  /// Title of the export routines screen
  ///
  /// In en, this message translates to:
  /// **'Export routines'**
  String get exportTitle;

  /// Subtitle of the export entry in settings
  ///
  /// In en, this message translates to:
  /// **'Save a copy you can paste back in'**
  String get exportSettingsSubtitle;

  /// Explains what the exported JSON is and what pasting it back does
  ///
  /// In en, this message translates to:
  /// **'These are all your routines, in the same format the import screen reads. Keep it in a note or a file: pasting it back recreates them with their exercises, sets, weights and notes, here or on a new phone.'**
  String get exportIntro;

  /// Warns that logged workout history is not part of the export
  ///
  /// In en, this message translates to:
  /// **'Logged workouts are not included — this is your routines only.'**
  String get exportHistoryNote;

  /// Totals of what the export contains
  ///
  /// In en, this message translates to:
  /// **'Routines: {routineCount} · Exercises: {exerciseCount} · Sets: {setCount}'**
  String exportSummary(int routineCount, int exerciseCount, int setCount);

  /// Button that copies the exported JSON to the clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy JSON'**
  String get exportCopy;

  /// Confirmation shown after the export is copied
  ///
  /// In en, this message translates to:
  /// **'Routines copied. Paste them somewhere you can keep.'**
  String get exportCopied;

  /// Shown when the user has no routines to export
  ///
  /// In en, this message translates to:
  /// **'You have no routines to export yet.'**
  String get exportEmpty;

  /// Shown when the routines could not be read for export
  ///
  /// In en, this message translates to:
  /// **'Your routines could not be read. Try again.'**
  String get exportError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'id',
        'it',
        'nl',
        'pl',
        'pt',
        'ru',
        'tr',
        'vi'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
