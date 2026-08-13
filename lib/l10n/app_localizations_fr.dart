// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Muscleup';

  @override
  String get workouts => 'Séances';

  @override
  String get exercises => 'Exercices';

  @override
  String get history => 'Historique';

  @override
  String get settings => 'Réglages';

  @override
  String get routines => 'Programmes';

  @override
  String get sets => 'Séries';

  @override
  String get weight => 'Poids';

  @override
  String get reps => 'Réps';

  @override
  String get addRoutine => 'Ajouter un programme';

  @override
  String get addExercise => 'Ajouter un exercice';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get back => 'Retour';

  @override
  String get routineDetailsTitle => 'Détails du programme';

  @override
  String get noRoutines => 'Aucun programme trouvé';

  @override
  String get errorLoading => 'Erreur lors du chargement des programmes';

  @override
  String get retry => 'Réessayer';

  @override
  String get dashboardTitle => 'Tableau de bord';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get noWorkoutToday => 'Aucune séance enregistrée pour ce jour';

  @override
  String get startWorkout => 'Démarrer un programme';

  @override
  String get finishWorkout => 'Terminer la séance';

  @override
  String get workoutSavedSuccess => 'Séance enregistrée !';

  @override
  String get finishWorkoutConfirmation =>
      'Voulez-vous vraiment terminer et enregistrer cette séance ?';

  @override
  String get activeWorkoutTitle => 'Séance en cours';

  @override
  String get set => 'Série';

  @override
  String get target => 'Objectif';

  @override
  String get actual => 'Réalisé';

  @override
  String get routineName => 'Nom du programme';

  @override
  String get exerciseName => 'Nom de l\'exercice';

  @override
  String get notes => 'Notes';

  @override
  String get exerciseNotesLabel => 'Notes (facultatif)';

  @override
  String get exerciseNotesHint => 'ex. : elliptique ou vélo';

  @override
  String get removeExercise => 'Retirer l\'exercice';

  @override
  String get addSet => 'Ajouter une série';

  @override
  String get saveRoutineSuccess => 'Programme enregistré !';

  @override
  String get editRoutine => 'Modifier le programme';

  @override
  String get routineNameHint => 'ex. : jour jambes, lundi';

  @override
  String get searchExercises => 'Rechercher des exercices...';

  @override
  String get noResults => 'Aucun exercice trouvé';

  @override
  String get noExercisesAdded => 'Aucun exercice ajouté pour l\'instant';

  @override
  String addCustomExercise(String name) {
    return 'Ajouter \'$name\'';
  }

  @override
  String get searchHelper => 'Saisissez pour rechercher ou ajouter...';

  @override
  String get noSetsAdded => 'Aucune série ajoutée';

  @override
  String get restTimeSeconds => 'Repos (secondes)';

  @override
  String removeConfirmation(String name) {
    return 'Voulez-vous vraiment retirer $name ?';
  }

  @override
  String get remove => 'Retirer';

  @override
  String get unitKg => 'kg';

  @override
  String get unitLb => 'lb';

  @override
  String get unitReps => 'réps';

  @override
  String get unitSeconds => 's';

  @override
  String get unitMinutes => 'min';

  @override
  String get unitKm => 'km';

  @override
  String get unitMeters => 'm';

  @override
  String get unitNone => 'aucune';

  @override
  String get unitLevel => 'niveau';

  @override
  String get unitIncline => 'inclinaison';

  @override
  String setsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count séries',
      one: '1 série',
    );
    return '$_temp0';
  }

  @override
  String get language => 'Langue';

  @override
  String get appSkin => 'Thème de l\'app';

  @override
  String get skinVolt => 'Volt';

  @override
  String get skinCyan => 'Cyan';

  @override
  String get skinCrimson => 'Cramoisi';

  @override
  String get skinRoyalGold => 'Or royal';

  @override
  String get skinMonochrome => 'Monochrome';

  @override
  String get selectSkin => 'Choisir le thème de l\'app';

  @override
  String get noExercisesInRoutine => 'Aucun exercice dans ce programme';

  @override
  String get deleteRoutineConfirm =>
      'Voulez-vous vraiment supprimer ce programme ?';

  @override
  String get delete => 'Supprimer';

  @override
  String get routineDeletedSuccess => 'Programme supprimé !';

  @override
  String get emptyRoutine => 'Vide';

  @override
  String get startNewSession => 'Démarrer une nouvelle séance';

  @override
  String startRoutineName(String name) {
    return 'Démarrer $name';
  }

  @override
  String get addExercisesFirst => 'Ajoutez d\'abord des exercices';

  @override
  String get deleteSessionConfirm =>
      'Voulez-vous vraiment supprimer cette séance ?';

  @override
  String get sessionDeleted => 'Séance supprimée';

  @override
  String get resting => 'Repos';

  @override
  String get add30Seconds => '+30 s';

  @override
  String get resumeWorkout => 'Reprendre la séance en cours';

  @override
  String routineAlreadyActive(String name) {
    return '$name est déjà en cours. Reprise de la séance.';
  }

  @override
  String get noLogsFound => 'Aucun enregistrement pour cette séance';

  @override
  String get activeWorkout => 'Séance en cours';

  @override
  String get inProgress => 'En cours...';

  @override
  String get completed => 'Terminé';

  @override
  String get pendingExercises => 'À faire';

  @override
  String get completedExercises => 'Terminés';

  @override
  String get showCompletedExercises => 'Afficher';

  @override
  String get hideCompletedExercises => 'Masquer';

  @override
  String get completedSession => 'Séance terminée';

  @override
  String get saveAsRoutineTarget => 'Enregistrer comme objectif du programme';

  @override
  String get saveAsRoutineTargetSuccess =>
      'Objectif mis à jour pour les prochaines séances';

  @override
  String get saveAsRoutineTargetError =>
      'Impossible de mettre à jour l\'objectif du programme';

  @override
  String get editSetValue => 'Modifier la valeur';

  @override
  String get saveForToday => 'Enregistrer pour aujourd\'hui';

  @override
  String get saveForTodayDetail =>
      'N\'enregistre la valeur que pour cette séance';

  @override
  String get updateRoutineTarget => 'Mettre à jour l\'objectif';

  @override
  String get updateRoutineTargetDetail =>
      'Modifie l\'objectif des prochaines séances';

  @override
  String get errorEmptyName => 'Le nom du programme ne peut pas être vide';

  @override
  String get noRoutinesAvailable => 'Aucun programme disponible';

  @override
  String get createRoutineToGetStarted => 'Créez un programme pour commencer';

  @override
  String get errorNoExercises =>
      'Un programme doit contenir au moins un exercice';

  @override
  String get errorEmptySets =>
      'Chaque exercice doit contenir au moins une série';

  @override
  String get noSetsDefined => 'Aucune série définie';

  @override
  String get authAccount => 'Compte';

  @override
  String get authAnonymous => 'Anonyme';

  @override
  String get authAnonymousSubtitle =>
      'Vos données restent sur cet appareil. Associez un compte pour les synchroniser.';

  @override
  String get authLinkedWithGoogle => 'Associé à Google';

  @override
  String get authContinueWithGoogle => 'Continuer avec Google';

  @override
  String get authDisconnectGoogle => 'Dissocier Google';

  @override
  String get authLinkSuccess => 'Compte associé avec succès !';

  @override
  String get authGoogleSignInConfigurationError =>
      'La connexion Google n\'est pas configurée pour cette version. Ajoutez les empreintes SHA de release et de Play App Signing dans Firebase.';

  @override
  String get authGoogleSignInTimeout =>
      'La connexion Google a pris trop de temps. Veuillez réessayer.';

  @override
  String get authUnavailable => 'Authentification cloud indisponible';

  @override
  String get appInfoSection => 'APPLICATION';

  @override
  String get appVersionLabel => 'Version';

  @override
  String get appBuildLabel => 'Build';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get trainingDefaultsSection => 'VALEURS D\'ENTRAÎNEMENT PAR DÉFAUT';

  @override
  String get defaultRest => 'Repos par défaut';

  @override
  String get defaultRepetitions => 'Réps par défaut';

  @override
  String get defaultWeight => 'Poids par défaut';

  @override
  String get autoStartRestTimerOnComplete =>
      'Lancer le repos à la fin d\'une série';

  @override
  String get autoStartRestTimerOnCompleteSubtitle =>
      'Dès que vous validez une série, le minuteur démarre tout seul';

  @override
  String get restSecondsDialogTitle => 'Repos (secondes)';

  @override
  String get repetitionsDialogTitle => 'Répétitions';

  @override
  String get weightKgDialogTitle => 'Poids (kg)';

  @override
  String get globalManagementSection => 'GESTION GÉNÉRALE';

  @override
  String get manageExercises => 'Gérer les exercices';

  @override
  String get manageExercisesSubtitle =>
      'Créez, modifiez et supprimez vos exercices au même endroit';

  @override
  String get exerciseLibraryTitle => 'Bibliothèque d\'exercices';

  @override
  String get newLabel => 'Nouveau';

  @override
  String get newExerciseTitle => 'Nouvel exercice';

  @override
  String get editExerciseTitle => 'Modifier l\'exercice';

  @override
  String get deleteExerciseTitle => 'Supprimer l\'exercice';

  @override
  String deleteExerciseConfirm(String name) {
    return 'Voulez-vous vraiment supprimer $name ?';
  }

  @override
  String get changesSaved => 'Modifications enregistrées';

  @override
  String get exerciseNameHint => 'Nom de l\'exercice';

  @override
  String get noExercisesToShow => 'Aucun exercice à afficher';

  @override
  String get customLabel => 'Personnalisé';

  @override
  String get libraryLabel => 'Bibliothèque';

  @override
  String get syncCloudSection => 'SYNCHRONISATION CLOUD';

  @override
  String get neverSynced => 'Jamais synchronisé';

  @override
  String get syncing => 'Synchronisation...';

  @override
  String get globalSyncOverlayTitle => 'Synchronisation de vos données';

  @override
  String get globalSyncOverlaySubtitle =>
      'Récupération des programmes et de l\'historique depuis le cloud...';

  @override
  String get routinesSyncingPlaceholder =>
      'Récupération de vos programmes depuis le cloud...';

  @override
  String get syncPending => 'Synchronisation en attente';

  @override
  String get synced => 'Sauvegardé';

  @override
  String get syncLocked => 'Sauvegarde désactivée';

  @override
  String lastSync(String date) {
    return 'Dernière synchro : $date';
  }

  @override
  String get linkGoogleForSync =>
      'Associez votre compte Google pour activer la synchronisation cloud';

  @override
  String get refreshNow => 'Actualiser';

  @override
  String lastTimeValue(String value) {
    return 'La dernière fois : $value';
  }

  @override
  String get exerciseProgressTitle => 'Progression';

  @override
  String get viewProgress => 'Voir la progression';

  @override
  String get noProgressYet =>
      'Aucun enregistrement pour le moment. Terminez une séance avec cet exercice pour voir votre progression ici.';

  @override
  String progressSessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count séances',
      one: '1 séance',
    );
    return '$_temp0';
  }

  @override
  String get helpFeedbackSection => 'Aide et commentaires';

  @override
  String get sendFeedback => 'Envoyer un commentaire';

  @override
  String get sendFeedbackSubtitle =>
      'Suggestions, idées ou signaler un problème';

  @override
  String get feedbackEmailSubject => 'Muscleup — Commentaires';

  @override
  String get feedbackEmailBody =>
      'Écrivez ici votre commentaire, votre idée ou votre problème :';

  @override
  String get emailCopiedToClipboard =>
      'Impossible d\'ouvrir votre application e-mail. L\'adresse a été copiée dans le presse-papiers.';

  @override
  String get legalSection => 'Mentions légales';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get privacyPolicySubtitle => 'Comment Muscleup traite vos données';

  @override
  String privacyPolicyLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Dernière mise à jour : $dateString';
  }

  @override
  String get privacyPolicyIntro =>
      'Muscleup est une application de suivi d\'entraînement. Cette politique explique quelles données l\'application peut collecter, comment elles sont utilisées et quels choix s\'offrent à vous à leur sujet.';

  @override
  String get privacyPolicyDataTitle => 'Données que nous collectons';

  @override
  String get privacyPolicyDataItem1 =>
      'Les informations de compte telles que le nom, l\'adresse e-mail et l\'identifiant utilisateur.';

  @override
  String get privacyPolicyDataItem2 =>
      'Les données d\'entraînement telles que les programmes, exercices, séries, poids, répétitions, séances, historique et les notes facultatives que vous saisissez dans l\'application.';

  @override
  String get privacyPolicyDataItem3 =>
      'Les réglages de l\'application tels que la langue, le thème et les préférences liées à l\'entraînement.';

  @override
  String get privacyPolicyCollectionTitle =>
      'Comment les données sont collectées';

  @override
  String get privacyPolicyCollectionItem1 =>
      'L\'application peut être utilisée en local, sans associer de compte.';

  @override
  String get privacyPolicyCollectionItem2 =>
      'Si vous choisissez d\'associer votre compte Google, Muscleup utilise Firebase Authentication pour la connexion.';

  @override
  String get privacyPolicyCollectionItem3 =>
      'Si vous choisissez la synchronisation cloud, les données sont stockées dans Google Firebase Cloud Firestore et associées à votre compte.';

  @override
  String get privacyPolicyUsageTitle => 'Comment nous utilisons les données';

  @override
  String get privacyPolicyUsageItem1 =>
      'Pour permettre la connexion et la gestion du compte.';

  @override
  String get privacyPolicyUsageItem2 =>
      'Pour enregistrer, synchroniser et restaurer vos programmes et votre historique d\'entraînement.';

  @override
  String get privacyPolicyUsageItem3 =>
      'Pour conserver vos préférences et assurer les fonctions principales de l\'application.';

  @override
  String get privacyPolicySharingTitle => 'Partage des données';

  @override
  String get privacyPolicySharingBody =>
      'Muscleup ne vend pas vos données et ne les partage pas avec des tiers à des fins publicitaires ou marketing. Les données peuvent être traitées par les prestataires d\'infrastructure nécessaires au fonctionnement de l\'application, comme Firebase Authentication et Cloud Firestore.';

  @override
  String get privacyPolicySecurityTitle => 'Chiffrement et sécurité';

  @override
  String get privacyPolicySecurityBody =>
      'Les données transitent par des connexions sécurisées et chiffrées. L\'accès aux données synchronisées est réservé à l\'utilisateur authentifié qui en est propriétaire.';

  @override
  String get privacyPolicyRetentionTitle => 'Conservation des données';

  @override
  String get privacyPolicyRetentionBody =>
      'Les données sont conservées tant que vous gardez votre compte et utilisez la synchronisation cloud, sauf demande de suppression de votre part. Quelques données techniques minimales peuvent subsister temporairement dans les sauvegardes d\'infrastructure, pour une durée limitée.';

  @override
  String get privacyPolicyDeletionTitle =>
      'Suppression du compte et des données';

  @override
  String get privacyPolicyDeletionBody =>
      'Vous pouvez demander à tout moment la suppression de votre compte et de toutes les données associées. La page de suppression de compte détaille la marche à suivre, ce qui est exactement supprimé et le délai nécessaire. Nous vous confirmons par e-mail une fois vos données supprimées.';

  @override
  String get privacyPolicyChildrenTitle => 'Confidentialité des enfants';

  @override
  String get privacyPolicyChildrenBody =>
      'Muscleup ne s\'adresse pas spécifiquement aux enfants de moins de 13 ans.';

  @override
  String get privacyPolicyContactTitle => 'Contact';

  @override
  String get privacyPolicyContactBody =>
      'Si vous avez des questions sur cette politique, écrivez-nous à :';

  @override
  String get privacyPolicyOpenOnline => 'Voir la version en ligne';

  @override
  String get privacyPolicyAccountDeletionPage =>
      'Ouvrir la page de suppression de compte';

  @override
  String get privacyPolicyAccountDeletion =>
      'Demander la suppression par e-mail';

  @override
  String get accountDeletionEmailSubject =>
      'Muscleup — Demande de suppression de compte';

  @override
  String get accountDeletionEmailBody =>
      'Je souhaite demander la suppression de mon compte Muscleup et de toutes les données associées.';

  @override
  String get couldNotOpenLink =>
      'Impossible d\'ouvrir le lien sur cet appareil.';

  @override
  String get exitAppTitle => 'Quitter Muscleup ?';

  @override
  String get exitAppMessage => 'Voulez-vous vraiment fermer l\'application ?';

  @override
  String get exitAppConfirm => 'Quitter';

  @override
  String get importTitle => 'Importer des routines';

  @override
  String get importHeadline => 'Importez tout votre programme en une étape';

  @override
  String get importIntro =>
      'Collez votre programme d\'entraînement et Muscleup crée toutes les routines, avec leurs exercices, séries, charges, répétitions et notes. N\'importe quel assistant IA peut mettre vos notes au format attendu par l\'app.';

  @override
  String get importStep1 => 'Copiez les instructions.';

  @override
  String get importStep2 =>
      'Collez-les dans un chat IA — ChatGPT, Claude, Gemini — suivies de vos notes d\'entraînement, telles que vous les avez écrites.';

  @override
  String get importStep3 =>
      'Copiez la réponse, collez-la ci-dessous et vérifiez-la avant d\'importer.';

  @override
  String get importCopyInstructions => 'Copier les instructions';

  @override
  String get importInstructionsCopied =>
      'Instructions copiées. Collez-les dans un chat IA avec vos notes.';

  @override
  String importInstructionsLanguageNote(String language) {
    return 'Les instructions sont en anglais car les assistants les suivent plus fidèlement ainsi. Vos routines reviennent en $language.';
  }

  @override
  String get importPasteLabel => 'La réponse de l\'assistant';

  @override
  String get importPasteHint => 'Collez le JSON ici';

  @override
  String get importPasteFromClipboard => 'Coller';

  @override
  String get importClipboardEmpty => 'Il n\'y a rien à coller.';

  @override
  String get importCheck => 'Vérifier';

  @override
  String get importClear => 'Effacer';

  @override
  String get importAction => 'Importer';

  @override
  String get importPreviewTitle => 'Voici ce qui sera créé';

  @override
  String importRoutineSummary(int exerciseCount, int setCount) {
    return 'Exercices : $exerciseCount · Séries : $setCount';
  }

  @override
  String get importNoticesTitle => 'À vérifier';

  @override
  String get importSuccess => 'Routines importées';

  @override
  String get importErrorEmptyInput =>
      'Collez d\'abord la réponse de l\'assistant.';

  @override
  String get importErrorInvalidJson =>
      'Ce texte n\'est pas du JSON valide. Copiez à nouveau la réponse, accolades incluses, ou demandez à l\'assistant de ne répondre qu\'avec le JSON.';

  @override
  String get importErrorNoRoutines =>
      'Aucune routine trouvée dans ce texte. Il lui faut une liste « routines » avec au moins un jour comportant des exercices.';

  @override
  String importNoticeNoExercises(String name) {
    return '« $name » a été ignorée : aucun exercice.';
  }

  @override
  String importNoticeSkippedRoutines(int count) {
    return 'Entrées ignorées faute de nom : $count.';
  }

  @override
  String importNoticeSkippedExercises(String name, int count) {
    return 'Exercices ignorés dans « $name » faute de nom : $count.';
  }

  @override
  String importNoticeDuplicateName(String name) {
    return 'Vous avez déjà une routine nommée « $name ». Celle-ci est ajoutée quand même.';
  }

  @override
  String get importSettingsSubtitle =>
      'Collez un programme et créez toutes les routines d\'un coup';
}
