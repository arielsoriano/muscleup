// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Muscleup';

  @override
  String get workouts => 'Тренировки';

  @override
  String get exercises => 'Упражнения';

  @override
  String get history => 'История';

  @override
  String get settings => 'Настройки';

  @override
  String get routines => 'Программы';

  @override
  String get sets => 'Подходы';

  @override
  String get weight => 'Вес';

  @override
  String get reps => 'Повт.';

  @override
  String get addRoutine => 'Добавить программу';

  @override
  String get addExercise => 'Добавить упражнение';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get back => 'Назад';

  @override
  String get routineDetailsTitle => 'О программе';

  @override
  String get noRoutines => 'Программы не найдены';

  @override
  String get errorLoading => 'Не удалось загрузить программы';

  @override
  String get retry => 'Повторить';

  @override
  String get dashboardTitle => 'Обзор';

  @override
  String get today => 'Сегодня';

  @override
  String get noWorkoutToday => 'В этот день тренировок не записано';

  @override
  String get startWorkout => 'Начать программу';

  @override
  String get finishWorkout => 'Завершить тренировку';

  @override
  String get workoutSavedSuccess => 'Тренировка сохранена!';

  @override
  String get finishWorkoutConfirmation =>
      'Завершить и сохранить эту тренировку?';

  @override
  String get activeWorkoutTitle => 'Текущая тренировка';

  @override
  String get set => 'Подход';

  @override
  String get target => 'Цель';

  @override
  String get actual => 'Факт';

  @override
  String get routineName => 'Название программы';

  @override
  String get exerciseName => 'Название упражнения';

  @override
  String get notes => 'Заметки';

  @override
  String get exerciseNotesLabel => 'Заметки (необязательно)';

  @override
  String get exerciseNotesHint => 'напр. эллипс или велотренажёр';

  @override
  String get removeExercise => 'Убрать упражнение';

  @override
  String get addSet => 'Добавить подход';

  @override
  String get saveRoutineSuccess => 'Программа сохранена!';

  @override
  String get editRoutine => 'Изменить программу';

  @override
  String get routineNameHint => 'напр. день ног, понедельник';

  @override
  String get searchExercises => 'Поиск упражнений...';

  @override
  String get noResults => 'Упражнения не найдены';

  @override
  String get noExercisesAdded => 'Упражнений пока нет';

  @override
  String addCustomExercise(String name) {
    return 'Добавить «$name»';
  }

  @override
  String get searchHelper => 'Введите, чтобы найти или добавить...';

  @override
  String get noSetsAdded => 'Подходы не добавлены';

  @override
  String get restTimeSeconds => 'Отдых (секунды)';

  @override
  String removeConfirmation(String name) {
    return 'Убрать $name?';
  }

  @override
  String get remove => 'Убрать';

  @override
  String get unitKg => 'кг';

  @override
  String get unitLb => 'фунт';

  @override
  String get unitReps => 'повт.';

  @override
  String get unitSeconds => 'с';

  @override
  String get unitMinutes => 'мин';

  @override
  String get unitKm => 'км';

  @override
  String get unitMeters => 'м';

  @override
  String get unitNone => 'нет';

  @override
  String get unitLevel => 'уровень';

  @override
  String get unitIncline => 'наклон';

  @override
  String setsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count подходов',
      many: '$count подходов',
      few: '$count подхода',
      one: '$count подход',
    );
    return '$_temp0';
  }

  @override
  String get language => 'Язык';

  @override
  String get appSkin => 'Тема приложения';

  @override
  String get skinVolt => 'Вольт';

  @override
  String get skinCyan => 'Бирюза';

  @override
  String get skinCrimson => 'Багровый';

  @override
  String get skinRoyalGold => 'Королевское золото';

  @override
  String get skinMonochrome => 'Монохром';

  @override
  String get selectSkin => 'Выбрать тему приложения';

  @override
  String get noExercisesInRoutine => 'В этой программе нет упражнений';

  @override
  String get deleteRoutineConfirm => 'Удалить эту программу?';

  @override
  String get delete => 'Удалить';

  @override
  String get routineDeletedSuccess => 'Программа удалена!';

  @override
  String get emptyRoutine => 'Пусто';

  @override
  String get startNewSession => 'Начать новую тренировку';

  @override
  String startRoutineName(String name) {
    return 'Начать $name';
  }

  @override
  String get addExercisesFirst => 'Сначала добавьте упражнения';

  @override
  String get deleteSessionConfirm => 'Удалить эту тренировку?';

  @override
  String get sessionDeleted => 'Тренировка удалена';

  @override
  String get resting => 'Отдых';

  @override
  String get add30Seconds => '+30 с';

  @override
  String get resumeWorkout => 'Вернуться к тренировке';

  @override
  String routineAlreadyActive(String name) {
    return '$name уже идёт. Продолжаем.';
  }

  @override
  String get noLogsFound => 'Для этой тренировки нет записей';

  @override
  String get activeWorkout => 'Текущая тренировка';

  @override
  String get inProgress => 'Идёт...';

  @override
  String get completed => 'Завершено';

  @override
  String get pendingExercises => 'Осталось';

  @override
  String get completedExercises => 'Готово';

  @override
  String get showCompletedExercises => 'Показать';

  @override
  String get hideCompletedExercises => 'Скрыть';

  @override
  String get completedSession => 'Завершённая тренировка';

  @override
  String get saveAsRoutineTarget => 'Сохранить как цель программы';

  @override
  String get saveAsRoutineTargetSuccess =>
      'Цель обновлена для следующих тренировок';

  @override
  String get saveAsRoutineTargetError => 'Не удалось обновить цель программы';

  @override
  String get editSetValue => 'Изменить значение';

  @override
  String get saveForToday => 'Сохранить на сегодня';

  @override
  String get saveForTodayDetail =>
      'Записывает значение только для этой тренировки';

  @override
  String get updateRoutineTarget => 'Обновить цель';

  @override
  String get updateRoutineTargetDetail =>
      'Меняет цель для следующих тренировок';

  @override
  String get errorEmptyName => 'Название программы не может быть пустым';

  @override
  String get noRoutinesAvailable => 'Программ пока нет';

  @override
  String get createRoutineToGetStarted => 'Создайте программу, чтобы начать';

  @override
  String get errorNoExercises =>
      'В программе должно быть хотя бы одно упражнение';

  @override
  String get errorEmptySets =>
      'В каждом упражнении должен быть хотя бы один подход';

  @override
  String get noSetsDefined => 'Подходы не заданы';

  @override
  String get authAccount => 'Аккаунт';

  @override
  String get authAnonymous => 'Анонимно';

  @override
  String get authAnonymousSubtitle =>
      'Данные хранятся только на этом устройстве. Привяжите аккаунт, чтобы синхронизировать их.';

  @override
  String get authLinkedWithGoogle => 'Привязан к Google';

  @override
  String get authContinueWithGoogle => 'Продолжить с Google';

  @override
  String get authDisconnectGoogle => 'Отвязать Google';

  @override
  String get authLinkSuccess => 'Аккаунт успешно привязан!';

  @override
  String get authGoogleSignInConfigurationError =>
      'Вход через Google не настроен для этой релизной сборки. Добавьте отпечатки SHA для релиза и Play App Signing в Firebase.';

  @override
  String get authGoogleSignInTimeout =>
      'Вход через Google занял слишком много времени. Попробуйте ещё раз.';

  @override
  String get authUnavailable => 'Облачная авторизация недоступна';

  @override
  String get appInfoSection => 'ПРИЛОЖЕНИЕ';

  @override
  String get appVersionLabel => 'Версия';

  @override
  String get appBuildLabel => 'Сборка';

  @override
  String get darkMode => 'Тёмная тема';

  @override
  String get trainingDefaultsSection => 'ЗНАЧЕНИЯ ПО УМОЛЧАНИЮ';

  @override
  String get defaultRest => 'Отдых по умолчанию';

  @override
  String get defaultRepetitions => 'Повторения по умолчанию';

  @override
  String get defaultWeight => 'Вес по умолчанию';

  @override
  String get autoStartRestTimerOnComplete => 'Запускать отдых после подхода';

  @override
  String get autoStartRestTimerOnCompleteSubtitle =>
      'Когда вы отмечаете подход выполненным, таймер стартует сам';

  @override
  String get restSecondsDialogTitle => 'Отдых (секунды)';

  @override
  String get repetitionsDialogTitle => 'Повторения';

  @override
  String get weightKgDialogTitle => 'Вес (кг)';

  @override
  String get globalManagementSection => 'ОБЩЕЕ УПРАВЛЕНИЕ';

  @override
  String get manageExercises => 'Управление упражнениями';

  @override
  String get manageExercisesSubtitle =>
      'Создавайте, изменяйте и удаляйте упражнения в одном месте';

  @override
  String get exerciseLibraryTitle => 'Библиотека упражнений';

  @override
  String get newLabel => 'Новое';

  @override
  String get newExerciseTitle => 'Новое упражнение';

  @override
  String get editExerciseTitle => 'Изменить упражнение';

  @override
  String get deleteExerciseTitle => 'Удалить упражнение';

  @override
  String deleteExerciseConfirm(String name) {
    return 'Удалить $name?';
  }

  @override
  String get changesSaved => 'Изменения сохранены';

  @override
  String get exerciseNameHint => 'Название упражнения';

  @override
  String get noExercisesToShow => 'Упражнений нет';

  @override
  String get customLabel => 'Своё';

  @override
  String get libraryLabel => 'Библиотека';

  @override
  String get syncCloudSection => 'ОБЛАЧНАЯ СИНХРОНИЗАЦИЯ';

  @override
  String get neverSynced => 'Ни разу не синхронизировано';

  @override
  String get syncing => 'Синхронизация...';

  @override
  String get globalSyncOverlayTitle => 'Синхронизируем ваши данные';

  @override
  String get globalSyncOverlaySubtitle =>
      'Загружаем программы и историю из облака...';

  @override
  String get routinesSyncingPlaceholder =>
      'Загружаем ваши программы из облака...';

  @override
  String get syncPending => 'Ожидает синхронизации';

  @override
  String get synced => 'Сохранено в облаке';

  @override
  String get syncLocked => 'Резервные копии выключены';

  @override
  String lastSync(String date) {
    return 'Последняя синхронизация: $date';
  }

  @override
  String get linkGoogleForSync =>
      'Привяжите аккаунт Google, чтобы включить облачную синхронизацию';

  @override
  String get refreshNow => 'Обновить';

  @override
  String lastTimeValue(String value) {
    return 'В прошлый раз: $value';
  }

  @override
  String get exerciseProgressTitle => 'Прогресс';

  @override
  String get viewProgress => 'Смотреть прогресс';

  @override
  String get noProgressYet =>
      'Записей пока нет. Завершите тренировку с этим упражнением, чтобы увидеть здесь свой прогресс.';

  @override
  String progressSessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count тренировок',
      many: '$count тренировок',
      few: '$count тренировки',
      one: '$count тренировка',
    );
    return '$_temp0';
  }

  @override
  String get helpFeedbackSection => 'Помощь и отзывы';

  @override
  String get sendFeedback => 'Отправить отзыв';

  @override
  String get sendFeedbackSubtitle =>
      'Предложения, идеи или сообщение о проблеме';

  @override
  String get feedbackEmailSubject => 'Muscleup — Отзыв';

  @override
  String get feedbackEmailBody =>
      'Напишите здесь свой отзыв, идею или проблему:';

  @override
  String get emailCopiedToClipboard =>
      'Не удалось открыть почтовое приложение. Адрес скопирован в буфер обмена.';

  @override
  String get legalSection => 'Правовая информация';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get privacyPolicySubtitle =>
      'Как Muscleup обращается с вашими данными';

  @override
  String privacyPolicyLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Обновлено: $dateString';
  }

  @override
  String get privacyPolicyIntro =>
      'Muscleup — приложение для учёта тренировок. Эта политика объясняет, какие данные приложение может собирать, как они используются и какие у вас есть возможности выбора.';

  @override
  String get privacyPolicyDataTitle => 'Какие данные мы собираем';

  @override
  String get privacyPolicyDataItem1 =>
      'Данные аккаунта: имя, адрес электронной почты и идентификатор пользователя.';

  @override
  String get privacyPolicyDataItem2 =>
      'Данные тренировок: программы, упражнения, подходы, вес, повторения, тренировки, история и заметки, которые вы вводите в приложении.';

  @override
  String get privacyPolicyDataItem3 =>
      'Настройки приложения: язык, тема и параметры, связанные с тренировками.';

  @override
  String get privacyPolicyCollectionTitle => 'Как собираются данные';

  @override
  String get privacyPolicyCollectionItem1 =>
      'Приложением можно пользоваться локально, не привязывая аккаунт.';

  @override
  String get privacyPolicyCollectionItem2 =>
      'Если вы привязываете аккаунт Google, для входа Muscleup использует Firebase Authentication.';

  @override
  String get privacyPolicyCollectionItem3 =>
      'Если вы включаете облачную синхронизацию, данные хранятся в Google Firebase Cloud Firestore и связаны с вашим аккаунтом.';

  @override
  String get privacyPolicyUsageTitle => 'Как мы используем данные';

  @override
  String get privacyPolicyUsageItem1 =>
      'Чтобы обеспечить вход и управление аккаунтом.';

  @override
  String get privacyPolicyUsageItem2 =>
      'Чтобы сохранять, синхронизировать и восстанавливать ваши программы и историю тренировок.';

  @override
  String get privacyPolicyUsageItem3 =>
      'Чтобы хранить ваши настройки и обеспечивать основные функции приложения.';

  @override
  String get privacyPolicySharingTitle => 'Передача данных';

  @override
  String get privacyPolicySharingBody =>
      'Muscleup не продаёт ваши данные и не передаёт их третьим лицам в рекламных или маркетинговых целях. Данные могут обрабатываться поставщиками инфраструктуры, необходимыми для работы приложения, например Firebase Authentication и Cloud Firestore.';

  @override
  String get privacyPolicySecurityTitle => 'Шифрование и безопасность';

  @override
  String get privacyPolicySecurityBody =>
      'Данные передаются по защищённым шифрованным соединениям. Доступ к синхронизированным данным есть только у авторизованного пользователя, которому они принадлежат.';

  @override
  String get privacyPolicyRetentionTitle => 'Хранение данных';

  @override
  String get privacyPolicyRetentionBody =>
      'Данные хранятся, пока вы сохраняете аккаунт и пользуетесь облачной синхронизацией, если вы не запросили удаление. Небольшой объём технических данных может временно оставаться в резервных копиях инфраструктуры в течение ограниченного срока.';

  @override
  String get privacyPolicyDeletionTitle => 'Удаление аккаунта и данных';

  @override
  String get privacyPolicyDeletionBody =>
      'Вы можете в любой момент запросить удаление аккаунта и всех связанных с ним данных. На странице удаления аккаунта описан весь порядок действий, что именно удаляется и сколько это занимает. Мы подтвердим по электронной почте, когда данные будут удалены.';

  @override
  String get privacyPolicyChildrenTitle => 'Конфиденциальность детей';

  @override
  String get privacyPolicyChildrenBody =>
      'Muscleup не предназначено специально для детей младше 13 лет.';

  @override
  String get privacyPolicyContactTitle => 'Контакты';

  @override
  String get privacyPolicyContactBody =>
      'Если у вас есть вопросы по этой политике, напишите нам:';

  @override
  String get privacyPolicyOpenOnline => 'Открыть версию в интернете';

  @override
  String get privacyPolicyAccountDeletionPage =>
      'Открыть страницу удаления аккаунта';

  @override
  String get privacyPolicyAccountDeletion => 'Запросить удаление по почте';

  @override
  String get accountDeletionEmailSubject =>
      'Muscleup — Запрос на удаление аккаунта';

  @override
  String get accountDeletionEmailBody =>
      'Прошу удалить мой аккаунт Muscleup и все связанные с ним данные.';

  @override
  String get couldNotOpenLink =>
      'Не удалось открыть ссылку на этом устройстве.';

  @override
  String get exitAppTitle => 'Выйти из Muscleup?';

  @override
  String get exitAppMessage => 'Закрыть приложение?';

  @override
  String get exitAppConfirm => 'Выйти';

  @override
  String get importTitle => 'Импорт программ';

  @override
  String get importHeadline => 'Перенесите всю программу за один шаг';

  @override
  String get importIntro =>
      'Вставьте свой план тренировок, и Muscleup создаст все программы с упражнениями, подходами, весами, повторениями и заметками. Любой ИИ-ассистент может привести ваши записи к нужному формату.';

  @override
  String get importStep1 => 'Скопируйте инструкцию.';

  @override
  String get importStep2 =>
      'Вставьте её в чат с ИИ — ChatGPT, Claude, Gemini — а сразу за ней свои записи о тренировках в том виде, в котором они у вас есть.';

  @override
  String get importStep3 =>
      'Скопируйте ответ, вставьте его ниже и проверьте перед импортом.';

  @override
  String get importCopyInstructions => 'Скопировать инструкцию';

  @override
  String get importInstructionsCopied =>
      'Инструкция скопирована. Вставьте её в чат с ИИ вместе со своими записями.';

  @override
  String importInstructionsLanguageNote(String language) {
    return 'Инструкция на английском: так ассистенты выполняют её точнее. Программы вернутся на $language.';
  }

  @override
  String get importPasteLabel => 'Ответ ассистента';

  @override
  String get importPasteHint => 'Вставьте JSON здесь';

  @override
  String get importPasteFromClipboard => 'Вставить';

  @override
  String get importClipboardEmpty => 'Вставлять нечего.';

  @override
  String get importCheck => 'Проверить';

  @override
  String get importClear => 'Очистить';

  @override
  String get importAction => 'Импортировать';

  @override
  String get importPreviewTitle => 'Вот что будет создано';

  @override
  String importRoutineSummary(int exerciseCount, int setCount) {
    return 'Упражнений: $exerciseCount · Подходов: $setCount';
  }

  @override
  String get importNoticesTitle => 'Стоит проверить';

  @override
  String get importSuccess => 'Программы импортированы';

  @override
  String get importErrorEmptyInput => 'Сначала вставьте ответ ассистента.';

  @override
  String get importErrorInvalidJson =>
      'Это не корректный JSON. Скопируйте ответ заново вместе с фигурными скобками или попросите ассистента ответить только JSON.';

  @override
  String get importErrorNoRoutines =>
      'В этом тексте не найдено программ. Нужен список «routines» хотя бы с одним днём, в котором есть упражнения.';

  @override
  String importNoticeNoExercises(String name) {
    return '«$name» пропущена: нет упражнений.';
  }

  @override
  String importNoticeSkippedRoutines(int count) {
    return 'Пропущено записей без названия: $count.';
  }

  @override
  String importNoticeSkippedExercises(String name, int count) {
    return 'Пропущено упражнений без названия в «$name»: $count.';
  }

  @override
  String importNoticeDuplicateName(String name) {
    return 'Программа «$name» у вас уже есть. Эта будет добавлена дополнительно.';
  }

  @override
  String get importSettingsSubtitle =>
      'Вставьте план и создайте все программы сразу';

  @override
  String get exportTitle => 'Экспорт программ';

  @override
  String get exportSettingsSubtitle =>
      'Сохраните копию, которую можно вставить обратно';

  @override
  String get exportIntro =>
      'Это все ваши программы в том же формате, который читает экран импорта. Сохраните его в заметке или файле: вставив обратно, вы получите их снова — с упражнениями, подходами, весами и заметками, здесь или на новом телефоне.';

  @override
  String get exportHistoryNote =>
      'Записанные тренировки не включены: здесь только ваши программы.';

  @override
  String exportSummary(int routineCount, int exerciseCount, int setCount) {
    return 'Программ: $routineCount · Упражнений: $exerciseCount · Подходов: $setCount';
  }

  @override
  String get exportCopy => 'Скопировать JSON';

  @override
  String get exportCopied =>
      'Программы скопированы. Вставьте их туда, где сможете сохранить.';

  @override
  String get exportEmpty => 'У вас пока нет программ для экспорта.';

  @override
  String get exportError =>
      'Не удалось прочитать ваши программы. Попробуйте ещё раз.';
}
