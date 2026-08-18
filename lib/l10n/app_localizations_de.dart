// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Muscleup';

  @override
  String get workouts => 'Workouts';

  @override
  String get exercises => 'Übungen';

  @override
  String get history => 'Verlauf';

  @override
  String get settings => 'Einstellungen';

  @override
  String get routines => 'Routinen';

  @override
  String get sets => 'Sätze';

  @override
  String get weight => 'Gewicht';

  @override
  String get reps => 'Wdh.';

  @override
  String get addRoutine => 'Routine hinzufügen';

  @override
  String get addExercise => 'Übung hinzufügen';

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get back => 'Zurück';

  @override
  String get routineDetailsTitle => 'Routine-Details';

  @override
  String get noRoutines => 'Keine Routinen gefunden';

  @override
  String get errorLoading => 'Fehler beim Laden der Routinen';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get dashboardTitle => 'Übersicht';

  @override
  String get today => 'Heute';

  @override
  String get noWorkoutToday => 'Für diesen Tag ist kein Training erfasst';

  @override
  String get startWorkout => 'Routine starten';

  @override
  String get finishWorkout => 'Training beenden';

  @override
  String get workoutSavedSuccess => 'Training gespeichert!';

  @override
  String get finishWorkoutConfirmation =>
      'Möchtest du dieses Training wirklich beenden und speichern?';

  @override
  String get activeWorkoutTitle => 'Laufendes Training';

  @override
  String get set => 'Satz';

  @override
  String get target => 'Ziel';

  @override
  String get actual => 'Ist';

  @override
  String get routineName => 'Name der Routine';

  @override
  String get exerciseName => 'Name der Übung';

  @override
  String get notes => 'Notizen';

  @override
  String get exerciseNotesLabel => 'Notizen (optional)';

  @override
  String get exerciseNotesHint => 'z. B. Crosstrainer oder Rad';

  @override
  String get removeExercise => 'Übung entfernen';

  @override
  String get addSet => 'Satz hinzufügen';

  @override
  String get saveRoutineSuccess => 'Routine gespeichert!';

  @override
  String get editRoutine => 'Routine bearbeiten';

  @override
  String get routineNameHint => 'z. B. Beintag, Montag';

  @override
  String get searchExercises => 'Übungen suchen ...';

  @override
  String get noResults => 'Keine Übungen gefunden';

  @override
  String get noExercisesAdded => 'Noch keine Übungen hinzugefügt';

  @override
  String addCustomExercise(String name) {
    return '\'$name\' hinzufügen';
  }

  @override
  String get searchHelper => 'Tippen zum Suchen oder Hinzufügen ...';

  @override
  String get noSetsAdded => 'Keine Sätze hinzugefügt';

  @override
  String get restTimeSeconds => 'Pause (Sekunden)';

  @override
  String removeConfirmation(String name) {
    return 'Möchtest du $name wirklich entfernen?';
  }

  @override
  String get remove => 'Entfernen';

  @override
  String get unitKg => 'kg';

  @override
  String get unitLb => 'lb';

  @override
  String get unitReps => 'Wdh.';

  @override
  String get unitSeconds => 's';

  @override
  String get unitMinutes => 'Min.';

  @override
  String get unitKm => 'km';

  @override
  String get unitMeters => 'm';

  @override
  String get unitNone => 'keine';

  @override
  String get unitLevel => 'Stufe';

  @override
  String get unitIncline => 'Steigung';

  @override
  String setsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Sätze',
      one: '1 Satz',
    );
    return '$_temp0';
  }

  @override
  String get language => 'Sprache';

  @override
  String get appSkin => 'App-Design';

  @override
  String get skinVolt => 'Volt';

  @override
  String get skinCyan => 'Cyan';

  @override
  String get skinCrimson => 'Karmesin';

  @override
  String get skinRoyalGold => 'Königsgold';

  @override
  String get skinMonochrome => 'Monochrom';

  @override
  String get selectSkin => 'App-Design wählen';

  @override
  String get noExercisesInRoutine => 'Keine Übungen in dieser Routine';

  @override
  String get deleteRoutineConfirm =>
      'Möchtest du diese Routine wirklich löschen?';

  @override
  String get delete => 'Löschen';

  @override
  String get routineDeletedSuccess => 'Routine gelöscht!';

  @override
  String get emptyRoutine => 'Leer';

  @override
  String get startNewSession => 'Neue Einheit starten';

  @override
  String startRoutineName(String name) {
    return '$name starten';
  }

  @override
  String get addExercisesFirst => 'Füge zuerst Übungen hinzu';

  @override
  String get deleteSessionConfirm =>
      'Möchtest du diese Trainingseinheit wirklich löschen?';

  @override
  String get sessionDeleted => 'Einheit gelöscht';

  @override
  String get resting => 'Pause';

  @override
  String get add30Seconds => '+30 s';

  @override
  String get resumeWorkout => 'Laufendes Training fortsetzen';

  @override
  String routineAlreadyActive(String name) {
    return '$name läuft bereits. Wird fortgesetzt.';
  }

  @override
  String get noLogsFound => 'Keine Einträge für diese Einheit';

  @override
  String get activeWorkout => 'Laufendes Training';

  @override
  String get inProgress => 'Läuft ...';

  @override
  String get completed => 'Abgeschlossen';

  @override
  String get pendingExercises => 'Offen';

  @override
  String get completedExercises => 'Erledigt';

  @override
  String get showCompletedExercises => 'Zeigen';

  @override
  String get hideCompletedExercises => 'Ausblenden';

  @override
  String get completedSession => 'Abgeschlossene Einheit';

  @override
  String get saveAsRoutineTarget => 'Als Ziel der Routine speichern';

  @override
  String get saveAsRoutineTargetSuccess =>
      'Ziel für künftige Trainings aktualisiert';

  @override
  String get saveAsRoutineTargetError =>
      'Das Ziel der Routine konnte nicht aktualisiert werden';

  @override
  String get editSetValue => 'Wert bearbeiten';

  @override
  String get saveForToday => 'Für heute speichern';

  @override
  String get saveForTodayDetail => 'Erfasst den Wert nur für dieses Training';

  @override
  String get updateRoutineTarget => 'Ziel aktualisieren';

  @override
  String get updateRoutineTargetDetail =>
      'Ändert das Ziel für künftige Trainings';

  @override
  String get errorEmptyName => 'Der Name der Routine darf nicht leer sein';

  @override
  String get noRoutinesAvailable => 'Keine Routinen vorhanden';

  @override
  String get createRoutineToGetStarted =>
      'Erstelle eine Routine, um loszulegen';

  @override
  String get errorNoExercises => 'Eine Routine braucht mindestens eine Übung';

  @override
  String get errorEmptySets => 'Jede Übung braucht mindestens einen Satz';

  @override
  String get noSetsDefined => 'Keine Sätze festgelegt';

  @override
  String get authAccount => 'Konto';

  @override
  String get authAnonymous => 'Anonym';

  @override
  String get authAnonymousSubtitle =>
      'Deine Daten liegen nur auf diesem Gerät. Verknüpfe ein Konto, um zu synchronisieren.';

  @override
  String get authLinkedWithGoogle => 'Mit Google verknüpft';

  @override
  String get authContinueWithGoogle => 'Mit Google fortfahren';

  @override
  String get authDisconnectGoogle => 'Google trennen';

  @override
  String get authLinkSuccess => 'Konto erfolgreich verknüpft!';

  @override
  String get authGoogleSignInConfigurationError =>
      'Die Google-Anmeldung ist für diesen Release-Build nicht konfiguriert. Trage die SHA-Fingerabdrücke für Release und Play App Signing in Firebase ein.';

  @override
  String get authGoogleSignInTimeout =>
      'Die Google-Anmeldung hat zu lange gedauert. Bitte versuche es erneut.';

  @override
  String get authUnavailable => 'Cloud-Anmeldung nicht verfügbar';

  @override
  String get appInfoSection => 'APP';

  @override
  String get appVersionLabel => 'Version';

  @override
  String get appBuildLabel => 'Build';

  @override
  String get darkMode => 'Dunkelmodus';

  @override
  String get trainingDefaultsSection => 'STANDARDWERTE FÜRS TRAINING';

  @override
  String get defaultRest => 'Standardpause';

  @override
  String get defaultRepetitions => 'Standard-Wdh.';

  @override
  String get defaultWeight => 'Standardgewicht';

  @override
  String get autoStartRestTimerOnComplete =>
      'Pause nach erledigtem Satz automatisch starten';

  @override
  String get autoStartRestTimerOnCompleteSubtitle =>
      'Sobald du einen Satz als erledigt markierst, läuft der Timer los';

  @override
  String get restSecondsDialogTitle => 'Pause (Sekunden)';

  @override
  String get repetitionsDialogTitle => 'Wiederholungen';

  @override
  String get weightKgDialogTitle => 'Gewicht (kg)';

  @override
  String get globalManagementSection => 'ALLGEMEINE VERWALTUNG';

  @override
  String get manageExercises => 'Übungen verwalten';

  @override
  String get manageExercisesSubtitle =>
      'Übungen an einem Ort anlegen, bearbeiten und löschen';

  @override
  String get exerciseLibraryTitle => 'Übungsbibliothek';

  @override
  String get newLabel => 'Neu';

  @override
  String get newExerciseTitle => 'Neue Übung';

  @override
  String get editExerciseTitle => 'Übung bearbeiten';

  @override
  String get deleteExerciseTitle => 'Übung löschen';

  @override
  String deleteExerciseConfirm(String name) {
    return 'Möchtest du $name wirklich löschen?';
  }

  @override
  String get changesSaved => 'Änderungen gespeichert';

  @override
  String get exerciseNameHint => 'Name der Übung';

  @override
  String get noExercisesToShow => 'Keine Übungen vorhanden';

  @override
  String get customLabel => 'Eigene';

  @override
  String get libraryLabel => 'Bibliothek';

  @override
  String get syncCloudSection => 'CLOUD-SYNC';

  @override
  String get neverSynced => 'Nie synchronisiert';

  @override
  String get syncing => 'Wird synchronisiert ...';

  @override
  String get globalSyncOverlayTitle => 'Deine Daten werden synchronisiert';

  @override
  String get globalSyncOverlaySubtitle =>
      'Routinen und Verlauf werden aus der Cloud geladen ...';

  @override
  String get routinesSyncingPlaceholder =>
      'Deine Routinen werden aus der Cloud geladen ...';

  @override
  String get syncPending => 'Sync ausstehend';

  @override
  String get synced => 'Gesichert';

  @override
  String get syncLocked => 'Sicherung aus';

  @override
  String lastSync(String date) {
    return 'Zuletzt synchronisiert: $date';
  }

  @override
  String get linkGoogleForSync =>
      'Verknüpfe dein Google-Konto, um die Cloud-Synchronisierung zu aktivieren';

  @override
  String get refreshNow => 'Jetzt aktualisieren';

  @override
  String lastTimeValue(String value) {
    return 'Letztes Mal: $value';
  }

  @override
  String get exerciseProgressTitle => 'Fortschritt';

  @override
  String get viewProgress => 'Fortschritt ansehen';

  @override
  String get noProgressYet =>
      'Noch keine Einträge. Beende ein Training mit dieser Übung, um deinen Fortschritt hier zu sehen.';

  @override
  String progressSessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Einheiten',
      one: '1 Einheit',
    );
    return '$_temp0';
  }

  @override
  String get helpFeedbackSection => 'Hilfe und Feedback';

  @override
  String get sendFeedback => 'Feedback senden';

  @override
  String get sendFeedbackSubtitle =>
      'Vorschläge, Ideen oder ein Problem melden';

  @override
  String get feedbackEmailSubject => 'Muscleup — Feedback';

  @override
  String get feedbackEmailBody =>
      'Schreibe hier dein Feedback, deine Idee oder dein Problem:';

  @override
  String get emailCopiedToClipboard =>
      'Deine E-Mail-App konnte nicht geöffnet werden. Die Adresse wurde in die Zwischenablage kopiert.';

  @override
  String get legalSection => 'Rechtliches';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get privacyPolicySubtitle => 'Wie Muscleup mit deinen Daten umgeht';

  @override
  String privacyPolicyLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Zuletzt aktualisiert: $dateString';
  }

  @override
  String get privacyPolicyIntro =>
      'Muscleup ist eine App zum Aufzeichnen von Trainings. Diese Erklärung beschreibt, welche Daten die App erheben kann, wofür sie verwendet werden und welche Wahlmöglichkeiten du dabei hast.';

  @override
  String get privacyPolicyDataTitle => 'Daten, die wir erheben';

  @override
  String get privacyPolicyDataItem1 =>
      'Kontodaten wie Name, E-Mail-Adresse und Nutzer-ID.';

  @override
  String get privacyPolicyDataItem2 =>
      'Trainingsdaten wie Routinen, Übungen, Sätze, Gewicht, Wiederholungen, Einheiten, Verlauf und optionale Notizen, die du in der App einträgst.';

  @override
  String get privacyPolicyDataItem3 =>
      'App-Einstellungen wie Sprache, Design und trainingsbezogene Vorlieben.';

  @override
  String get privacyPolicyCollectionTitle => 'Wie Daten erhoben werden';

  @override
  String get privacyPolicyCollectionItem1 =>
      'Die App lässt sich lokal nutzen, ohne ein Konto zu verknüpfen.';

  @override
  String get privacyPolicyCollectionItem2 =>
      'Wenn du dein Konto mit Google verknüpfst, nutzt Muscleup Firebase Authentication für die Anmeldung.';

  @override
  String get privacyPolicyCollectionItem3 =>
      'Wenn du die Cloud-Synchronisierung nutzt, werden die Daten in Google Firebase Cloud Firestore gespeichert und deinem Konto zugeordnet.';

  @override
  String get privacyPolicyUsageTitle => 'Wie wir Daten verwenden';

  @override
  String get privacyPolicyUsageItem1 =>
      'Um Anmeldung und Kontoverwaltung zu ermöglichen.';

  @override
  String get privacyPolicyUsageItem2 =>
      'Um deine Routinen und deinen Trainingsverlauf zu speichern, zu synchronisieren und wiederherzustellen.';

  @override
  String get privacyPolicyUsageItem3 =>
      'Um deine Einstellungen zu sichern und die Kernfunktionen der App bereitzustellen.';

  @override
  String get privacyPolicySharingTitle => 'Weitergabe von Daten';

  @override
  String get privacyPolicySharingBody =>
      'Muscleup verkauft deine Daten nicht und gibt sie nicht zu Werbe- oder Marketingzwecken an Dritte weiter. Daten können von Infrastrukturanbietern verarbeitet werden, die für den Betrieb der App nötig sind, etwa Firebase Authentication und Cloud Firestore.';

  @override
  String get privacyPolicySecurityTitle => 'Verschlüsselung und Sicherheit';

  @override
  String get privacyPolicySecurityBody =>
      'Daten werden über sichere, verschlüsselte Verbindungen übertragen. Der Zugriff auf synchronisierte Daten ist auf die angemeldete Person beschränkt, der sie gehören.';

  @override
  String get privacyPolicyRetentionTitle => 'Speicherdauer';

  @override
  String get privacyPolicyRetentionBody =>
      'Daten bleiben gespeichert, solange du dein Konto behältst und die Cloud-Synchronisierung nutzt, sofern du keine Löschung verlangst. Einzelne technische Daten können für eine begrenzte Zeit in Infrastruktur-Backups verbleiben.';

  @override
  String get privacyPolicyDeletionTitle => 'Löschung von Konto und Daten';

  @override
  String get privacyPolicyDeletionBody =>
      'Du kannst jederzeit die Löschung deines Kontos und aller zugehörigen Daten verlangen. Die Seite zur Kontolöschung enthält die vollständige Anleitung, was genau gelöscht wird und wie lange es dauert. Sobald deine Daten gelöscht sind, bestätigen wir das per E-Mail.';

  @override
  String get privacyPolicyChildrenTitle => 'Datenschutz für Kinder';

  @override
  String get privacyPolicyChildrenBody =>
      'Muscleup richtet sich nicht gezielt an Kinder unter 13 Jahren.';

  @override
  String get privacyPolicyContactTitle => 'Kontakt';

  @override
  String get privacyPolicyContactBody =>
      'Bei Fragen zu dieser Erklärung schreib uns an:';

  @override
  String get privacyPolicyOpenOnline => 'Onlineversion ansehen';

  @override
  String get privacyPolicyAccountDeletionPage =>
      'Seite zur Kontolöschung öffnen';

  @override
  String get privacyPolicyAccountDeletion => 'Löschung per E-Mail beantragen';

  @override
  String get accountDeletionEmailSubject =>
      'Muscleup — Antrag auf Kontolöschung';

  @override
  String get accountDeletionEmailBody =>
      'Ich möchte die Löschung meines Muscleup-Kontos und aller zugehörigen Daten beantragen.';

  @override
  String get couldNotOpenLink =>
      'Der Link konnte auf diesem Gerät nicht geöffnet werden.';

  @override
  String get exitAppTitle => 'Muscleup beenden?';

  @override
  String get exitAppMessage => 'Möchtest du die App wirklich schließen?';

  @override
  String get exitAppConfirm => 'Beenden';

  @override
  String get importTitle => 'Routinen importieren';

  @override
  String get importHeadline => 'Deinen ganzen Plan in einem Schritt übernehmen';

  @override
  String get importIntro =>
      'Füge deinen Trainingsplan ein und Muscleup erstellt alle Routinen samt Übungen, Sätzen, Gewichten, Wiederholungen und Notizen. Jeder KI-Assistent kann deine Notizen in das Format bringen, das die App erwartet.';

  @override
  String get importStep1 => 'Kopiere die Anleitung.';

  @override
  String get importStep2 =>
      'Füge sie in einen KI-Chat ein — ChatGPT, Claude, Gemini — und danach deine Trainingsnotizen, genau so, wie du sie aufgeschrieben hast.';

  @override
  String get importStep3 =>
      'Kopiere die Antwort, füge sie unten ein und prüfe sie vor dem Import.';

  @override
  String get importCopyInstructions => 'Anleitung kopieren';

  @override
  String get importInstructionsCopied =>
      'Anleitung kopiert. Füge sie zusammen mit deinen Notizen in einen KI-Chat ein.';

  @override
  String importInstructionsLanguageNote(String language) {
    return 'Die Anleitung ist auf Englisch, weil Assistenten sie so am genauesten befolgen. Deine Routinen kommen auf $language zurück.';
  }

  @override
  String get importPasteLabel => 'Die Antwort des Assistenten';

  @override
  String get importPasteHint => 'JSON hier einfügen';

  @override
  String get importPasteFromClipboard => 'Einfügen';

  @override
  String get importClipboardEmpty => 'Es gibt nichts zum Einfügen.';

  @override
  String get importCheck => 'Prüfen';

  @override
  String get importClear => 'Leeren';

  @override
  String get importAction => 'Importieren';

  @override
  String get importPreviewTitle => 'Das wird erstellt';

  @override
  String importRoutineSummary(int exerciseCount, int setCount) {
    return 'Übungen: $exerciseCount · Sätze: $setCount';
  }

  @override
  String get importNoticesTitle => 'Zum Nachsehen';

  @override
  String get importSuccess => 'Routinen importiert';

  @override
  String get importErrorEmptyInput =>
      'Füge zuerst die Antwort des Assistenten ein.';

  @override
  String get importErrorInvalidJson =>
      'Dieser Text ist kein gültiges JSON. Kopiere die Antwort erneut, inklusive der Klammern, oder bitte den Assistenten, nur mit dem JSON zu antworten.';

  @override
  String get importErrorNoRoutines =>
      'In diesem Text wurden keine Routinen gefunden. Er braucht eine Liste „routines“ mit mindestens einem Tag, der Übungen enthält.';

  @override
  String importNoticeNoExercises(String name) {
    return '„$name“ wurde weggelassen: keine Übungen.';
  }

  @override
  String importNoticeSkippedRoutines(int count) {
    return 'Wegen fehlendem Namen übersprungen: $count.';
  }

  @override
  String importNoticeSkippedExercises(String name, int count) {
    return 'In „$name“ wegen fehlendem Namen übersprungene Übungen: $count.';
  }

  @override
  String importNoticeDuplicateName(String name) {
    return 'Du hast schon eine Routine namens „$name“. Diese wird zusätzlich angelegt.';
  }

  @override
  String get importSettingsSubtitle =>
      'Plan einfügen und alle Routinen auf einmal erstellen';

  @override
  String get exportTitle => 'Routinen exportieren';

  @override
  String get exportSettingsSubtitle =>
      'Eine Kopie sichern, die du wieder einfügen kannst';

  @override
  String get exportIntro =>
      'Das sind alle deine Routinen, in demselben Format, das der Import liest. Bewahre es in einer Notiz oder Datei auf: Wieder eingefügt entstehen sie neu, mit ihren Übungen, Sätzen, Gewichten und Notizen – hier oder auf einem neuen Handy.';

  @override
  String get exportHistoryNote =>
      'Aufgezeichnete Workouts sind nicht enthalten – hier stehen nur deine Routinen.';

  @override
  String exportSummary(int routineCount, int exerciseCount, int setCount) {
    return 'Routinen: $routineCount · Übungen: $exerciseCount · Sätze: $setCount';
  }

  @override
  String get exportCopy => 'JSON kopieren';

  @override
  String get exportCopied =>
      'Routinen kopiert. Füge sie dort ein, wo du sie aufbewahren kannst.';

  @override
  String get exportEmpty => 'Du hast noch keine Routinen zum Exportieren.';

  @override
  String get exportError =>
      'Deine Routinen konnten nicht gelesen werden. Versuche es erneut.';
}
