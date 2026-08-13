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
  String get finishWorkoutConfirmation =>
      'Are you sure you want to finish and save this workout?';

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
  String get notes => 'Notes';

  @override
  String get exerciseNotesLabel => 'Notes (optional)';

  @override
  String get exerciseNotesHint => 'e.g. Elliptical or bike';

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
  String get unitLevel => 'level';

  @override
  String get unitIncline => 'incline';

  @override
  String setsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sets',
      one: '1 set',
    );
    return '$_temp0';
  }

  @override
  String get language => 'Language';

  @override
  String get appSkin => 'App Skin';

  @override
  String get skinVolt => 'Volt';

  @override
  String get skinCyan => 'Cyan';

  @override
  String get skinCrimson => 'Crimson';

  @override
  String get skinRoyalGold => 'Royal Gold';

  @override
  String get skinMonochrome => 'Monochrome';

  @override
  String get selectSkin => 'Select App Skin';

  @override
  String get noExercisesInRoutine => 'No exercises in this routine';

  @override
  String get deleteRoutineConfirm =>
      'Are you sure you want to delete this routine?';

  @override
  String get delete => 'Delete';

  @override
  String get routineDeletedSuccess => 'Routine deleted successfully!';

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

  @override
  String get resumeWorkout => 'Resume Current Workout';

  @override
  String routineAlreadyActive(String name) {
    return 'You already have $name in progress. Resuming it.';
  }

  @override
  String get noLogsFound => 'No logs found for this session';

  @override
  String get activeWorkout => 'Active Workout';

  @override
  String get inProgress => 'In progress...';

  @override
  String get completed => 'Completed';

  @override
  String get pendingExercises => 'Pending';

  @override
  String get completedExercises => 'Completed';

  @override
  String get showCompletedExercises => 'Show';

  @override
  String get hideCompletedExercises => 'Hide';

  @override
  String get completedSession => 'Completed Session';

  @override
  String get saveAsRoutineTarget => 'Save as routine target';

  @override
  String get saveAsRoutineTargetSuccess => 'Target updated for future workouts';

  @override
  String get saveAsRoutineTargetError => 'Could not update the routine target';

  @override
  String get editSetValue => 'Edit value';

  @override
  String get saveForToday => 'Save for today';

  @override
  String get saveForTodayDetail => 'Only records the value for this workout';

  @override
  String get updateRoutineTarget => 'Update target';

  @override
  String get updateRoutineTargetDetail =>
      'Changes the target for future workouts';

  @override
  String get errorEmptyName => 'Routine name cannot be empty';

  @override
  String get noRoutinesAvailable => 'No routines available';

  @override
  String get createRoutineToGetStarted => 'Create a routine to get started';

  @override
  String get errorNoExercises => 'Routine must have at least one exercise';

  @override
  String get errorEmptySets => 'Each exercise must have at least one set';

  @override
  String get noSetsDefined => 'No sets defined';

  @override
  String get authAccount => 'Account';

  @override
  String get authAnonymous => 'Anonymous';

  @override
  String get authAnonymousSubtitle =>
      'Your data is stored locally. Link an account to sync.';

  @override
  String get authLinkedWithGoogle => 'Linked with Google';

  @override
  String get authContinueWithGoogle => 'Continue with Google';

  @override
  String get authDisconnectGoogle => 'Disconnect Google';

  @override
  String get authLinkSuccess => 'Account linked successfully!';

  @override
  String get authGoogleSignInConfigurationError =>
      'Google Sign-In is not configured for this release build. Add the release and Play App Signing SHA fingerprints in Firebase.';

  @override
  String get authGoogleSignInTimeout =>
      'Google Sign-In took too long. Please try again.';

  @override
  String get authUnavailable => 'Cloud auth unavailable';

  @override
  String get appInfoSection => 'APP';

  @override
  String get appVersionLabel => 'Version';

  @override
  String get appBuildLabel => 'Build';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get trainingDefaultsSection => 'DEFAULT TRAINING VALUES';

  @override
  String get defaultRest => 'Default rest';

  @override
  String get defaultRepetitions => 'Default reps';

  @override
  String get defaultWeight => 'Default weight';

  @override
  String get autoStartRestTimerOnComplete =>
      'Auto-start rest timer on set completion';

  @override
  String get autoStartRestTimerOnCompleteSubtitle =>
      'When you mark a set as completed, the timer starts automatically';

  @override
  String get restSecondsDialogTitle => 'Rest (seconds)';

  @override
  String get repetitionsDialogTitle => 'Repetitions';

  @override
  String get weightKgDialogTitle => 'Weight (kg)';

  @override
  String get globalManagementSection => 'GLOBAL MANAGEMENT';

  @override
  String get manageExercises => 'Manage exercises';

  @override
  String get manageExercisesSubtitle =>
      'Edit, delete, and create exercises from one place';

  @override
  String get exerciseLibraryTitle => 'Exercise library';

  @override
  String get newLabel => 'New';

  @override
  String get newExerciseTitle => 'New exercise';

  @override
  String get editExerciseTitle => 'Edit exercise';

  @override
  String get deleteExerciseTitle => 'Delete exercise';

  @override
  String deleteExerciseConfirm(String name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String get changesSaved => 'Changes saved';

  @override
  String get exerciseNameHint => 'Exercise name';

  @override
  String get noExercisesToShow => 'No exercises to show';

  @override
  String get customLabel => 'Custom';

  @override
  String get libraryLabel => 'Library';

  @override
  String get syncCloudSection => 'CLOUD SYNC';

  @override
  String get neverSynced => 'Never synced';

  @override
  String get syncing => 'Syncing...';

  @override
  String get globalSyncOverlayTitle => 'Syncing your data';

  @override
  String get globalSyncOverlaySubtitle =>
      'Preparing routines and history from the cloud...';

  @override
  String get routinesSyncingPlaceholder =>
      'Fetching your routines from the cloud...';

  @override
  String get syncPending => 'Sync pending';

  @override
  String get synced => 'Backed up';

  @override
  String get syncLocked => 'Backup off';

  @override
  String lastSync(String date) {
    return 'Last sync: $date';
  }

  @override
  String get linkGoogleForSync =>
      'Link your Google account to enable cloud sync';

  @override
  String get refreshNow => 'Refresh now';

  @override
  String lastTimeValue(String value) {
    return 'Last time: $value';
  }

  @override
  String get exerciseProgressTitle => 'Progress';

  @override
  String get viewProgress => 'View progress';

  @override
  String get noProgressYet =>
      'No records yet. Finish a workout with this exercise to see your progress here.';

  @override
  String progressSessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sessions',
      one: '1 session',
    );
    return '$_temp0';
  }

  @override
  String get helpFeedbackSection => 'Help & feedback';

  @override
  String get sendFeedback => 'Send feedback';

  @override
  String get sendFeedbackSubtitle => 'Suggestions, ideas or report a problem';

  @override
  String get feedbackEmailSubject => 'Muscleup — Feedback';

  @override
  String get feedbackEmailBody => 'Write your feedback, idea or problem here:';

  @override
  String get emailCopiedToClipboard =>
      'Couldn\'t open your email app. The address was copied to your clipboard.';

  @override
  String get legalSection => 'Legal';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get privacyPolicySubtitle => 'How Muscleup handles your data';

  @override
  String privacyPolicyLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Last updated: $dateString';
  }

  @override
  String get privacyPolicyIntro =>
      'Muscleup is a workout tracking app. This policy explains what data the app may collect, how it is used, and what choices you have regarding that data.';

  @override
  String get privacyPolicyDataTitle => 'Data we collect';

  @override
  String get privacyPolicyDataItem1 =>
      'Account information such as name, email address, and user ID.';

  @override
  String get privacyPolicyDataItem2 =>
      'Workout data such as routines, exercises, sets, weight, repetitions, sessions, history, and optional notes you enter in the app.';

  @override
  String get privacyPolicyDataItem3 =>
      'App settings such as language, theme, and workout-related preferences.';

  @override
  String get privacyPolicyCollectionTitle => 'How data is collected';

  @override
  String get privacyPolicyCollectionItem1 =>
      'The app can be used locally without linking an account.';

  @override
  String get privacyPolicyCollectionItem2 =>
      'If you choose to link your account with Google, Muscleup uses Firebase Authentication for sign-in.';

  @override
  String get privacyPolicyCollectionItem3 =>
      'If you choose cloud sync, data is stored in Google Firebase Cloud Firestore and associated with your account.';

  @override
  String get privacyPolicyUsageTitle => 'How we use data';

  @override
  String get privacyPolicyUsageItem1 =>
      'To enable sign-in and account management.';

  @override
  String get privacyPolicyUsageItem2 =>
      'To save, sync, and restore your routines and workout history.';

  @override
  String get privacyPolicyUsageItem3 =>
      'To store your preferences and provide the core app functionality.';

  @override
  String get privacyPolicySharingTitle => 'Data sharing';

  @override
  String get privacyPolicySharingBody =>
      'Muscleup does not sell your data or share it with third parties for advertising or marketing purposes. Data may be processed by infrastructure providers required to run the app, such as Firebase Authentication and Cloud Firestore.';

  @override
  String get privacyPolicySecurityTitle => 'Encryption and security';

  @override
  String get privacyPolicySecurityBody =>
      'Data is transferred over secure encrypted connections. Access to synced data is restricted to the authenticated user who owns it.';

  @override
  String get privacyPolicyRetentionTitle => 'Data retention';

  @override
  String get privacyPolicyRetentionBody =>
      'Data is retained while you keep your account and use cloud synchronization, unless you request deletion. Some minimal technical data may remain temporarily in infrastructure backups for a limited period.';

  @override
  String get privacyPolicyDeletionTitle => 'Account and data deletion';

  @override
  String get privacyPolicyDeletionBody =>
      'You can request deletion of your account and all associated data at any time. The account deletion page lists the full instructions, exactly what gets deleted, and how long it takes. We confirm by email once your data has been deleted.';

  @override
  String get privacyPolicyChildrenTitle => 'Children\'s privacy';

  @override
  String get privacyPolicyChildrenBody =>
      'Muscleup is not specifically directed to children under 13.';

  @override
  String get privacyPolicyContactTitle => 'Contact';

  @override
  String get privacyPolicyContactBody =>
      'If you have questions about this policy, write to us at:';

  @override
  String get privacyPolicyOpenOnline => 'View the online version';

  @override
  String get privacyPolicyAccountDeletionPage =>
      'Open the account deletion page';

  @override
  String get privacyPolicyAccountDeletion => 'Request deletion by email';

  @override
  String get accountDeletionEmailSubject =>
      'Muscleup — Account deletion request';

  @override
  String get accountDeletionEmailBody =>
      'I would like to request the deletion of my Muscleup account and all associated data.';

  @override
  String get couldNotOpenLink => 'Couldn\'t open the link on this device.';

  @override
  String get exitAppTitle => 'Exit Muscleup?';

  @override
  String get exitAppMessage => 'Are you sure you want to close the app?';

  @override
  String get exitAppConfirm => 'Exit';

  @override
  String get importTitle => 'Import routines';

  @override
  String get importHeadline => 'Bring your whole plan in one step';

  @override
  String get importIntro =>
      'Paste your training plan and Muscleup creates every routine, with its exercises, sets, weights, repetitions and notes. Any AI assistant can put your notes into the format the app expects.';

  @override
  String get importStep1 => 'Copy the instructions.';

  @override
  String get importStep2 =>
      'Paste them into an AI chat — ChatGPT, Claude, Gemini — followed by your workout notes, exactly as you have them written.';

  @override
  String get importStep3 =>
      'Copy the reply, paste it below and check it before importing.';

  @override
  String get importCopyInstructions => 'Copy instructions';

  @override
  String get importInstructionsCopied =>
      'Instructions copied. Paste them into an AI chat along with your notes.';

  @override
  String importInstructionsLanguageNote(String language) {
    return 'The instructions are in English because assistants follow them most accurately that way. Your routines come back in $language.';
  }

  @override
  String get importPasteLabel => 'The assistant\'s reply';

  @override
  String get importPasteHint => 'Paste the JSON here';

  @override
  String get importPasteFromClipboard => 'Paste';

  @override
  String get importClipboardEmpty => 'There is nothing to paste.';

  @override
  String get importCheck => 'Check';

  @override
  String get importClear => 'Clear';

  @override
  String get importAction => 'Import';

  @override
  String get importPreviewTitle => 'This is what will be created';

  @override
  String importRoutineSummary(int exerciseCount, int setCount) {
    return 'Exercises: $exerciseCount · Sets: $setCount';
  }

  @override
  String get importNoticesTitle => 'Worth a look';

  @override
  String get importSuccess => 'Routines imported';

  @override
  String get importErrorEmptyInput => 'Paste the assistant\'s reply first.';

  @override
  String get importErrorInvalidJson =>
      'That text is not valid JSON. Copy the reply again including the braces, or ask the assistant to reply with the JSON only.';

  @override
  String get importErrorNoRoutines =>
      'No routines were found in that text. It needs a “routines” list with at least one day that has exercises.';

  @override
  String importNoticeNoExercises(String name) {
    return '“$name” was left out: it has no exercises.';
  }

  @override
  String importNoticeSkippedRoutines(int count) {
    return 'Entries left out for having no name: $count.';
  }

  @override
  String importNoticeSkippedExercises(String name, int count) {
    return 'Exercises left out of “$name” for having no name: $count.';
  }

  @override
  String importNoticeDuplicateName(String name) {
    return 'You already have a routine called “$name”. This one is added as well.';
  }

  @override
  String get importSettingsSubtitle =>
      'Paste a plan and create every routine at once';
}
