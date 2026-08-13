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
  String get finishWorkoutConfirmation =>
      '¿Estás seguro de que quieres finalizar y guardar este entrenamiento?';

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
  String get notes => 'Notas';

  @override
  String get exerciseNotesLabel => 'Notas (opcional)';

  @override
  String get exerciseNotesHint => 'ej. Elíptica o bici';

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
  String get unitLevel => 'nivel';

  @override
  String get unitIncline => 'inclinación';

  @override
  String setsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count series',
      one: '1 serie',
    );
    return '$_temp0';
  }

  @override
  String get language => 'Idioma';

  @override
  String get appSkin => 'Tema de la App';

  @override
  String get skinVolt => 'Volt';

  @override
  String get skinCyan => 'Cian';

  @override
  String get skinCrimson => 'Carmesí';

  @override
  String get skinRoyalGold => 'Dorado Real';

  @override
  String get skinMonochrome => 'Monocromo';

  @override
  String get selectSkin => 'Seleccionar Tema';

  @override
  String get noExercisesInRoutine => 'No hay ejercicios en esta rutina';

  @override
  String get deleteRoutineConfirm =>
      '¿Estás seguro de que quieres eliminar esta rutina?';

  @override
  String get delete => 'Eliminar';

  @override
  String get routineDeletedSuccess => '¡Rutina eliminada exitosamente!';

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

  @override
  String get deleteSessionConfirm =>
      '¿Estás seguro de que quieres eliminar esta sesión de entrenamiento?';

  @override
  String get sessionDeleted => 'Sesión eliminada';

  @override
  String get resting => 'Descansando';

  @override
  String get add30Seconds => '+30s';

  @override
  String get resumeWorkout => 'Continuar entrenamiento actual';

  @override
  String routineAlreadyActive(String name) {
    return 'Ya tienes $name en progreso. Continuando sesión.';
  }

  @override
  String get noLogsFound => 'No se encontraron registros para esta sesión';

  @override
  String get activeWorkout => 'Entrenamiento Activo';

  @override
  String get inProgress => 'En progreso...';

  @override
  String get completed => 'Completado';

  @override
  String get pendingExercises => 'Pendientes';

  @override
  String get completedExercises => 'Completados';

  @override
  String get showCompletedExercises => 'Mostrar';

  @override
  String get hideCompletedExercises => 'Ocultar';

  @override
  String get completedSession => 'Sesión Completada';

  @override
  String get saveAsRoutineTarget => 'Guardar como objetivo';

  @override
  String get saveAsRoutineTargetSuccess =>
      'Objetivo actualizado para futuras rutinas';

  @override
  String get saveAsRoutineTargetError =>
      'No se pudo actualizar el objetivo de la rutina';

  @override
  String get editSetValue => 'Editar valor';

  @override
  String get saveForToday => 'Solo hoy';

  @override
  String get saveForTodayDetail =>
      'Registra solo el valor de este entrenamiento';

  @override
  String get updateRoutineTarget => 'Actualizar objetivo';

  @override
  String get updateRoutineTargetDetail =>
      'Cambia el objetivo para futuras rutinas';

  @override
  String get errorEmptyName => 'El nombre de la rutina no puede estar vacío';

  @override
  String get noRoutinesAvailable => 'No hay rutinas disponibles';

  @override
  String get createRoutineToGetStarted => 'Crea una rutina para comenzar';

  @override
  String get errorNoExercises => 'La rutina debe tener al menos un ejercicio';

  @override
  String get errorEmptySets => 'Cada ejercicio debe tener al menos una serie';

  @override
  String get noSetsDefined => 'No hay series definidas';

  @override
  String get authAccount => 'Cuenta';

  @override
  String get authAnonymous => 'Anónimo';

  @override
  String get authAnonymousSubtitle =>
      'Tus datos se guardan localmente. Vincula una cuenta para sincronizar.';

  @override
  String get authLinkedWithGoogle => 'Vinculado con Google';

  @override
  String get authContinueWithGoogle => 'Continuar con Google';

  @override
  String get authDisconnectGoogle => 'Desconectar Google';

  @override
  String get authLinkSuccess => '¡Cuenta vinculada exitosamente!';

  @override
  String get authGoogleSignInConfigurationError =>
      'Google Sign-In no está configurado para esta build release. Agrega los SHA de release y de Play App Signing en Firebase.';

  @override
  String get authGoogleSignInTimeout =>
      'El inicio de sesión con Google tardó demasiado. Inténtalo de nuevo.';

  @override
  String get authUnavailable => 'Auth en la nube no disponible';

  @override
  String get appInfoSection => 'APP';

  @override
  String get appVersionLabel => 'Versión';

  @override
  String get appBuildLabel => 'Build';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get trainingDefaultsSection => 'VALORES PREDETERMINADOS';

  @override
  String get defaultRest => 'Descanso predeterminado';

  @override
  String get defaultRepetitions => 'Repeticiones predeterminadas';

  @override
  String get defaultWeight => 'Peso predeterminado';

  @override
  String get autoStartRestTimerOnComplete =>
      'Iniciar descanso al completar serie';

  @override
  String get autoStartRestTimerOnCompleteSubtitle =>
      'Al marcar una serie como completada, inicia el timer automáticamente';

  @override
  String get restSecondsDialogTitle => 'Descanso (segundos)';

  @override
  String get repetitionsDialogTitle => 'Repeticiones';

  @override
  String get weightKgDialogTitle => 'Peso (kg)';

  @override
  String get globalManagementSection => 'GESTION GLOBAL';

  @override
  String get manageExercises => 'Gestionar ejercicios';

  @override
  String get manageExercisesSubtitle =>
      'Editar, eliminar y crear ejercicios desde un solo lugar';

  @override
  String get exerciseLibraryTitle => 'Gestion de ejercicios';

  @override
  String get newLabel => 'Nuevo';

  @override
  String get newExerciseTitle => 'Nuevo ejercicio';

  @override
  String get editExerciseTitle => 'Editar ejercicio';

  @override
  String get deleteExerciseTitle => 'Eliminar ejercicio';

  @override
  String deleteExerciseConfirm(String name) {
    return '¿Seguro que quieres eliminar $name?';
  }

  @override
  String get changesSaved => 'Cambios guardados';

  @override
  String get exerciseNameHint => 'Nombre del ejercicio';

  @override
  String get noExercisesToShow => 'No hay ejercicios para mostrar';

  @override
  String get customLabel => 'Personalizado';

  @override
  String get libraryLabel => 'Biblioteca';

  @override
  String get syncCloudSection => 'SINCRONIZACION NUBE';

  @override
  String get neverSynced => 'Nunca sincronizado';

  @override
  String get syncing => 'Sincronizando...';

  @override
  String get globalSyncOverlayTitle => 'Sincronizando tus datos';

  @override
  String get globalSyncOverlaySubtitle =>
      'Preparando rutinas e historial desde la nube...';

  @override
  String get routinesSyncingPlaceholder =>
      'Cargando tus rutinas desde la nube...';

  @override
  String get syncPending => 'Sincronización pendiente';

  @override
  String get synced => 'Copia de seguridad al día';

  @override
  String get syncLocked => 'Copia de seguridad desactivada';

  @override
  String lastSync(String date) {
    return 'Última sincronización: $date';
  }

  @override
  String get linkGoogleForSync =>
      'Vincula tu cuenta de Google para habilitar la sincronización en la nube';

  @override
  String get refreshNow => 'Actualizar ahora';

  @override
  String lastTimeValue(String value) {
    return 'La vez pasada: $value';
  }

  @override
  String get exerciseProgressTitle => 'Progreso';

  @override
  String get viewProgress => 'Ver progreso';

  @override
  String get noProgressYet =>
      'Todavía no hay registros. Terminá un entrenamiento con este ejercicio para ver tu progreso acá.';

  @override
  String progressSessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sesiones',
      one: '1 sesión',
    );
    return '$_temp0';
  }

  @override
  String get helpFeedbackSection => 'Ayuda y feedback';

  @override
  String get sendFeedback => 'Enviar feedback';

  @override
  String get sendFeedbackSubtitle =>
      'Sugerencias, ideas o reportar un problema';

  @override
  String get feedbackEmailSubject => 'Muscleup — Feedback';

  @override
  String get feedbackEmailBody => 'Escribí tu feedback, idea o problema acá:';

  @override
  String get emailCopiedToClipboard =>
      'No pudimos abrir tu app de correo. Copiamos la dirección al portapapeles.';

  @override
  String get legalSection => 'Legal';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get privacyPolicySubtitle => 'Cómo Muscleup trata tus datos';

  @override
  String privacyPolicyLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Última actualización: $dateString';
  }

  @override
  String get privacyPolicyIntro =>
      'Muscleup es una app de seguimiento de entrenamientos. Esta política explica qué datos puede recopilar la app, cómo se usan y qué opciones tenés sobre ellos.';

  @override
  String get privacyPolicyDataTitle => 'Datos que recopilamos';

  @override
  String get privacyPolicyDataItem1 =>
      'Información de cuenta, como nombre, correo electrónico e ID de usuario.';

  @override
  String get privacyPolicyDataItem2 =>
      'Datos de entrenamiento, como rutinas, ejercicios, series, peso, repeticiones, sesiones, historial y notas opcionales que escribas en la app.';

  @override
  String get privacyPolicyDataItem3 =>
      'Ajustes de la app, como idioma, tema y preferencias relacionadas con el entrenamiento.';

  @override
  String get privacyPolicyCollectionTitle => 'Cómo se recopilan los datos';

  @override
  String get privacyPolicyCollectionItem1 =>
      'La app puede usarse localmente sin vincular una cuenta.';

  @override
  String get privacyPolicyCollectionItem2 =>
      'Si elegís vincular tu cuenta con Google, Muscleup usa Firebase Authentication para la autenticación.';

  @override
  String get privacyPolicyCollectionItem3 =>
      'Si elegís sincronización en la nube, los datos se almacenan en Google Firebase Cloud Firestore asociados a tu cuenta.';

  @override
  String get privacyPolicyUsageTitle => 'Cómo usamos los datos';

  @override
  String get privacyPolicyUsageItem1 =>
      'Para habilitar el inicio de sesión y la administración de tu cuenta.';

  @override
  String get privacyPolicyUsageItem2 =>
      'Para guardar, sincronizar y restaurar tus rutinas e historial de entrenamiento.';

  @override
  String get privacyPolicyUsageItem3 =>
      'Para guardar tus preferencias y ofrecer el funcionamiento básico de la app.';

  @override
  String get privacyPolicySharingTitle => 'Compartición de datos';

  @override
  String get privacyPolicySharingBody =>
      'Muscleup no vende tus datos ni los comparte con terceros con fines publicitarios o de marketing. Los datos pueden ser procesados por proveedores de infraestructura necesarios para operar la app, como Firebase Authentication y Cloud Firestore.';

  @override
  String get privacyPolicySecurityTitle => 'Encriptación y seguridad';

  @override
  String get privacyPolicySecurityBody =>
      'Los datos se transfieren mediante conexiones seguras cifradas en tránsito. El acceso a los datos sincronizados está restringido al usuario autenticado correspondiente.';

  @override
  String get privacyPolicyRetentionTitle => 'Conservación de datos';

  @override
  String get privacyPolicyRetentionBody =>
      'Los datos se conservan mientras mantengas tu cuenta y uses la sincronización en la nube, salvo que solicites su eliminación. Algunos datos técnicos mínimos pueden permanecer temporalmente en respaldos del proveedor de infraestructura por un tiempo limitado.';

  @override
  String get privacyPolicyDeletionTitle => 'Eliminación de cuenta y datos';

  @override
  String get privacyPolicyDeletionBody =>
      'Podés solicitar la eliminación de tu cuenta y de todos los datos asociados en cualquier momento. La página de eliminación de cuenta tiene las instrucciones completas, qué se elimina exactamente y cuánto demora. Te confirmamos por mail cuando tus datos hayan sido eliminados.';

  @override
  String get privacyPolicyChildrenTitle => 'Privacidad de menores';

  @override
  String get privacyPolicyChildrenBody =>
      'Muscleup no está diseñada específicamente para niños menores de 13 años.';

  @override
  String get privacyPolicyContactTitle => 'Contacto';

  @override
  String get privacyPolicyContactBody =>
      'Si tenés preguntas sobre esta política, escribinos a:';

  @override
  String get privacyPolicyOpenOnline => 'Ver la versión online';

  @override
  String get privacyPolicyAccountDeletionPage =>
      'Abrir la página de eliminación de cuenta';

  @override
  String get privacyPolicyAccountDeletion => 'Solicitar eliminación por mail';

  @override
  String get accountDeletionEmailSubject =>
      'Muscleup — Solicitud de eliminación de cuenta';

  @override
  String get accountDeletionEmailBody =>
      'Quiero solicitar la eliminación de mi cuenta de Muscleup y de todos los datos asociados.';

  @override
  String get couldNotOpenLink =>
      'No pudimos abrir el enlace en este dispositivo.';

  @override
  String get exitAppTitle => '¿Salir de Muscleup?';

  @override
  String get exitAppMessage => '¿Seguro que querés cerrar la app?';

  @override
  String get exitAppConfirm => 'Salir';
}
