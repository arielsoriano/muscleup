// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Muscleup';

  @override
  String get workouts => 'Latihan';

  @override
  String get exercises => 'Gerakan';

  @override
  String get history => 'Riwayat';

  @override
  String get settings => 'Pengaturan';

  @override
  String get routines => 'Program';

  @override
  String get sets => 'Set';

  @override
  String get weight => 'Beban';

  @override
  String get reps => 'Rep';

  @override
  String get addRoutine => 'Tambah program';

  @override
  String get addExercise => 'Tambah gerakan';

  @override
  String get save => 'Simpan';

  @override
  String get cancel => 'Batal';

  @override
  String get back => 'Kembali';

  @override
  String get routineDetailsTitle => 'Detail program';

  @override
  String get noRoutines => 'Program tidak ditemukan';

  @override
  String get errorLoading => 'Gagal memuat program';

  @override
  String get retry => 'Coba lagi';

  @override
  String get dashboardTitle => 'Ringkasan';

  @override
  String get today => 'Hari ini';

  @override
  String get noWorkoutToday => 'Tidak ada latihan yang tercatat pada hari ini';

  @override
  String get startWorkout => 'Mulai sebuah program';

  @override
  String get finishWorkout => 'Selesaikan latihan';

  @override
  String get workoutSavedSuccess => 'Latihan berhasil disimpan!';

  @override
  String get finishWorkoutConfirmation =>
      'Yakin ingin menyelesaikan dan menyimpan latihan ini?';

  @override
  String get activeWorkoutTitle => 'Latihan berjalan';

  @override
  String get set => 'Set';

  @override
  String get target => 'Target';

  @override
  String get actual => 'Hasil';

  @override
  String get routineName => 'Nama program';

  @override
  String get exerciseName => 'Nama gerakan';

  @override
  String get notes => 'Catatan';

  @override
  String get exerciseNotesLabel => 'Catatan (opsional)';

  @override
  String get exerciseNotesHint => 'mis. eliptikal atau sepeda';

  @override
  String get removeExercise => 'Hapus gerakan';

  @override
  String get addSet => 'Tambah set';

  @override
  String get saveRoutineSuccess => 'Program berhasil disimpan!';

  @override
  String get editRoutine => 'Ubah program';

  @override
  String get routineNameHint => 'mis. hari kaki, Senin';

  @override
  String get searchExercises => 'Cari gerakan...';

  @override
  String get noResults => 'Gerakan tidak ditemukan';

  @override
  String get noExercisesAdded => 'Belum ada gerakan ditambahkan';

  @override
  String addCustomExercise(String name) {
    return 'Tambah \'$name\'';
  }

  @override
  String get searchHelper => 'Ketik untuk mencari atau menambah...';

  @override
  String get noSetsAdded => 'Belum ada set ditambahkan';

  @override
  String get restTimeSeconds => 'Istirahat (detik)';

  @override
  String removeConfirmation(String name) {
    return 'Yakin ingin menghapus $name?';
  }

  @override
  String get remove => 'Hapus';

  @override
  String get unitKg => 'kg';

  @override
  String get unitLb => 'lb';

  @override
  String get unitReps => 'rep';

  @override
  String get unitSeconds => 'dtk';

  @override
  String get unitMinutes => 'mnt';

  @override
  String get unitKm => 'km';

  @override
  String get unitMeters => 'm';

  @override
  String get unitNone => 'tidak ada';

  @override
  String get unitLevel => 'level';

  @override
  String get unitIncline => 'kemiringan';

  @override
  String setsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count set',
    );
    return '$_temp0';
  }

  @override
  String get language => 'Bahasa';

  @override
  String get appSkin => 'Tema aplikasi';

  @override
  String get skinVolt => 'Volt';

  @override
  String get skinCyan => 'Sian';

  @override
  String get skinCrimson => 'Merah tua';

  @override
  String get skinRoyalGold => 'Emas Kerajaan';

  @override
  String get skinMonochrome => 'Monokrom';

  @override
  String get selectSkin => 'Pilih tema aplikasi';

  @override
  String get noExercisesInRoutine => 'Tidak ada gerakan di program ini';

  @override
  String get deleteRoutineConfirm => 'Yakin ingin menghapus program ini?';

  @override
  String get delete => 'Hapus';

  @override
  String get routineDeletedSuccess => 'Program berhasil dihapus!';

  @override
  String get emptyRoutine => 'Kosong';

  @override
  String get startNewSession => 'Mulai sesi baru';

  @override
  String startRoutineName(String name) {
    return 'Mulai $name';
  }

  @override
  String get addExercisesFirst => 'Tambahkan gerakan dulu';

  @override
  String get deleteSessionConfirm => 'Yakin ingin menghapus sesi latihan ini?';

  @override
  String get sessionDeleted => 'Sesi dihapus';

  @override
  String get resting => 'Istirahat';

  @override
  String get add30Seconds => '+30 dtk';

  @override
  String get resumeWorkout => 'Lanjutkan latihan yang berjalan';

  @override
  String routineAlreadyActive(String name) {
    return '$name sedang berjalan. Dilanjutkan.';
  }

  @override
  String get noLogsFound => 'Tidak ada catatan untuk sesi ini';

  @override
  String get activeWorkout => 'Latihan berjalan';

  @override
  String get inProgress => 'Sedang berjalan...';

  @override
  String get completed => 'Selesai';

  @override
  String get pendingExercises => 'Belum selesai';

  @override
  String get completedExercises => 'Selesai';

  @override
  String get showCompletedExercises => 'Tampilkan';

  @override
  String get hideCompletedExercises => 'Sembunyikan';

  @override
  String get completedSession => 'Sesi selesai';

  @override
  String get saveAsRoutineTarget => 'Simpan sebagai target program';

  @override
  String get saveAsRoutineTargetSuccess =>
      'Target diperbarui untuk latihan berikutnya';

  @override
  String get saveAsRoutineTargetError =>
      'Target program tidak dapat diperbarui';

  @override
  String get editSetValue => 'Ubah nilai';

  @override
  String get saveForToday => 'Simpan untuk hari ini';

  @override
  String get saveForTodayDetail => 'Hanya mencatat nilai untuk latihan ini';

  @override
  String get updateRoutineTarget => 'Perbarui target';

  @override
  String get updateRoutineTargetDetail =>
      'Mengubah target untuk latihan berikutnya';

  @override
  String get errorEmptyName => 'Nama program tidak boleh kosong';

  @override
  String get noRoutinesAvailable => 'Tidak ada program tersedia';

  @override
  String get createRoutineToGetStarted => 'Buat program untuk memulai';

  @override
  String get errorNoExercises =>
      'Program harus memiliki setidaknya satu gerakan';

  @override
  String get errorEmptySets =>
      'Setiap gerakan harus memiliki setidaknya satu set';

  @override
  String get noSetsDefined => 'Belum ada set yang ditentukan';

  @override
  String get authAccount => 'Akun';

  @override
  String get authAnonymous => 'Anonim';

  @override
  String get authAnonymousSubtitle =>
      'Datamu tersimpan di perangkat ini. Tautkan akun untuk menyinkronkannya.';

  @override
  String get authLinkedWithGoogle => 'Tertaut dengan Google';

  @override
  String get authContinueWithGoogle => 'Lanjutkan dengan Google';

  @override
  String get authDisconnectGoogle => 'Putuskan tautan Google';

  @override
  String get authLinkSuccess => 'Akun berhasil ditautkan!';

  @override
  String get authGoogleSignInConfigurationError =>
      'Login Google belum dikonfigurasi untuk build rilis ini. Tambahkan sidik jari SHA rilis dan Play App Signing di Firebase.';

  @override
  String get authGoogleSignInTimeout =>
      'Login Google terlalu lama. Silakan coba lagi.';

  @override
  String get authUnavailable => 'Autentikasi cloud tidak tersedia';

  @override
  String get appInfoSection => 'APLIKASI';

  @override
  String get appVersionLabel => 'Versi';

  @override
  String get appBuildLabel => 'Build';

  @override
  String get darkMode => 'Mode gelap';

  @override
  String get trainingDefaultsSection => 'NILAI LATIHAN BAWAAN';

  @override
  String get defaultRest => 'Istirahat bawaan';

  @override
  String get defaultRepetitions => 'Repetisi bawaan';

  @override
  String get defaultWeight => 'Beban bawaan';

  @override
  String get autoStartRestTimerOnComplete => 'Mulai istirahat saat set selesai';

  @override
  String get autoStartRestTimerOnCompleteSubtitle =>
      'Saat kamu menandai satu set selesai, penghitung waktu mulai sendiri';

  @override
  String get restSecondsDialogTitle => 'Istirahat (detik)';

  @override
  String get repetitionsDialogTitle => 'Repetisi';

  @override
  String get weightKgDialogTitle => 'Beban (kg)';

  @override
  String get globalManagementSection => 'PENGELOLAAN UMUM';

  @override
  String get manageExercises => 'Kelola gerakan';

  @override
  String get manageExercisesSubtitle =>
      'Buat, ubah, dan hapus gerakan dari satu tempat';

  @override
  String get exerciseLibraryTitle => 'Pustaka gerakan';

  @override
  String get newLabel => 'Baru';

  @override
  String get newExerciseTitle => 'Gerakan baru';

  @override
  String get editExerciseTitle => 'Ubah gerakan';

  @override
  String get deleteExerciseTitle => 'Hapus gerakan';

  @override
  String deleteExerciseConfirm(String name) {
    return 'Yakin ingin menghapus $name?';
  }

  @override
  String get changesSaved => 'Perubahan disimpan';

  @override
  String get exerciseNameHint => 'Nama gerakan';

  @override
  String get noExercisesToShow => 'Tidak ada gerakan untuk ditampilkan';

  @override
  String get customLabel => 'Kustom';

  @override
  String get libraryLabel => 'Pustaka';

  @override
  String get syncCloudSection => 'SINKRONISASI CLOUD';

  @override
  String get neverSynced => 'Belum pernah disinkronkan';

  @override
  String get syncing => 'Menyinkronkan...';

  @override
  String get globalSyncOverlayTitle => 'Menyinkronkan datamu';

  @override
  String get globalSyncOverlaySubtitle =>
      'Menyiapkan program dan riwayat dari cloud...';

  @override
  String get routinesSyncingPlaceholder => 'Mengambil programmu dari cloud...';

  @override
  String get syncPending => 'Menunggu sinkronisasi';

  @override
  String get synced => 'Sudah dicadangkan';

  @override
  String get syncLocked => 'Pencadangan mati';

  @override
  String lastSync(String date) {
    return 'Sinkronisasi terakhir: $date';
  }

  @override
  String get linkGoogleForSync =>
      'Tautkan akun Google-mu untuk mengaktifkan sinkronisasi cloud';

  @override
  String get refreshNow => 'Segarkan sekarang';

  @override
  String lastTimeValue(String value) {
    return 'Terakhir kali: $value';
  }

  @override
  String get exerciseProgressTitle => 'Perkembangan';

  @override
  String get viewProgress => 'Lihat perkembangan';

  @override
  String get noProgressYet =>
      'Belum ada catatan. Selesaikan satu latihan dengan gerakan ini untuk melihat perkembanganmu di sini.';

  @override
  String progressSessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sesi',
    );
    return '$_temp0';
  }

  @override
  String get helpFeedbackSection => 'Bantuan dan masukan';

  @override
  String get sendFeedback => 'Kirim masukan';

  @override
  String get sendFeedbackSubtitle => 'Saran, ide, atau laporkan masalah';

  @override
  String get feedbackEmailSubject => 'Muscleup — Masukan';

  @override
  String get feedbackEmailBody => 'Tulis masukan, ide, atau masalahmu di sini:';

  @override
  String get emailCopiedToClipboard =>
      'Aplikasi email tidak dapat dibuka. Alamatnya sudah disalin ke papan klip.';

  @override
  String get legalSection => 'Hukum';

  @override
  String get privacyPolicy => 'Kebijakan privasi';

  @override
  String get privacyPolicySubtitle => 'Bagaimana Muscleup menangani datamu';

  @override
  String privacyPolicyLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Terakhir diperbarui: $dateString';
  }

  @override
  String get privacyPolicyIntro =>
      'Muscleup adalah aplikasi pencatat latihan. Kebijakan ini menjelaskan data apa saja yang dapat dikumpulkan aplikasi, bagaimana data itu digunakan, dan pilihan apa yang kamu miliki atas data tersebut.';

  @override
  String get privacyPolicyDataTitle => 'Data yang kami kumpulkan';

  @override
  String get privacyPolicyDataItem1 =>
      'Informasi akun seperti nama, alamat email, dan ID pengguna.';

  @override
  String get privacyPolicyDataItem2 =>
      'Data latihan seperti program, gerakan, set, beban, repetisi, sesi, riwayat, dan catatan opsional yang kamu masukkan di aplikasi.';

  @override
  String get privacyPolicyDataItem3 =>
      'Pengaturan aplikasi seperti bahasa, tema, dan preferensi terkait latihan.';

  @override
  String get privacyPolicyCollectionTitle => 'Bagaimana data dikumpulkan';

  @override
  String get privacyPolicyCollectionItem1 =>
      'Aplikasi dapat digunakan secara lokal tanpa menautkan akun.';

  @override
  String get privacyPolicyCollectionItem2 =>
      'Jika kamu memilih menautkan akun dengan Google, Muscleup menggunakan Firebase Authentication untuk login.';

  @override
  String get privacyPolicyCollectionItem3 =>
      'Jika kamu memilih sinkronisasi cloud, data disimpan di Google Firebase Cloud Firestore dan dikaitkan dengan akunmu.';

  @override
  String get privacyPolicyUsageTitle => 'Bagaimana kami menggunakan data';

  @override
  String get privacyPolicyUsageItem1 =>
      'Untuk memungkinkan login dan pengelolaan akun.';

  @override
  String get privacyPolicyUsageItem2 =>
      'Untuk menyimpan, menyinkronkan, dan memulihkan program serta riwayat latihanmu.';

  @override
  String get privacyPolicyUsageItem3 =>
      'Untuk menyimpan preferensimu dan menyediakan fungsi utama aplikasi.';

  @override
  String get privacyPolicySharingTitle => 'Pembagian data';

  @override
  String get privacyPolicySharingBody =>
      'Muscleup tidak menjual datamu dan tidak membagikannya kepada pihak ketiga untuk tujuan iklan atau pemasaran. Data dapat diproses oleh penyedia infrastruktur yang diperlukan untuk menjalankan aplikasi, seperti Firebase Authentication dan Cloud Firestore.';

  @override
  String get privacyPolicySecurityTitle => 'Enkripsi dan keamanan';

  @override
  String get privacyPolicySecurityBody =>
      'Data dikirim melalui koneksi aman yang terenkripsi. Akses ke data yang disinkronkan hanya untuk pengguna terautentikasi yang memilikinya.';

  @override
  String get privacyPolicyRetentionTitle => 'Penyimpanan data';

  @override
  String get privacyPolicyRetentionBody =>
      'Data disimpan selama kamu mempertahankan akun dan menggunakan sinkronisasi cloud, kecuali kamu meminta penghapusan. Sebagian kecil data teknis mungkin tetap ada sementara di cadangan infrastruktur untuk jangka waktu terbatas.';

  @override
  String get privacyPolicyDeletionTitle => 'Penghapusan akun dan data';

  @override
  String get privacyPolicyDeletionBody =>
      'Kamu dapat meminta penghapusan akun dan seluruh data terkait kapan saja. Halaman penghapusan akun memuat panduan lengkap, apa saja yang dihapus, dan berapa lama prosesnya. Kami mengonfirmasi lewat email setelah datamu dihapus.';

  @override
  String get privacyPolicyChildrenTitle => 'Privasi anak';

  @override
  String get privacyPolicyChildrenBody =>
      'Muscleup tidak ditujukan secara khusus untuk anak di bawah 13 tahun.';

  @override
  String get privacyPolicyContactTitle => 'Kontak';

  @override
  String get privacyPolicyContactBody =>
      'Jika kamu punya pertanyaan tentang kebijakan ini, tulis kepada kami di:';

  @override
  String get privacyPolicyOpenOnline => 'Lihat versi online';

  @override
  String get privacyPolicyAccountDeletionPage =>
      'Buka halaman penghapusan akun';

  @override
  String get privacyPolicyAccountDeletion => 'Minta penghapusan lewat email';

  @override
  String get accountDeletionEmailSubject =>
      'Muscleup — Permintaan penghapusan akun';

  @override
  String get accountDeletionEmailBody =>
      'Saya ingin meminta penghapusan akun Muscleup saya beserta seluruh data terkait.';

  @override
  String get couldNotOpenLink => 'Tautan tidak dapat dibuka di perangkat ini.';

  @override
  String get exitAppTitle => 'Keluar dari Muscleup?';

  @override
  String get exitAppMessage => 'Yakin ingin menutup aplikasi?';

  @override
  String get exitAppConfirm => 'Keluar';

  @override
  String get importTitle => 'Impor rutinitas';

  @override
  String get importHeadline => 'Bawa seluruh programmu dalam satu langkah';

  @override
  String get importIntro =>
      'Tempelkan program latihanmu dan Muscleup akan membuat semua rutinitas beserta latihan, set, beban, repetisi, dan catatannya. Asisten AI mana pun bisa mengubah catatanmu ke format yang dibutuhkan aplikasi.';

  @override
  String get importStep1 => 'Salin instruksinya.';

  @override
  String get importStep2 =>
      'Tempelkan ke chat AI — ChatGPT, Claude, Gemini — lalu ikuti dengan catatan latihanmu, apa adanya.';

  @override
  String get importStep3 =>
      'Salin jawabannya, tempelkan di bawah, dan periksa sebelum mengimpor.';

  @override
  String get importCopyInstructions => 'Salin instruksi';

  @override
  String get importInstructionsCopied =>
      'Instruksi disalin. Tempelkan ke chat AI bersama catatanmu.';

  @override
  String importInstructionsLanguageNote(String language) {
    return 'Instruksinya dalam bahasa Inggris karena asisten mengikutinya paling akurat begitu. Rutinitasmu akan kembali dalam $language.';
  }

  @override
  String get importPasteLabel => 'Jawaban asisten';

  @override
  String get importPasteHint => 'Tempelkan JSON di sini';

  @override
  String get importPasteFromClipboard => 'Tempel';

  @override
  String get importClipboardEmpty => 'Tidak ada yang bisa ditempel.';

  @override
  String get importCheck => 'Periksa';

  @override
  String get importClear => 'Bersihkan';

  @override
  String get importAction => 'Impor';

  @override
  String get importPreviewTitle => 'Ini yang akan dibuat';

  @override
  String importRoutineSummary(int exerciseCount, int setCount) {
    return 'Latihan: $exerciseCount · Set: $setCount';
  }

  @override
  String get importNoticesTitle => 'Perlu diperiksa';

  @override
  String get importSuccess => 'Rutinitas diimpor';

  @override
  String get importErrorEmptyInput =>
      'Tempelkan jawaban asisten terlebih dahulu.';

  @override
  String get importErrorInvalidJson =>
      'Teks itu bukan JSON yang valid. Salin lagi jawabannya termasuk tanda kurung kurawal, atau minta asisten menjawab hanya dengan JSON.';

  @override
  String get importErrorNoRoutines =>
      'Tidak ada rutinitas yang ditemukan pada teks itu. Dibutuhkan daftar “routines” dengan setidaknya satu hari yang berisi latihan.';

  @override
  String importNoticeNoExercises(String name) {
    return '“$name” dilewati: tidak ada latihan.';
  }

  @override
  String importNoticeSkippedRoutines(int count) {
    return 'Entri dilewati karena tidak punya nama: $count.';
  }

  @override
  String importNoticeSkippedExercises(String name, int count) {
    return 'Latihan di “$name” dilewati karena tidak punya nama: $count.';
  }

  @override
  String importNoticeDuplicateName(String name) {
    return 'Kamu sudah punya rutinitas bernama “$name”. Yang ini tetap ditambahkan.';
  }

  @override
  String get importSettingsSubtitle =>
      'Tempel satu program dan buat semua rutinitas sekaligus';
}
