// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Muscleup';

  @override
  String get workouts => 'Antrenmanlar';

  @override
  String get exercises => 'Egzersizler';

  @override
  String get history => 'Geçmiş';

  @override
  String get settings => 'Ayarlar';

  @override
  String get routines => 'Programlar';

  @override
  String get sets => 'Setler';

  @override
  String get weight => 'Ağırlık';

  @override
  String get reps => 'Tekrar';

  @override
  String get addRoutine => 'Program ekle';

  @override
  String get addExercise => 'Egzersiz ekle';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'İptal';

  @override
  String get back => 'Geri';

  @override
  String get routineDetailsTitle => 'Program ayrıntıları';

  @override
  String get noRoutines => 'Program bulunamadı';

  @override
  String get errorLoading => 'Programlar yüklenirken hata oluştu';

  @override
  String get retry => 'Yeniden dene';

  @override
  String get dashboardTitle => 'Panel';

  @override
  String get today => 'Bugün';

  @override
  String get noWorkoutToday => 'Bu gün için kayıtlı antrenman yok';

  @override
  String get startWorkout => 'Bir program başlat';

  @override
  String get finishWorkout => 'Antrenmanı bitir';

  @override
  String get workoutSavedSuccess => 'Antrenman kaydedildi!';

  @override
  String get finishWorkoutConfirmation =>
      'Bu antrenmanı bitirip kaydetmek istediğine emin misin?';

  @override
  String get activeWorkoutTitle => 'Devam eden antrenman';

  @override
  String get set => 'Set';

  @override
  String get target => 'Hedef';

  @override
  String get actual => 'Gerçekleşen';

  @override
  String get routineName => 'Program adı';

  @override
  String get exerciseName => 'Egzersiz adı';

  @override
  String get notes => 'Notlar';

  @override
  String get exerciseNotesLabel => 'Notlar (isteğe bağlı)';

  @override
  String get exerciseNotesHint => 'örn. eliptik veya bisiklet';

  @override
  String get removeExercise => 'Egzersizi çıkar';

  @override
  String get addSet => 'Set ekle';

  @override
  String get saveRoutineSuccess => 'Program kaydedildi!';

  @override
  String get editRoutine => 'Programı düzenle';

  @override
  String get routineNameHint => 'örn. bacak günü, pazartesi';

  @override
  String get searchExercises => 'Egzersiz ara...';

  @override
  String get noResults => 'Egzersiz bulunamadı';

  @override
  String get noExercisesAdded => 'Henüz egzersiz eklenmedi';

  @override
  String addCustomExercise(String name) {
    return '\'$name\' ekle';
  }

  @override
  String get searchHelper => 'Aramak veya eklemek için yaz...';

  @override
  String get noSetsAdded => 'Set eklenmedi';

  @override
  String get restTimeSeconds => 'Dinlenme (saniye)';

  @override
  String removeConfirmation(String name) {
    return '$name egzersizini çıkarmak istediğine emin misin?';
  }

  @override
  String get remove => 'Çıkar';

  @override
  String get unitKg => 'kg';

  @override
  String get unitLb => 'lb';

  @override
  String get unitReps => 'tekrar';

  @override
  String get unitSeconds => 'sn';

  @override
  String get unitMinutes => 'dk';

  @override
  String get unitKm => 'km';

  @override
  String get unitMeters => 'm';

  @override
  String get unitNone => 'yok';

  @override
  String get unitLevel => 'seviye';

  @override
  String get unitIncline => 'eğim';

  @override
  String setsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count set',
      one: '1 set',
    );
    return '$_temp0';
  }

  @override
  String get language => 'Dil';

  @override
  String get appSkin => 'Uygulama teması';

  @override
  String get skinVolt => 'Volt';

  @override
  String get skinCyan => 'Camgöbeği';

  @override
  String get skinCrimson => 'Kızıl';

  @override
  String get skinRoyalGold => 'Kraliyet Altını';

  @override
  String get skinMonochrome => 'Tek Renk';

  @override
  String get selectSkin => 'Uygulama temasını seç';

  @override
  String get noExercisesInRoutine => 'Bu programda egzersiz yok';

  @override
  String get deleteRoutineConfirm =>
      'Bu programı silmek istediğine emin misin?';

  @override
  String get delete => 'Sil';

  @override
  String get routineDeletedSuccess => 'Program silindi!';

  @override
  String get emptyRoutine => 'Boş';

  @override
  String get startNewSession => 'Yeni seans başlat';

  @override
  String startRoutineName(String name) {
    return '$name başlat';
  }

  @override
  String get addExercisesFirst => 'Önce egzersiz ekle';

  @override
  String get deleteSessionConfirm =>
      'Bu antrenman seansını silmek istediğine emin misin?';

  @override
  String get sessionDeleted => 'Seans silindi';

  @override
  String get resting => 'Dinlenme';

  @override
  String get add30Seconds => '+30 sn';

  @override
  String get resumeWorkout => 'Devam eden antrenmana dön';

  @override
  String routineAlreadyActive(String name) {
    return '$name zaten devam ediyor. Kaldığın yerden sürdürülüyor.';
  }

  @override
  String get noLogsFound => 'Bu seans için kayıt bulunamadı';

  @override
  String get activeWorkout => 'Devam eden antrenman';

  @override
  String get inProgress => 'Devam ediyor...';

  @override
  String get completed => 'Tamamlandı';

  @override
  String get pendingExercises => 'Bekleyen';

  @override
  String get completedExercises => 'Tamamlanan';

  @override
  String get showCompletedExercises => 'Göster';

  @override
  String get hideCompletedExercises => 'Gizle';

  @override
  String get completedSession => 'Tamamlanan seans';

  @override
  String get saveAsRoutineTarget => 'Program hedefi olarak kaydet';

  @override
  String get saveAsRoutineTargetSuccess =>
      'Sonraki antrenmanlar için hedef güncellendi';

  @override
  String get saveAsRoutineTargetError => 'Program hedefi güncellenemedi';

  @override
  String get editSetValue => 'Değeri düzenle';

  @override
  String get saveForToday => 'Bugün için kaydet';

  @override
  String get saveForTodayDetail => 'Değeri yalnızca bu antrenman için kaydeder';

  @override
  String get updateRoutineTarget => 'Hedefi güncelle';

  @override
  String get updateRoutineTargetDetail =>
      'Sonraki antrenmanların hedefini değiştirir';

  @override
  String get errorEmptyName => 'Program adı boş olamaz';

  @override
  String get noRoutinesAvailable => 'Kullanılabilir program yok';

  @override
  String get createRoutineToGetStarted => 'Başlamak için bir program oluştur';

  @override
  String get errorNoExercises => 'Programda en az bir egzersiz olmalı';

  @override
  String get errorEmptySets => 'Her egzersizde en az bir set olmalı';

  @override
  String get noSetsDefined => 'Tanımlı set yok';

  @override
  String get authAccount => 'Hesap';

  @override
  String get authAnonymous => 'Anonim';

  @override
  String get authAnonymousSubtitle =>
      'Verilerin bu cihazda saklanıyor. Eşitlemek için bir hesap bağla.';

  @override
  String get authLinkedWithGoogle => 'Google ile bağlandı';

  @override
  String get authContinueWithGoogle => 'Google ile devam et';

  @override
  String get authDisconnectGoogle => 'Google bağlantısını kes';

  @override
  String get authLinkSuccess => 'Hesap başarıyla bağlandı!';

  @override
  String get authGoogleSignInConfigurationError =>
      'Google ile oturum açma bu sürüm için yapılandırılmamış. Firebase\'e release ve Play App Signing SHA parmak izlerini ekle.';

  @override
  String get authGoogleSignInTimeout =>
      'Google ile oturum açma çok uzun sürdü. Lütfen tekrar dene.';

  @override
  String get authUnavailable => 'Bulut kimlik doğrulama kullanılamıyor';

  @override
  String get appInfoSection => 'UYGULAMA';

  @override
  String get appVersionLabel => 'Sürüm';

  @override
  String get appBuildLabel => 'Yapı';

  @override
  String get darkMode => 'Koyu tema';

  @override
  String get trainingDefaultsSection => 'VARSAYILAN ANTRENMAN DEĞERLERİ';

  @override
  String get defaultRest => 'Varsayılan dinlenme';

  @override
  String get defaultRepetitions => 'Varsayılan tekrar';

  @override
  String get defaultWeight => 'Varsayılan ağırlık';

  @override
  String get autoStartRestTimerOnComplete =>
      'Set bitince dinlenmeyi otomatik başlat';

  @override
  String get autoStartRestTimerOnCompleteSubtitle =>
      'Bir seti tamamlandı olarak işaretlediğinde sayaç kendiliğinden başlar';

  @override
  String get restSecondsDialogTitle => 'Dinlenme (saniye)';

  @override
  String get repetitionsDialogTitle => 'Tekrar sayısı';

  @override
  String get weightKgDialogTitle => 'Ağırlık (kg)';

  @override
  String get globalManagementSection => 'GENEL YÖNETİM';

  @override
  String get manageExercises => 'Egzersizleri yönet';

  @override
  String get manageExercisesSubtitle =>
      'Egzersizleri tek yerden oluştur, düzenle ve sil';

  @override
  String get exerciseLibraryTitle => 'Egzersiz kütüphanesi';

  @override
  String get newLabel => 'Yeni';

  @override
  String get newExerciseTitle => 'Yeni egzersiz';

  @override
  String get editExerciseTitle => 'Egzersizi düzenle';

  @override
  String get deleteExerciseTitle => 'Egzersizi sil';

  @override
  String deleteExerciseConfirm(String name) {
    return '$name egzersizini silmek istediğine emin misin?';
  }

  @override
  String get changesSaved => 'Değişiklikler kaydedildi';

  @override
  String get exerciseNameHint => 'Egzersiz adı';

  @override
  String get noExercisesToShow => 'Gösterilecek egzersiz yok';

  @override
  String get customLabel => 'Özel';

  @override
  String get libraryLabel => 'Kütüphane';

  @override
  String get syncCloudSection => 'BULUT EŞİTLEME';

  @override
  String get neverSynced => 'Hiç eşitlenmedi';

  @override
  String get syncing => 'Eşitleniyor...';

  @override
  String get globalSyncOverlayTitle => 'Verilerin eşitleniyor';

  @override
  String get globalSyncOverlaySubtitle =>
      'Programlar ve geçmiş buluttan hazırlanıyor...';

  @override
  String get routinesSyncingPlaceholder => 'Programların buluttan alınıyor...';

  @override
  String get syncPending => 'Eşitleme bekliyor';

  @override
  String get synced => 'Yedeklendi';

  @override
  String get syncLocked => 'Yedekleme kapalı';

  @override
  String lastSync(String date) {
    return 'Son eşitleme: $date';
  }

  @override
  String get linkGoogleForSync =>
      'Bulut eşitlemeyi açmak için Google hesabını bağla';

  @override
  String get refreshNow => 'Şimdi yenile';

  @override
  String lastTimeValue(String value) {
    return 'Geçen sefer: $value';
  }

  @override
  String get exerciseProgressTitle => 'İlerleme';

  @override
  String get viewProgress => 'İlerlemeyi gör';

  @override
  String get noProgressYet =>
      'Henüz kayıt yok. İlerlemeni burada görmek için bu egzersizle bir antrenman tamamla.';

  @override
  String progressSessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seans',
      one: '1 seans',
    );
    return '$_temp0';
  }

  @override
  String get helpFeedbackSection => 'Yardım ve geri bildirim';

  @override
  String get sendFeedback => 'Geri bildirim gönder';

  @override
  String get sendFeedbackSubtitle => 'Öneri, fikir veya bir sorunu bildir';

  @override
  String get feedbackEmailSubject => 'Muscleup — Geri bildirim';

  @override
  String get feedbackEmailBody =>
      'Geri bildirimini, fikrini veya sorununu buraya yaz:';

  @override
  String get emailCopiedToClipboard =>
      'E-posta uygulaman açılamadı. Adres panoya kopyalandı.';

  @override
  String get legalSection => 'Yasal';

  @override
  String get privacyPolicy => 'Gizlilik politikası';

  @override
  String get privacyPolicySubtitle => 'Muscleup verilerini nasıl işliyor';

  @override
  String privacyPolicyLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Son güncelleme: $dateString';
  }

  @override
  String get privacyPolicyIntro =>
      'Muscleup bir antrenman takip uygulamasıdır. Bu politika, uygulamanın hangi verileri toplayabileceğini, bu verilerin nasıl kullanıldığını ve bu konuda hangi seçeneklere sahip olduğunu açıklar.';

  @override
  String get privacyPolicyDataTitle => 'Topladığımız veriler';

  @override
  String get privacyPolicyDataItem1 =>
      'Ad, e-posta adresi ve kullanıcı kimliği gibi hesap bilgileri.';

  @override
  String get privacyPolicyDataItem2 =>
      'Programlar, egzersizler, setler, ağırlık, tekrar sayıları, seanslar, geçmiş ve uygulamaya girdiğin isteğe bağlı notlar gibi antrenman verileri.';

  @override
  String get privacyPolicyDataItem3 =>
      'Dil, tema ve antrenmanla ilgili tercihler gibi uygulama ayarları.';

  @override
  String get privacyPolicyCollectionTitle => 'Veriler nasıl toplanıyor';

  @override
  String get privacyPolicyCollectionItem1 =>
      'Uygulama, hesap bağlamadan yerel olarak kullanılabilir.';

  @override
  String get privacyPolicyCollectionItem2 =>
      'Hesabını Google ile bağlamayı seçersen Muscleup, oturum açma için Firebase Authentication kullanır.';

  @override
  String get privacyPolicyCollectionItem3 =>
      'Bulut eşitlemeyi seçersen veriler Google Firebase Cloud Firestore\'da saklanır ve hesabınla ilişkilendirilir.';

  @override
  String get privacyPolicyUsageTitle => 'Verileri nasıl kullanıyoruz';

  @override
  String get privacyPolicyUsageItem1 =>
      'Oturum açmayı ve hesap yönetimini sağlamak için.';

  @override
  String get privacyPolicyUsageItem2 =>
      'Programlarını ve antrenman geçmişini kaydetmek, eşitlemek ve geri yüklemek için.';

  @override
  String get privacyPolicyUsageItem3 =>
      'Tercihlerini saklamak ve uygulamanın temel işlevlerini sunmak için.';

  @override
  String get privacyPolicySharingTitle => 'Veri paylaşımı';

  @override
  String get privacyPolicySharingBody =>
      'Muscleup verilerini satmaz ve reklam veya pazarlama amacıyla üçüncü taraflarla paylaşmaz. Veriler, uygulamanın çalışması için gereken altyapı sağlayıcıları tarafından işlenebilir; örneğin Firebase Authentication ve Cloud Firestore.';

  @override
  String get privacyPolicySecurityTitle => 'Şifreleme ve güvenlik';

  @override
  String get privacyPolicySecurityBody =>
      'Veriler güvenli ve şifreli bağlantılar üzerinden aktarılır. Eşitlenen verilere erişim, yalnızca verilerin sahibi olan kimliği doğrulanmış kullanıcıyla sınırlıdır.';

  @override
  String get privacyPolicyRetentionTitle => 'Verilerin saklanması';

  @override
  String get privacyPolicyRetentionBody =>
      'Silme talebinde bulunmadığın sürece veriler, hesabını koruduğun ve bulut eşitlemeyi kullandığın süre boyunca saklanır. Sınırlı bir süre için altyapı yedeklerinde az miktarda teknik veri geçici olarak kalabilir.';

  @override
  String get privacyPolicyDeletionTitle => 'Hesap ve veri silme';

  @override
  String get privacyPolicyDeletionBody =>
      'Hesabının ve ilişkili tüm verilerin silinmesini istediğin zaman talep edebilirsin. Hesap silme sayfasında tüm adımlar, tam olarak nelerin silindiği ve ne kadar sürdüğü yazılıdır. Verilerin silindiğinde e-posta ile onaylarız.';

  @override
  String get privacyPolicyChildrenTitle => 'Çocukların gizliliği';

  @override
  String get privacyPolicyChildrenBody =>
      'Muscleup özellikle 13 yaş altındaki çocuklara yönelik değildir.';

  @override
  String get privacyPolicyContactTitle => 'İletişim';

  @override
  String get privacyPolicyContactBody =>
      'Bu politikayla ilgili sorun varsa bize şu adresten yaz:';

  @override
  String get privacyPolicyOpenOnline => 'Çevrimiçi sürümü gör';

  @override
  String get privacyPolicyAccountDeletionPage => 'Hesap silme sayfasını aç';

  @override
  String get privacyPolicyAccountDeletion => 'E-posta ile silme talebi gönder';

  @override
  String get accountDeletionEmailSubject => 'Muscleup — Hesap silme talebi';

  @override
  String get accountDeletionEmailBody =>
      'Muscleup hesabımın ve ilişkili tüm verilerin silinmesini talep etmek istiyorum.';

  @override
  String get couldNotOpenLink => 'Bağlantı bu cihazda açılamadı.';

  @override
  String get exitAppTitle => 'Muscleup\'tan çıkılsın mı?';

  @override
  String get exitAppMessage => 'Uygulamayı kapatmak istediğine emin misin?';

  @override
  String get exitAppConfirm => 'Çık';
}
