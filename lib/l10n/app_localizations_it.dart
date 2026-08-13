// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Muscleup';

  @override
  String get workouts => 'Allenamenti';

  @override
  String get exercises => 'Esercizi';

  @override
  String get history => 'Cronologia';

  @override
  String get settings => 'Impostazioni';

  @override
  String get routines => 'Schede';

  @override
  String get sets => 'Serie';

  @override
  String get weight => 'Peso';

  @override
  String get reps => 'Rip.';

  @override
  String get addRoutine => 'Aggiungi scheda';

  @override
  String get addExercise => 'Aggiungi esercizio';

  @override
  String get save => 'Salva';

  @override
  String get cancel => 'Annulla';

  @override
  String get back => 'Indietro';

  @override
  String get routineDetailsTitle => 'Dettagli della scheda';

  @override
  String get noRoutines => 'Nessuna scheda trovata';

  @override
  String get errorLoading => 'Errore nel caricamento delle schede';

  @override
  String get retry => 'Riprova';

  @override
  String get dashboardTitle => 'Riepilogo';

  @override
  String get today => 'Oggi';

  @override
  String get noWorkoutToday => 'Nessun allenamento registrato in questo giorno';

  @override
  String get startWorkout => 'Inizia una scheda';

  @override
  String get finishWorkout => 'Termina allenamento';

  @override
  String get workoutSavedSuccess => 'Allenamento salvato!';

  @override
  String get finishWorkoutConfirmation =>
      'Vuoi davvero terminare e salvare questo allenamento?';

  @override
  String get activeWorkoutTitle => 'Allenamento in corso';

  @override
  String get set => 'Serie';

  @override
  String get target => 'Obiettivo';

  @override
  String get actual => 'Effettivo';

  @override
  String get routineName => 'Nome della scheda';

  @override
  String get exerciseName => 'Nome dell\'esercizio';

  @override
  String get notes => 'Note';

  @override
  String get exerciseNotesLabel => 'Note (facoltative)';

  @override
  String get exerciseNotesHint => 'es. ellittica o cyclette';

  @override
  String get removeExercise => 'Rimuovi esercizio';

  @override
  String get addSet => 'Aggiungi serie';

  @override
  String get saveRoutineSuccess => 'Scheda salvata!';

  @override
  String get editRoutine => 'Modifica scheda';

  @override
  String get routineNameHint => 'es. giorno gambe, lunedì';

  @override
  String get searchExercises => 'Cerca esercizi...';

  @override
  String get noResults => 'Nessun esercizio trovato';

  @override
  String get noExercisesAdded => 'Nessun esercizio aggiunto';

  @override
  String addCustomExercise(String name) {
    return 'Aggiungi \'$name\'';
  }

  @override
  String get searchHelper => 'Scrivi per cercare o aggiungere...';

  @override
  String get noSetsAdded => 'Nessuna serie aggiunta';

  @override
  String get restTimeSeconds => 'Recupero (secondi)';

  @override
  String removeConfirmation(String name) {
    return 'Vuoi davvero rimuovere $name?';
  }

  @override
  String get remove => 'Rimuovi';

  @override
  String get unitKg => 'kg';

  @override
  String get unitLb => 'lb';

  @override
  String get unitReps => 'rip.';

  @override
  String get unitSeconds => 's';

  @override
  String get unitMinutes => 'min';

  @override
  String get unitKm => 'km';

  @override
  String get unitMeters => 'm';

  @override
  String get unitNone => 'nessuna';

  @override
  String get unitLevel => 'livello';

  @override
  String get unitIncline => 'inclinazione';

  @override
  String setsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count serie',
      one: '1 serie',
    );
    return '$_temp0';
  }

  @override
  String get language => 'Lingua';

  @override
  String get appSkin => 'Tema dell\'app';

  @override
  String get skinVolt => 'Volt';

  @override
  String get skinCyan => 'Ciano';

  @override
  String get skinCrimson => 'Cremisi';

  @override
  String get skinRoyalGold => 'Oro reale';

  @override
  String get skinMonochrome => 'Monocromatico';

  @override
  String get selectSkin => 'Scegli il tema dell\'app';

  @override
  String get noExercisesInRoutine => 'Nessun esercizio in questa scheda';

  @override
  String get deleteRoutineConfirm => 'Vuoi davvero eliminare questa scheda?';

  @override
  String get delete => 'Elimina';

  @override
  String get routineDeletedSuccess => 'Scheda eliminata!';

  @override
  String get emptyRoutine => 'Vuota';

  @override
  String get startNewSession => 'Inizia una nuova sessione';

  @override
  String startRoutineName(String name) {
    return 'Inizia $name';
  }

  @override
  String get addExercisesFirst => 'Aggiungi prima gli esercizi';

  @override
  String get deleteSessionConfirm =>
      'Vuoi davvero eliminare questa sessione di allenamento?';

  @override
  String get sessionDeleted => 'Sessione eliminata';

  @override
  String get resting => 'Recupero';

  @override
  String get add30Seconds => '+30 s';

  @override
  String get resumeWorkout => 'Riprendi l\'allenamento in corso';

  @override
  String routineAlreadyActive(String name) {
    return '$name è già in corso. Riprendo la sessione.';
  }

  @override
  String get noLogsFound => 'Nessun dato registrato per questa sessione';

  @override
  String get activeWorkout => 'Allenamento in corso';

  @override
  String get inProgress => 'In corso...';

  @override
  String get completed => 'Completato';

  @override
  String get pendingExercises => 'Da fare';

  @override
  String get completedExercises => 'Completati';

  @override
  String get showCompletedExercises => 'Mostra';

  @override
  String get hideCompletedExercises => 'Nascondi';

  @override
  String get completedSession => 'Sessione completata';

  @override
  String get saveAsRoutineTarget => 'Salva come obiettivo della scheda';

  @override
  String get saveAsRoutineTargetSuccess =>
      'Obiettivo aggiornato per i prossimi allenamenti';

  @override
  String get saveAsRoutineTargetError =>
      'Impossibile aggiornare l\'obiettivo della scheda';

  @override
  String get editSetValue => 'Modifica valore';

  @override
  String get saveForToday => 'Salva per oggi';

  @override
  String get saveForTodayDetail =>
      'Registra il valore solo per questo allenamento';

  @override
  String get updateRoutineTarget => 'Aggiorna obiettivo';

  @override
  String get updateRoutineTargetDetail =>
      'Cambia l\'obiettivo dei prossimi allenamenti';

  @override
  String get errorEmptyName => 'Il nome della scheda non può essere vuoto';

  @override
  String get noRoutinesAvailable => 'Nessuna scheda disponibile';

  @override
  String get createRoutineToGetStarted => 'Crea una scheda per iniziare';

  @override
  String get errorNoExercises => 'La scheda deve avere almeno un esercizio';

  @override
  String get errorEmptySets => 'Ogni esercizio deve avere almeno una serie';

  @override
  String get noSetsDefined => 'Nessuna serie definita';

  @override
  String get authAccount => 'Account';

  @override
  String get authAnonymous => 'Anonimo';

  @override
  String get authAnonymousSubtitle =>
      'I tuoi dati restano su questo dispositivo. Collega un account per sincronizzarli.';

  @override
  String get authLinkedWithGoogle => 'Collegato con Google';

  @override
  String get authContinueWithGoogle => 'Continua con Google';

  @override
  String get authDisconnectGoogle => 'Scollega Google';

  @override
  String get authLinkSuccess => 'Account collegato!';

  @override
  String get authGoogleSignInConfigurationError =>
      'L\'accesso con Google non è configurato per questa build di release. Aggiungi le impronte SHA di release e di Play App Signing su Firebase.';

  @override
  String get authGoogleSignInTimeout =>
      'L\'accesso con Google ha richiesto troppo tempo. Riprova.';

  @override
  String get authUnavailable => 'Autenticazione cloud non disponibile';

  @override
  String get appInfoSection => 'APP';

  @override
  String get appVersionLabel => 'Versione';

  @override
  String get appBuildLabel => 'Build';

  @override
  String get darkMode => 'Modalità scura';

  @override
  String get trainingDefaultsSection => 'VALORI PREDEFINITI DI ALLENAMENTO';

  @override
  String get defaultRest => 'Recupero predefinito';

  @override
  String get defaultRepetitions => 'Ripetizioni predefinite';

  @override
  String get defaultWeight => 'Peso predefinito';

  @override
  String get autoStartRestTimerOnComplete =>
      'Avvia il recupero al termine della serie';

  @override
  String get autoStartRestTimerOnCompleteSubtitle =>
      'Quando segni una serie come completata, il timer parte da solo';

  @override
  String get restSecondsDialogTitle => 'Recupero (secondi)';

  @override
  String get repetitionsDialogTitle => 'Ripetizioni';

  @override
  String get weightKgDialogTitle => 'Peso (kg)';

  @override
  String get globalManagementSection => 'GESTIONE GENERALE';

  @override
  String get manageExercises => 'Gestisci esercizi';

  @override
  String get manageExercisesSubtitle =>
      'Crea, modifica ed elimina gli esercizi in un unico posto';

  @override
  String get exerciseLibraryTitle => 'Libreria esercizi';

  @override
  String get newLabel => 'Nuovo';

  @override
  String get newExerciseTitle => 'Nuovo esercizio';

  @override
  String get editExerciseTitle => 'Modifica esercizio';

  @override
  String get deleteExerciseTitle => 'Elimina esercizio';

  @override
  String deleteExerciseConfirm(String name) {
    return 'Vuoi davvero eliminare $name?';
  }

  @override
  String get changesSaved => 'Modifiche salvate';

  @override
  String get exerciseNameHint => 'Nome dell\'esercizio';

  @override
  String get noExercisesToShow => 'Nessun esercizio da mostrare';

  @override
  String get customLabel => 'Personalizzato';

  @override
  String get libraryLabel => 'Libreria';

  @override
  String get syncCloudSection => 'SINCRONIZZAZIONE CLOUD';

  @override
  String get neverSynced => 'Mai sincronizzato';

  @override
  String get syncing => 'Sincronizzazione...';

  @override
  String get globalSyncOverlayTitle => 'Sincronizzazione dei tuoi dati';

  @override
  String get globalSyncOverlaySubtitle =>
      'Recupero di schede e cronologia dal cloud...';

  @override
  String get routinesSyncingPlaceholder =>
      'Recupero delle tue schede dal cloud...';

  @override
  String get syncPending => 'Sincronizzazione in sospeso';

  @override
  String get synced => 'Backup eseguito';

  @override
  String get syncLocked => 'Backup disattivato';

  @override
  String lastSync(String date) {
    return 'Ultima sincronizzazione: $date';
  }

  @override
  String get linkGoogleForSync =>
      'Collega il tuo account Google per attivare la sincronizzazione cloud';

  @override
  String get refreshNow => 'Aggiorna ora';

  @override
  String lastTimeValue(String value) {
    return 'L\'ultima volta: $value';
  }

  @override
  String get exerciseProgressTitle => 'Progressi';

  @override
  String get viewProgress => 'Vedi i progressi';

  @override
  String get noProgressYet =>
      'Ancora nessun dato. Completa un allenamento con questo esercizio per vedere qui i tuoi progressi.';

  @override
  String progressSessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sessioni',
      one: '1 sessione',
    );
    return '$_temp0';
  }

  @override
  String get helpFeedbackSection => 'Aiuto e feedback';

  @override
  String get sendFeedback => 'Invia feedback';

  @override
  String get sendFeedbackSubtitle => 'Suggerimenti, idee o segnala un problema';

  @override
  String get feedbackEmailSubject => 'Muscleup — Feedback';

  @override
  String get feedbackEmailBody =>
      'Scrivi qui il tuo feedback, la tua idea o il problema:';

  @override
  String get emailCopiedToClipboard =>
      'Non è stato possibile aprire la tua app di posta. L\'indirizzo è stato copiato negli appunti.';

  @override
  String get legalSection => 'Note legali';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get privacyPolicySubtitle => 'Come Muscleup tratta i tuoi dati';

  @override
  String privacyPolicyLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Ultimo aggiornamento: $dateString';
  }

  @override
  String get privacyPolicyIntro =>
      'Muscleup è un\'app per registrare gli allenamenti. Questa informativa spiega quali dati l\'app può raccogliere, come vengono usati e quali scelte hai a riguardo.';

  @override
  String get privacyPolicyDataTitle => 'Dati che raccogliamo';

  @override
  String get privacyPolicyDataItem1 =>
      'Informazioni dell\'account come nome, indirizzo e-mail e ID utente.';

  @override
  String get privacyPolicyDataItem2 =>
      'Dati di allenamento come schede, esercizi, serie, peso, ripetizioni, sessioni, cronologia e le note facoltative che inserisci nell\'app.';

  @override
  String get privacyPolicyDataItem3 =>
      'Impostazioni dell\'app come lingua, tema e preferenze legate all\'allenamento.';

  @override
  String get privacyPolicyCollectionTitle => 'Come vengono raccolti i dati';

  @override
  String get privacyPolicyCollectionItem1 =>
      'L\'app può essere usata in locale, senza collegare un account.';

  @override
  String get privacyPolicyCollectionItem2 =>
      'Se scegli di collegare il tuo account Google, Muscleup usa Firebase Authentication per l\'accesso.';

  @override
  String get privacyPolicyCollectionItem3 =>
      'Se scegli la sincronizzazione cloud, i dati vengono salvati su Google Firebase Cloud Firestore e associati al tuo account.';

  @override
  String get privacyPolicyUsageTitle => 'Come usiamo i dati';

  @override
  String get privacyPolicyUsageItem1 =>
      'Per consentire l\'accesso e la gestione dell\'account.';

  @override
  String get privacyPolicyUsageItem2 =>
      'Per salvare, sincronizzare e ripristinare le tue schede e la cronologia degli allenamenti.';

  @override
  String get privacyPolicyUsageItem3 =>
      'Per conservare le tue preferenze e fornire le funzioni principali dell\'app.';

  @override
  String get privacyPolicySharingTitle => 'Condivisione dei dati';

  @override
  String get privacyPolicySharingBody =>
      'Muscleup non vende i tuoi dati e non li condivide con terze parti per finalità pubblicitarie o di marketing. I dati possono essere trattati dai fornitori di infrastruttura necessari al funzionamento dell\'app, come Firebase Authentication e Cloud Firestore.';

  @override
  String get privacyPolicySecurityTitle => 'Crittografia e sicurezza';

  @override
  String get privacyPolicySecurityBody =>
      'I dati viaggiano su connessioni sicure e cifrate. L\'accesso ai dati sincronizzati è riservato all\'utente autenticato che ne è titolare.';

  @override
  String get privacyPolicyRetentionTitle => 'Conservazione dei dati';

  @override
  String get privacyPolicyRetentionBody =>
      'I dati vengono conservati finché mantieni il tuo account e usi la sincronizzazione cloud, salvo tua richiesta di cancellazione. Alcuni dati tecnici minimi possono restare temporaneamente nei backup dell\'infrastruttura per un periodo limitato.';

  @override
  String get privacyPolicyDeletionTitle =>
      'Eliminazione dell\'account e dei dati';

  @override
  String get privacyPolicyDeletionBody =>
      'Puoi richiedere in qualsiasi momento l\'eliminazione del tuo account e di tutti i dati associati. La pagina dedicata riporta le istruzioni complete, che cosa viene eliminato di preciso e quanto tempo serve. Ti confermiamo via e-mail quando i tuoi dati sono stati eliminati.';

  @override
  String get privacyPolicyChildrenTitle => 'Privacy dei minori';

  @override
  String get privacyPolicyChildrenBody =>
      'Muscleup non si rivolge specificamente ai minori di 13 anni.';

  @override
  String get privacyPolicyContactTitle => 'Contatti';

  @override
  String get privacyPolicyContactBody =>
      'Se hai domande su questa informativa, scrivici a:';

  @override
  String get privacyPolicyOpenOnline => 'Vedi la versione online';

  @override
  String get privacyPolicyAccountDeletionPage =>
      'Apri la pagina di eliminazione dell\'account';

  @override
  String get privacyPolicyAccountDeletion =>
      'Richiedi l\'eliminazione via e-mail';

  @override
  String get accountDeletionEmailSubject =>
      'Muscleup — Richiesta di eliminazione dell\'account';

  @override
  String get accountDeletionEmailBody =>
      'Vorrei richiedere l\'eliminazione del mio account Muscleup e di tutti i dati associati.';

  @override
  String get couldNotOpenLink =>
      'Non è stato possibile aprire il link su questo dispositivo.';

  @override
  String get exitAppTitle => 'Uscire da Muscleup?';

  @override
  String get exitAppMessage => 'Vuoi davvero chiudere l\'app?';

  @override
  String get exitAppConfirm => 'Esci';
}
