// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Muscleup';

  @override
  String get workouts => 'Treningi';

  @override
  String get exercises => 'Ćwiczenia';

  @override
  String get history => 'Historia';

  @override
  String get settings => 'Ustawienia';

  @override
  String get routines => 'Plany';

  @override
  String get sets => 'Serie';

  @override
  String get weight => 'Ciężar';

  @override
  String get reps => 'Powt.';

  @override
  String get addRoutine => 'Dodaj plan';

  @override
  String get addExercise => 'Dodaj ćwiczenie';

  @override
  String get save => 'Zapisz';

  @override
  String get cancel => 'Anuluj';

  @override
  String get back => 'Wstecz';

  @override
  String get routineDetailsTitle => 'Szczegóły planu';

  @override
  String get noRoutines => 'Nie znaleziono planów';

  @override
  String get errorLoading => 'Nie udało się wczytać planów';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get dashboardTitle => 'Przegląd';

  @override
  String get today => 'Dzisiaj';

  @override
  String get noWorkoutToday => 'Brak zapisanego treningu w tym dniu';

  @override
  String get startWorkout => 'Rozpocznij plan';

  @override
  String get finishWorkout => 'Zakończ trening';

  @override
  String get workoutSavedSuccess => 'Trening zapisany!';

  @override
  String get finishWorkoutConfirmation =>
      'Na pewno zakończyć i zapisać ten trening?';

  @override
  String get activeWorkoutTitle => 'Trwający trening';

  @override
  String get set => 'Seria';

  @override
  String get target => 'Cel';

  @override
  String get actual => 'Wynik';

  @override
  String get routineName => 'Nazwa planu';

  @override
  String get exerciseName => 'Nazwa ćwiczenia';

  @override
  String get notes => 'Notatki';

  @override
  String get exerciseNotesLabel => 'Notatki (opcjonalnie)';

  @override
  String get exerciseNotesHint => 'np. orbitrek lub rower';

  @override
  String get removeExercise => 'Usuń ćwiczenie';

  @override
  String get addSet => 'Dodaj serię';

  @override
  String get saveRoutineSuccess => 'Plan zapisany!';

  @override
  String get editRoutine => 'Edytuj plan';

  @override
  String get routineNameHint => 'np. dzień nóg, poniedziałek';

  @override
  String get searchExercises => 'Szukaj ćwiczeń...';

  @override
  String get noResults => 'Nie znaleziono ćwiczeń';

  @override
  String get noExercisesAdded => 'Nie dodano jeszcze ćwiczeń';

  @override
  String addCustomExercise(String name) {
    return 'Dodaj „$name”';
  }

  @override
  String get searchHelper => 'Wpisz, aby wyszukać lub dodać...';

  @override
  String get noSetsAdded => 'Nie dodano serii';

  @override
  String get restTimeSeconds => 'Przerwa (sekundy)';

  @override
  String removeConfirmation(String name) {
    return 'Na pewno usunąć $name?';
  }

  @override
  String get remove => 'Usuń';

  @override
  String get unitKg => 'kg';

  @override
  String get unitLb => 'lb';

  @override
  String get unitReps => 'powt.';

  @override
  String get unitSeconds => 's';

  @override
  String get unitMinutes => 'min';

  @override
  String get unitKm => 'km';

  @override
  String get unitMeters => 'm';

  @override
  String get unitNone => 'brak';

  @override
  String get unitLevel => 'poziom';

  @override
  String get unitIncline => 'nachylenie';

  @override
  String setsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count serii',
      many: '$count serii',
      few: '$count serie',
      one: '$count seria',
    );
    return '$_temp0';
  }

  @override
  String get language => 'Język';

  @override
  String get appSkin => 'Motyw aplikacji';

  @override
  String get skinVolt => 'Volt';

  @override
  String get skinCyan => 'Cyjan';

  @override
  String get skinCrimson => 'Karmazyn';

  @override
  String get skinRoyalGold => 'Królewskie złoto';

  @override
  String get skinMonochrome => 'Monochrom';

  @override
  String get selectSkin => 'Wybierz motyw aplikacji';

  @override
  String get noExercisesInRoutine => 'Brak ćwiczeń w tym planie';

  @override
  String get deleteRoutineConfirm => 'Na pewno usunąć ten plan?';

  @override
  String get delete => 'Usuń';

  @override
  String get routineDeletedSuccess => 'Plan usunięty!';

  @override
  String get emptyRoutine => 'Pusty';

  @override
  String get startNewSession => 'Rozpocznij nowy trening';

  @override
  String startRoutineName(String name) {
    return 'Rozpocznij $name';
  }

  @override
  String get addExercisesFirst => 'Najpierw dodaj ćwiczenia';

  @override
  String get deleteSessionConfirm => 'Na pewno usunąć ten trening?';

  @override
  String get sessionDeleted => 'Trening usunięty';

  @override
  String get resting => 'Przerwa';

  @override
  String get add30Seconds => '+30 s';

  @override
  String get resumeWorkout => 'Wróć do trwającego treningu';

  @override
  String routineAlreadyActive(String name) {
    return '$name już trwa. Wracamy do niego.';
  }

  @override
  String get noLogsFound => 'Brak zapisów dla tego treningu';

  @override
  String get activeWorkout => 'Trwający trening';

  @override
  String get inProgress => 'W trakcie...';

  @override
  String get completed => 'Ukończono';

  @override
  String get pendingExercises => 'Do zrobienia';

  @override
  String get completedExercises => 'Zrobione';

  @override
  String get showCompletedExercises => 'Pokaż';

  @override
  String get hideCompletedExercises => 'Ukryj';

  @override
  String get completedSession => 'Ukończony trening';

  @override
  String get saveAsRoutineTarget => 'Zapisz jako cel planu';

  @override
  String get saveAsRoutineTargetSuccess =>
      'Cel zaktualizowany na kolejne treningi';

  @override
  String get saveAsRoutineTargetError =>
      'Nie udało się zaktualizować celu planu';

  @override
  String get editSetValue => 'Edytuj wartość';

  @override
  String get saveForToday => 'Zapisz na dziś';

  @override
  String get saveForTodayDetail => 'Zapisuje wartość tylko dla tego treningu';

  @override
  String get updateRoutineTarget => 'Zaktualizuj cel';

  @override
  String get updateRoutineTargetDetail => 'Zmienia cel na kolejne treningi';

  @override
  String get errorEmptyName => 'Nazwa planu nie może być pusta';

  @override
  String get noRoutinesAvailable => 'Brak dostępnych planów';

  @override
  String get createRoutineToGetStarted => 'Utwórz plan, aby zacząć';

  @override
  String get errorNoExercises =>
      'Plan musi zawierać co najmniej jedno ćwiczenie';

  @override
  String get errorEmptySets =>
      'Każde ćwiczenie musi mieć co najmniej jedną serię';

  @override
  String get noSetsDefined => 'Nie zdefiniowano serii';

  @override
  String get authAccount => 'Konto';

  @override
  String get authAnonymous => 'Anonimowo';

  @override
  String get authAnonymousSubtitle =>
      'Twoje dane są zapisane tylko na tym urządzeniu. Połącz konto, aby je synchronizować.';

  @override
  String get authLinkedWithGoogle => 'Połączono z Google';

  @override
  String get authContinueWithGoogle => 'Kontynuuj z Google';

  @override
  String get authDisconnectGoogle => 'Odłącz Google';

  @override
  String get authLinkSuccess => 'Konto połączone!';

  @override
  String get authGoogleSignInConfigurationError =>
      'Logowanie Google nie jest skonfigurowane dla tej wersji. Dodaj odciski SHA dla release i Play App Signing w Firebase.';

  @override
  String get authGoogleSignInTimeout =>
      'Logowanie Google trwało zbyt długo. Spróbuj ponownie.';

  @override
  String get authUnavailable => 'Logowanie w chmurze niedostępne';

  @override
  String get appInfoSection => 'APLIKACJA';

  @override
  String get appVersionLabel => 'Wersja';

  @override
  String get appBuildLabel => 'Kompilacja';

  @override
  String get darkMode => 'Tryb ciemny';

  @override
  String get trainingDefaultsSection => 'DOMYŚLNE WARTOŚCI TRENINGU';

  @override
  String get defaultRest => 'Domyślna przerwa';

  @override
  String get defaultRepetitions => 'Domyślne powtórzenia';

  @override
  String get defaultWeight => 'Domyślny ciężar';

  @override
  String get autoStartRestTimerOnComplete =>
      'Uruchom przerwę po ukończeniu serii';

  @override
  String get autoStartRestTimerOnCompleteSubtitle =>
      'Gdy oznaczysz serię jako ukończoną, minutnik ruszy sam';

  @override
  String get restSecondsDialogTitle => 'Przerwa (sekundy)';

  @override
  String get repetitionsDialogTitle => 'Powtórzenia';

  @override
  String get weightKgDialogTitle => 'Ciężar (kg)';

  @override
  String get globalManagementSection => 'ZARZĄDZANIE OGÓLNE';

  @override
  String get manageExercises => 'Zarządzaj ćwiczeniami';

  @override
  String get manageExercisesSubtitle =>
      'Twórz, edytuj i usuwaj ćwiczenia w jednym miejscu';

  @override
  String get exerciseLibraryTitle => 'Biblioteka ćwiczeń';

  @override
  String get newLabel => 'Nowe';

  @override
  String get newExerciseTitle => 'Nowe ćwiczenie';

  @override
  String get editExerciseTitle => 'Edytuj ćwiczenie';

  @override
  String get deleteExerciseTitle => 'Usuń ćwiczenie';

  @override
  String deleteExerciseConfirm(String name) {
    return 'Na pewno usunąć $name?';
  }

  @override
  String get changesSaved => 'Zmiany zapisane';

  @override
  String get exerciseNameHint => 'Nazwa ćwiczenia';

  @override
  String get noExercisesToShow => 'Brak ćwiczeń do wyświetlenia';

  @override
  String get customLabel => 'Własne';

  @override
  String get libraryLabel => 'Biblioteka';

  @override
  String get syncCloudSection => 'SYNCHRONIZACJA W CHMURZE';

  @override
  String get neverSynced => 'Nigdy nie synchronizowano';

  @override
  String get syncing => 'Synchronizacja...';

  @override
  String get globalSyncOverlayTitle => 'Synchronizujemy Twoje dane';

  @override
  String get globalSyncOverlaySubtitle =>
      'Pobieramy plany i historię z chmury...';

  @override
  String get routinesSyncingPlaceholder => 'Pobieramy Twoje plany z chmury...';

  @override
  String get syncPending => 'Oczekuje na synchronizację';

  @override
  String get synced => 'Zapisano w chmurze';

  @override
  String get syncLocked => 'Kopia zapasowa wyłączona';

  @override
  String lastSync(String date) {
    return 'Ostatnia synchronizacja: $date';
  }

  @override
  String get linkGoogleForSync =>
      'Połącz konto Google, aby włączyć synchronizację w chmurze';

  @override
  String get refreshNow => 'Odśwież teraz';

  @override
  String lastTimeValue(String value) {
    return 'Ostatnim razem: $value';
  }

  @override
  String get exerciseProgressTitle => 'Postępy';

  @override
  String get viewProgress => 'Zobacz postępy';

  @override
  String get noProgressYet =>
      'Brak zapisów. Ukończ trening z tym ćwiczeniem, aby zobaczyć tu swoje postępy.';

  @override
  String progressSessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count treningów',
      many: '$count treningów',
      few: '$count treningi',
      one: '$count trening',
    );
    return '$_temp0';
  }

  @override
  String get helpFeedbackSection => 'Pomoc i opinie';

  @override
  String get sendFeedback => 'Wyślij opinię';

  @override
  String get sendFeedbackSubtitle =>
      'Propozycje, pomysły lub zgłoszenie problemu';

  @override
  String get feedbackEmailSubject => 'Muscleup — Opinia';

  @override
  String get feedbackEmailBody =>
      'Napisz tutaj swoją opinię, pomysł lub problem:';

  @override
  String get emailCopiedToClipboard =>
      'Nie udało się otworzyć aplikacji pocztowej. Adres skopiowano do schowka.';

  @override
  String get legalSection => 'Informacje prawne';

  @override
  String get privacyPolicy => 'Polityka prywatności';

  @override
  String get privacyPolicySubtitle => 'Jak Muscleup postępuje z Twoimi danymi';

  @override
  String privacyPolicyLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Ostatnia aktualizacja: $dateString';
  }

  @override
  String get privacyPolicyIntro =>
      'Muscleup to aplikacja do zapisywania treningów. Ta polityka wyjaśnia, jakie dane aplikacja może zbierać, w jaki sposób są wykorzystywane i jakie masz w związku z tym możliwości wyboru.';

  @override
  String get privacyPolicyDataTitle => 'Dane, które zbieramy';

  @override
  String get privacyPolicyDataItem1 =>
      'Dane konta, takie jak imię, adres e-mail i identyfikator użytkownika.';

  @override
  String get privacyPolicyDataItem2 =>
      'Dane treningowe, takie jak plany, ćwiczenia, serie, ciężar, powtórzenia, treningi, historia oraz opcjonalne notatki wpisywane w aplikacji.';

  @override
  String get privacyPolicyDataItem3 =>
      'Ustawienia aplikacji, takie jak język, motyw i preferencje związane z treningiem.';

  @override
  String get privacyPolicyCollectionTitle => 'Jak zbierane są dane';

  @override
  String get privacyPolicyCollectionItem1 =>
      'Z aplikacji można korzystać lokalnie, bez łączenia konta.';

  @override
  String get privacyPolicyCollectionItem2 =>
      'Jeśli zdecydujesz się połączyć konto z Google, Muscleup korzysta z Firebase Authentication do logowania.';

  @override
  String get privacyPolicyCollectionItem3 =>
      'Jeśli wybierzesz synchronizację w chmurze, dane są przechowywane w Google Firebase Cloud Firestore i powiązane z Twoim kontem.';

  @override
  String get privacyPolicyUsageTitle => 'Jak wykorzystujemy dane';

  @override
  String get privacyPolicyUsageItem1 =>
      'Aby umożliwić logowanie i zarządzanie kontem.';

  @override
  String get privacyPolicyUsageItem2 =>
      'Aby zapisywać, synchronizować i przywracać Twoje plany oraz historię treningów.';

  @override
  String get privacyPolicyUsageItem3 =>
      'Aby przechowywać Twoje ustawienia i zapewniać podstawowe funkcje aplikacji.';

  @override
  String get privacyPolicySharingTitle => 'Udostępnianie danych';

  @override
  String get privacyPolicySharingBody =>
      'Muscleup nie sprzedaje Twoich danych ani nie udostępnia ich stronom trzecim w celach reklamowych lub marketingowych. Dane mogą być przetwarzane przez dostawców infrastruktury niezbędnych do działania aplikacji, takich jak Firebase Authentication i Cloud Firestore.';

  @override
  String get privacyPolicySecurityTitle => 'Szyfrowanie i bezpieczeństwo';

  @override
  String get privacyPolicySecurityBody =>
      'Dane są przesyłane przez bezpieczne, szyfrowane połączenia. Dostęp do zsynchronizowanych danych ma wyłącznie zalogowany użytkownik, do którego one należą.';

  @override
  String get privacyPolicyRetentionTitle => 'Przechowywanie danych';

  @override
  String get privacyPolicyRetentionBody =>
      'Dane są przechowywane tak długo, jak zachowujesz konto i korzystasz z synchronizacji w chmurze, chyba że poprosisz o ich usunięcie. Niewielka ilość danych technicznych może przez ograniczony czas pozostać w kopiach zapasowych infrastruktury.';

  @override
  String get privacyPolicyDeletionTitle => 'Usunięcie konta i danych';

  @override
  String get privacyPolicyDeletionBody =>
      'W każdej chwili możesz poprosić o usunięcie konta i wszystkich powiązanych danych. Strona usuwania konta zawiera pełne instrukcje, dokładny zakres usuwanych danych i czas realizacji. Potwierdzimy e-mailem, gdy dane zostaną usunięte.';

  @override
  String get privacyPolicyChildrenTitle => 'Prywatność dzieci';

  @override
  String get privacyPolicyChildrenBody =>
      'Muscleup nie jest skierowane w szczególności do dzieci poniżej 13. roku życia.';

  @override
  String get privacyPolicyContactTitle => 'Kontakt';

  @override
  String get privacyPolicyContactBody =>
      'Jeśli masz pytania dotyczące tej polityki, napisz do nas:';

  @override
  String get privacyPolicyOpenOnline => 'Zobacz wersję online';

  @override
  String get privacyPolicyAccountDeletionPage => 'Otwórz stronę usuwania konta';

  @override
  String get privacyPolicyAccountDeletion => 'Poproś o usunięcie e-mailem';

  @override
  String get accountDeletionEmailSubject =>
      'Muscleup — Prośba o usunięcie konta';

  @override
  String get accountDeletionEmailBody =>
      'Chciałbym poprosić o usunięcie mojego konta Muscleup i wszystkich powiązanych danych.';

  @override
  String get couldNotOpenLink =>
      'Nie udało się otworzyć linku na tym urządzeniu.';

  @override
  String get exitAppTitle => 'Zamknąć Muscleup?';

  @override
  String get exitAppMessage => 'Na pewno zamknąć aplikację?';

  @override
  String get exitAppConfirm => 'Zamknij';
}
