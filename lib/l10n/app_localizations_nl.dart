// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Muscleup';

  @override
  String get workouts => 'Trainingen';

  @override
  String get exercises => 'Oefeningen';

  @override
  String get history => 'Geschiedenis';

  @override
  String get settings => 'Instellingen';

  @override
  String get routines => 'Schema\'s';

  @override
  String get sets => 'Sets';

  @override
  String get weight => 'Gewicht';

  @override
  String get reps => 'Herh.';

  @override
  String get addRoutine => 'Schema toevoegen';

  @override
  String get addExercise => 'Oefening toevoegen';

  @override
  String get save => 'Opslaan';

  @override
  String get cancel => 'Annuleren';

  @override
  String get back => 'Terug';

  @override
  String get routineDetailsTitle => 'Schemadetails';

  @override
  String get noRoutines => 'Geen schema\'s gevonden';

  @override
  String get errorLoading => 'Schema\'s konden niet worden geladen';

  @override
  String get retry => 'Opnieuw proberen';

  @override
  String get dashboardTitle => 'Overzicht';

  @override
  String get today => 'Vandaag';

  @override
  String get noWorkoutToday => 'Geen training vastgelegd op deze dag';

  @override
  String get startWorkout => 'Start een schema';

  @override
  String get finishWorkout => 'Training afronden';

  @override
  String get workoutSavedSuccess => 'Training opgeslagen!';

  @override
  String get finishWorkoutConfirmation =>
      'Weet je zeker dat je deze training wilt afronden en opslaan?';

  @override
  String get activeWorkoutTitle => 'Lopende training';

  @override
  String get set => 'Set';

  @override
  String get target => 'Doel';

  @override
  String get actual => 'Werkelijk';

  @override
  String get routineName => 'Naam van het schema';

  @override
  String get exerciseName => 'Naam van de oefening';

  @override
  String get notes => 'Notities';

  @override
  String get exerciseNotesLabel => 'Notities (optioneel)';

  @override
  String get exerciseNotesHint => 'bijv. crosstrainer of fiets';

  @override
  String get removeExercise => 'Oefening verwijderen';

  @override
  String get addSet => 'Set toevoegen';

  @override
  String get saveRoutineSuccess => 'Schema opgeslagen!';

  @override
  String get editRoutine => 'Schema bewerken';

  @override
  String get routineNameHint => 'bijv. beendag, maandag';

  @override
  String get searchExercises => 'Oefeningen zoeken...';

  @override
  String get noResults => 'Geen oefeningen gevonden';

  @override
  String get noExercisesAdded => 'Nog geen oefeningen toegevoegd';

  @override
  String addCustomExercise(String name) {
    return '\'$name\' toevoegen';
  }

  @override
  String get searchHelper => 'Typ om te zoeken of toe te voegen...';

  @override
  String get noSetsAdded => 'Geen sets toegevoegd';

  @override
  String get restTimeSeconds => 'Rust (seconden)';

  @override
  String removeConfirmation(String name) {
    return 'Weet je zeker dat je $name wilt verwijderen?';
  }

  @override
  String get remove => 'Verwijderen';

  @override
  String get unitKg => 'kg';

  @override
  String get unitLb => 'lb';

  @override
  String get unitReps => 'herh.';

  @override
  String get unitSeconds => 's';

  @override
  String get unitMinutes => 'min';

  @override
  String get unitKm => 'km';

  @override
  String get unitMeters => 'm';

  @override
  String get unitNone => 'geen';

  @override
  String get unitLevel => 'niveau';

  @override
  String get unitIncline => 'helling';

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
  String get language => 'Taal';

  @override
  String get appSkin => 'App-thema';

  @override
  String get skinVolt => 'Volt';

  @override
  String get skinCyan => 'Cyaan';

  @override
  String get skinCrimson => 'Karmozijn';

  @override
  String get skinRoyalGold => 'Koningsgoud';

  @override
  String get skinMonochrome => 'Monochroom';

  @override
  String get selectSkin => 'App-thema kiezen';

  @override
  String get noExercisesInRoutine => 'Geen oefeningen in dit schema';

  @override
  String get deleteRoutineConfirm =>
      'Weet je zeker dat je dit schema wilt verwijderen?';

  @override
  String get delete => 'Verwijderen';

  @override
  String get routineDeletedSuccess => 'Schema verwijderd!';

  @override
  String get emptyRoutine => 'Leeg';

  @override
  String get startNewSession => 'Nieuwe training starten';

  @override
  String startRoutineName(String name) {
    return '$name starten';
  }

  @override
  String get addExercisesFirst => 'Voeg eerst oefeningen toe';

  @override
  String get deleteSessionConfirm =>
      'Weet je zeker dat je deze training wilt verwijderen?';

  @override
  String get sessionDeleted => 'Training verwijderd';

  @override
  String get resting => 'Rust';

  @override
  String get add30Seconds => '+30 s';

  @override
  String get resumeWorkout => 'Lopende training hervatten';

  @override
  String routineAlreadyActive(String name) {
    return '$name loopt al. We gaan verder.';
  }

  @override
  String get noLogsFound => 'Geen gegevens voor deze training';

  @override
  String get activeWorkout => 'Lopende training';

  @override
  String get inProgress => 'Bezig...';

  @override
  String get completed => 'Voltooid';

  @override
  String get pendingExercises => 'Nog te doen';

  @override
  String get completedExercises => 'Gedaan';

  @override
  String get showCompletedExercises => 'Tonen';

  @override
  String get hideCompletedExercises => 'Verbergen';

  @override
  String get completedSession => 'Voltooide training';

  @override
  String get saveAsRoutineTarget => 'Opslaan als doel van het schema';

  @override
  String get saveAsRoutineTargetSuccess =>
      'Doel bijgewerkt voor volgende trainingen';

  @override
  String get saveAsRoutineTargetError =>
      'Het doel van het schema kon niet worden bijgewerkt';

  @override
  String get editSetValue => 'Waarde bewerken';

  @override
  String get saveForToday => 'Opslaan voor vandaag';

  @override
  String get saveForTodayDetail =>
      'Legt de waarde alleen voor deze training vast';

  @override
  String get updateRoutineTarget => 'Doel bijwerken';

  @override
  String get updateRoutineTargetDetail =>
      'Wijzigt het doel voor volgende trainingen';

  @override
  String get errorEmptyName => 'De naam van het schema mag niet leeg zijn';

  @override
  String get noRoutinesAvailable => 'Geen schema\'s beschikbaar';

  @override
  String get createRoutineToGetStarted => 'Maak een schema om te beginnen';

  @override
  String get errorNoExercises =>
      'Een schema moet minstens één oefening bevatten';

  @override
  String get errorEmptySets => 'Elke oefening moet minstens één set hebben';

  @override
  String get noSetsDefined => 'Geen sets ingesteld';

  @override
  String get authAccount => 'Account';

  @override
  String get authAnonymous => 'Anoniem';

  @override
  String get authAnonymousSubtitle =>
      'Je gegevens staan alleen op dit apparaat. Koppel een account om te synchroniseren.';

  @override
  String get authLinkedWithGoogle => 'Gekoppeld met Google';

  @override
  String get authContinueWithGoogle => 'Doorgaan met Google';

  @override
  String get authDisconnectGoogle => 'Google ontkoppelen';

  @override
  String get authLinkSuccess => 'Account gekoppeld!';

  @override
  String get authGoogleSignInConfigurationError =>
      'Inloggen met Google is niet ingesteld voor deze release-build. Voeg de SHA-vingerafdrukken voor release en Play App Signing toe in Firebase.';

  @override
  String get authGoogleSignInTimeout =>
      'Inloggen met Google duurde te lang. Probeer het opnieuw.';

  @override
  String get authUnavailable => 'Cloudaanmelding niet beschikbaar';

  @override
  String get appInfoSection => 'APP';

  @override
  String get appVersionLabel => 'Versie';

  @override
  String get appBuildLabel => 'Build';

  @override
  String get darkMode => 'Donkere modus';

  @override
  String get trainingDefaultsSection => 'STANDAARDWAARDEN VOOR TRAINING';

  @override
  String get defaultRest => 'Standaardrust';

  @override
  String get defaultRepetitions => 'Standaard herhalingen';

  @override
  String get defaultWeight => 'Standaardgewicht';

  @override
  String get autoStartRestTimerOnComplete =>
      'Rust starten na een voltooide set';

  @override
  String get autoStartRestTimerOnCompleteSubtitle =>
      'Zodra je een set als voltooid markeert, start de timer vanzelf';

  @override
  String get restSecondsDialogTitle => 'Rust (seconden)';

  @override
  String get repetitionsDialogTitle => 'Herhalingen';

  @override
  String get weightKgDialogTitle => 'Gewicht (kg)';

  @override
  String get globalManagementSection => 'ALGEMEEN BEHEER';

  @override
  String get manageExercises => 'Oefeningen beheren';

  @override
  String get manageExercisesSubtitle =>
      'Maak, bewerk en verwijder oefeningen op één plek';

  @override
  String get exerciseLibraryTitle => 'Oefeningenbibliotheek';

  @override
  String get newLabel => 'Nieuw';

  @override
  String get newExerciseTitle => 'Nieuwe oefening';

  @override
  String get editExerciseTitle => 'Oefening bewerken';

  @override
  String get deleteExerciseTitle => 'Oefening verwijderen';

  @override
  String deleteExerciseConfirm(String name) {
    return 'Weet je zeker dat je $name wilt verwijderen?';
  }

  @override
  String get changesSaved => 'Wijzigingen opgeslagen';

  @override
  String get exerciseNameHint => 'Naam van de oefening';

  @override
  String get noExercisesToShow => 'Geen oefeningen om te tonen';

  @override
  String get customLabel => 'Eigen';

  @override
  String get libraryLabel => 'Bibliotheek';

  @override
  String get syncCloudSection => 'CLOUDSYNCHRONISATIE';

  @override
  String get neverSynced => 'Nooit gesynchroniseerd';

  @override
  String get syncing => 'Synchroniseren...';

  @override
  String get globalSyncOverlayTitle => 'Je gegevens worden gesynchroniseerd';

  @override
  String get globalSyncOverlaySubtitle =>
      'Schema\'s en geschiedenis worden uit de cloud gehaald...';

  @override
  String get routinesSyncingPlaceholder =>
      'Je schema\'s worden uit de cloud gehaald...';

  @override
  String get syncPending => 'Synchronisatie in wachtrij';

  @override
  String get synced => 'Geback-upt';

  @override
  String get syncLocked => 'Back-up uit';

  @override
  String lastSync(String date) {
    return 'Laatste synchronisatie: $date';
  }

  @override
  String get linkGoogleForSync =>
      'Koppel je Google-account om cloudsynchronisatie in te schakelen';

  @override
  String get refreshNow => 'Nu vernieuwen';

  @override
  String lastTimeValue(String value) {
    return 'Vorige keer: $value';
  }

  @override
  String get exerciseProgressTitle => 'Voortgang';

  @override
  String get viewProgress => 'Voortgang bekijken';

  @override
  String get noProgressYet =>
      'Nog geen gegevens. Rond een training met deze oefening af om hier je voortgang te zien.';

  @override
  String progressSessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count trainingen',
      one: '1 training',
    );
    return '$_temp0';
  }

  @override
  String get helpFeedbackSection => 'Hulp en feedback';

  @override
  String get sendFeedback => 'Feedback sturen';

  @override
  String get sendFeedbackSubtitle =>
      'Suggesties, ideeën of een probleem melden';

  @override
  String get feedbackEmailSubject => 'Muscleup — Feedback';

  @override
  String get feedbackEmailBody => 'Schrijf hier je feedback, idee of probleem:';

  @override
  String get emailCopiedToClipboard =>
      'Je e-mailapp kon niet worden geopend. Het adres is naar het klembord gekopieerd.';

  @override
  String get legalSection => 'Juridisch';

  @override
  String get privacyPolicy => 'Privacybeleid';

  @override
  String get privacyPolicySubtitle => 'Hoe Muscleup met je gegevens omgaat';

  @override
  String privacyPolicyLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Laatst bijgewerkt: $dateString';
  }

  @override
  String get privacyPolicyIntro =>
      'Muscleup is een app om trainingen bij te houden. Dit beleid legt uit welke gegevens de app kan verzamelen, hoe die worden gebruikt en welke keuzes je daarbij hebt.';

  @override
  String get privacyPolicyDataTitle => 'Gegevens die we verzamelen';

  @override
  String get privacyPolicyDataItem1 =>
      'Accountgegevens zoals naam, e-mailadres en gebruikers-ID.';

  @override
  String get privacyPolicyDataItem2 =>
      'Trainingsgegevens zoals schema\'s, oefeningen, sets, gewicht, herhalingen, trainingen, geschiedenis en optionele notities die je in de app invoert.';

  @override
  String get privacyPolicyDataItem3 =>
      'App-instellingen zoals taal, thema en trainingsvoorkeuren.';

  @override
  String get privacyPolicyCollectionTitle => 'Hoe gegevens worden verzameld';

  @override
  String get privacyPolicyCollectionItem1 =>
      'De app kan lokaal worden gebruikt, zonder een account te koppelen.';

  @override
  String get privacyPolicyCollectionItem2 =>
      'Als je je account met Google koppelt, gebruikt Muscleup Firebase Authentication om in te loggen.';

  @override
  String get privacyPolicyCollectionItem3 =>
      'Als je voor cloudsynchronisatie kiest, worden gegevens opgeslagen in Google Firebase Cloud Firestore en gekoppeld aan je account.';

  @override
  String get privacyPolicyUsageTitle => 'Hoe we gegevens gebruiken';

  @override
  String get privacyPolicyUsageItem1 =>
      'Om inloggen en accountbeheer mogelijk te maken.';

  @override
  String get privacyPolicyUsageItem2 =>
      'Om je schema\'s en trainingsgeschiedenis op te slaan, te synchroniseren en te herstellen.';

  @override
  String get privacyPolicyUsageItem3 =>
      'Om je voorkeuren te bewaren en de kernfuncties van de app te bieden.';

  @override
  String get privacyPolicySharingTitle => 'Gegevens delen';

  @override
  String get privacyPolicySharingBody =>
      'Muscleup verkoopt je gegevens niet en deelt ze niet met derden voor reclame of marketing. Gegevens kunnen worden verwerkt door infrastructuuraanbieders die nodig zijn om de app te laten werken, zoals Firebase Authentication en Cloud Firestore.';

  @override
  String get privacyPolicySecurityTitle => 'Versleuteling en beveiliging';

  @override
  String get privacyPolicySecurityBody =>
      'Gegevens worden via beveiligde, versleutelde verbindingen verstuurd. Toegang tot gesynchroniseerde gegevens is beperkt tot de ingelogde gebruiker aan wie ze toebehoren.';

  @override
  String get privacyPolicyRetentionTitle => 'Bewaartermijn';

  @override
  String get privacyPolicyRetentionBody =>
      'Gegevens worden bewaard zolang je je account houdt en cloudsynchronisatie gebruikt, tenzij je om verwijdering vraagt. Een kleine hoeveelheid technische gegevens kan tijdelijk in back-ups van de infrastructuur achterblijven, voor een beperkte periode.';

  @override
  String get privacyPolicyDeletionTitle => 'Account en gegevens verwijderen';

  @override
  String get privacyPolicyDeletionBody =>
      'Je kunt op elk moment verzoeken om je account en alle bijbehorende gegevens te verwijderen. Op de pagina voor accountverwijdering staan de volledige instructies, wat er precies wordt verwijderd en hoe lang het duurt. We bevestigen per e-mail zodra je gegevens zijn verwijderd.';

  @override
  String get privacyPolicyChildrenTitle => 'Privacy van kinderen';

  @override
  String get privacyPolicyChildrenBody =>
      'Muscleup is niet specifiek gericht op kinderen jonger dan 13 jaar.';

  @override
  String get privacyPolicyContactTitle => 'Contact';

  @override
  String get privacyPolicyContactBody =>
      'Heb je vragen over dit beleid, mail ons dan op:';

  @override
  String get privacyPolicyOpenOnline => 'Bekijk de onlineversie';

  @override
  String get privacyPolicyAccountDeletionPage =>
      'Pagina voor accountverwijdering openen';

  @override
  String get privacyPolicyAccountDeletion =>
      'Verwijdering per e-mail aanvragen';

  @override
  String get accountDeletionEmailSubject =>
      'Muscleup — Verzoek tot accountverwijdering';

  @override
  String get accountDeletionEmailBody =>
      'Ik wil verzoeken om mijn Muscleup-account en alle bijbehorende gegevens te verwijderen.';

  @override
  String get couldNotOpenLink =>
      'De link kon op dit apparaat niet worden geopend.';

  @override
  String get exitAppTitle => 'Muscleup afsluiten?';

  @override
  String get exitAppMessage => 'Weet je zeker dat je de app wilt sluiten?';

  @override
  String get exitAppConfirm => 'Afsluiten';

  @override
  String get importTitle => 'Routines importeren';

  @override
  String get importHeadline => 'Zet je hele schema in één stap over';

  @override
  String get importIntro =>
      'Plak je trainingsschema en Muscleup maakt alle routines aan, met oefeningen, sets, gewichten, herhalingen en notities. Elke AI-assistent kan je aantekeningen in de vorm zetten die de app verwacht.';

  @override
  String get importStep1 => 'Kopieer de instructies.';

  @override
  String get importStep2 =>
      'Plak ze in een AI-chat — ChatGPT, Claude, Gemini — en zet daarachter je trainingsaantekeningen, precies zoals je ze hebt opgeschreven.';

  @override
  String get importStep3 =>
      'Kopieer het antwoord, plak het hieronder en controleer het voordat je importeert.';

  @override
  String get importCopyInstructions => 'Instructies kopiëren';

  @override
  String get importInstructionsCopied =>
      'Instructies gekopieerd. Plak ze samen met je aantekeningen in een AI-chat.';

  @override
  String importInstructionsLanguageNote(String language) {
    return 'De instructies zijn in het Engels, omdat assistenten ze dan het nauwkeurigst volgen. Je routines komen terug in het $language.';
  }

  @override
  String get importPasteLabel => 'Het antwoord van de assistent';

  @override
  String get importPasteHint => 'Plak de JSON hier';

  @override
  String get importPasteFromClipboard => 'Plakken';

  @override
  String get importClipboardEmpty => 'Er is niets om te plakken.';

  @override
  String get importCheck => 'Controleren';

  @override
  String get importClear => 'Wissen';

  @override
  String get importAction => 'Importeren';

  @override
  String get importPreviewTitle => 'Dit wordt aangemaakt';

  @override
  String importRoutineSummary(int exerciseCount, int setCount) {
    return 'Oefeningen: $exerciseCount · Sets: $setCount';
  }

  @override
  String get importNoticesTitle => 'Even nakijken';

  @override
  String get importSuccess => 'Routines geïmporteerd';

  @override
  String get importErrorEmptyInput =>
      'Plak eerst het antwoord van de assistent.';

  @override
  String get importErrorInvalidJson =>
      'Deze tekst is geen geldige JSON. Kopieer het antwoord opnieuw, inclusief de accolades, of vraag de assistent om alleen met de JSON te antwoorden.';

  @override
  String get importErrorNoRoutines =>
      'Geen routines gevonden in deze tekst. Er moet een lijst “routines” in staan met minstens één dag met oefeningen.';

  @override
  String importNoticeNoExercises(String name) {
    return '“$name” is overgeslagen: geen oefeningen.';
  }

  @override
  String importNoticeSkippedRoutines(int count) {
    return 'Overgeslagen omdat er geen naam was: $count.';
  }

  @override
  String importNoticeSkippedExercises(String name, int count) {
    return 'Oefeningen in “$name” overgeslagen omdat er geen naam was: $count.';
  }

  @override
  String importNoticeDuplicateName(String name) {
    return 'Je hebt al een routine met de naam “$name”. Deze wordt er extra bij gezet.';
  }

  @override
  String get importSettingsSubtitle =>
      'Plak een schema en maak alle routines in één keer';
}
