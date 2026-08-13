// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Muscleup';

  @override
  String get workouts => 'Buổi tập';

  @override
  String get exercises => 'Bài tập';

  @override
  String get history => 'Lịch sử';

  @override
  String get settings => 'Cài đặt';

  @override
  String get routines => 'Giáo án';

  @override
  String get sets => 'Hiệp';

  @override
  String get weight => 'Mức tạ';

  @override
  String get reps => 'Lần';

  @override
  String get addRoutine => 'Thêm giáo án';

  @override
  String get addExercise => 'Thêm bài tập';

  @override
  String get save => 'Lưu';

  @override
  String get cancel => 'Huỷ';

  @override
  String get back => 'Quay lại';

  @override
  String get routineDetailsTitle => 'Chi tiết giáo án';

  @override
  String get noRoutines => 'Không tìm thấy giáo án nào';

  @override
  String get errorLoading => 'Không tải được giáo án';

  @override
  String get retry => 'Thử lại';

  @override
  String get dashboardTitle => 'Tổng quan';

  @override
  String get today => 'Hôm nay';

  @override
  String get noWorkoutToday => 'Chưa ghi nhận buổi tập nào trong ngày này';

  @override
  String get startWorkout => 'Bắt đầu một giáo án';

  @override
  String get finishWorkout => 'Kết thúc buổi tập';

  @override
  String get workoutSavedSuccess => 'Đã lưu buổi tập!';

  @override
  String get finishWorkoutConfirmation =>
      'Bạn có chắc muốn kết thúc và lưu buổi tập này không?';

  @override
  String get activeWorkoutTitle => 'Buổi tập đang diễn ra';

  @override
  String get set => 'Hiệp';

  @override
  String get target => 'Mục tiêu';

  @override
  String get actual => 'Thực tế';

  @override
  String get routineName => 'Tên giáo án';

  @override
  String get exerciseName => 'Tên bài tập';

  @override
  String get notes => 'Ghi chú';

  @override
  String get exerciseNotesLabel => 'Ghi chú (không bắt buộc)';

  @override
  String get exerciseNotesHint => 'vd. máy elliptical hoặc xe đạp';

  @override
  String get removeExercise => 'Bỏ bài tập';

  @override
  String get addSet => 'Thêm hiệp';

  @override
  String get saveRoutineSuccess => 'Đã lưu giáo án!';

  @override
  String get editRoutine => 'Sửa giáo án';

  @override
  String get routineNameHint => 'vd. ngày tập chân, thứ Hai';

  @override
  String get searchExercises => 'Tìm bài tập...';

  @override
  String get noResults => 'Không tìm thấy bài tập nào';

  @override
  String get noExercisesAdded => 'Chưa thêm bài tập nào';

  @override
  String addCustomExercise(String name) {
    return 'Thêm \'$name\'';
  }

  @override
  String get searchHelper => 'Nhập để tìm hoặc thêm...';

  @override
  String get noSetsAdded => 'Chưa thêm hiệp nào';

  @override
  String get restTimeSeconds => 'Nghỉ (giây)';

  @override
  String removeConfirmation(String name) {
    return 'Bạn có chắc muốn bỏ $name không?';
  }

  @override
  String get remove => 'Bỏ';

  @override
  String get unitKg => 'kg';

  @override
  String get unitLb => 'lb';

  @override
  String get unitReps => 'lần';

  @override
  String get unitSeconds => 'giây';

  @override
  String get unitMinutes => 'phút';

  @override
  String get unitKm => 'km';

  @override
  String get unitMeters => 'm';

  @override
  String get unitNone => 'không';

  @override
  String get unitLevel => 'mức';

  @override
  String get unitIncline => 'độ dốc';

  @override
  String setsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hiệp',
    );
    return '$_temp0';
  }

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get appSkin => 'Giao diện ứng dụng';

  @override
  String get skinVolt => 'Volt';

  @override
  String get skinCyan => 'Xanh lơ';

  @override
  String get skinCrimson => 'Đỏ thẫm';

  @override
  String get skinRoyalGold => 'Vàng hoàng gia';

  @override
  String get skinMonochrome => 'Đơn sắc';

  @override
  String get selectSkin => 'Chọn giao diện ứng dụng';

  @override
  String get noExercisesInRoutine => 'Giáo án này chưa có bài tập nào';

  @override
  String get deleteRoutineConfirm => 'Bạn có chắc muốn xoá giáo án này không?';

  @override
  String get delete => 'Xoá';

  @override
  String get routineDeletedSuccess => 'Đã xoá giáo án!';

  @override
  String get emptyRoutine => 'Trống';

  @override
  String get startNewSession => 'Bắt đầu buổi tập mới';

  @override
  String startRoutineName(String name) {
    return 'Bắt đầu $name';
  }

  @override
  String get addExercisesFirst => 'Hãy thêm bài tập trước';

  @override
  String get deleteSessionConfirm => 'Bạn có chắc muốn xoá buổi tập này không?';

  @override
  String get sessionDeleted => 'Đã xoá buổi tập';

  @override
  String get resting => 'Đang nghỉ';

  @override
  String get add30Seconds => '+30 giây';

  @override
  String get resumeWorkout => 'Tiếp tục buổi tập hiện tại';

  @override
  String routineAlreadyActive(String name) {
    return '$name đang diễn ra. Tiếp tục buổi tập.';
  }

  @override
  String get noLogsFound => 'Không có dữ liệu nào cho buổi tập này';

  @override
  String get activeWorkout => 'Buổi tập đang diễn ra';

  @override
  String get inProgress => 'Đang diễn ra...';

  @override
  String get completed => 'Đã xong';

  @override
  String get pendingExercises => 'Còn lại';

  @override
  String get completedExercises => 'Đã xong';

  @override
  String get showCompletedExercises => 'Hiện';

  @override
  String get hideCompletedExercises => 'Ẩn';

  @override
  String get completedSession => 'Buổi tập đã hoàn thành';

  @override
  String get saveAsRoutineTarget => 'Lưu làm mục tiêu của giáo án';

  @override
  String get saveAsRoutineTargetSuccess =>
      'Đã cập nhật mục tiêu cho các buổi tập sau';

  @override
  String get saveAsRoutineTargetError =>
      'Không cập nhật được mục tiêu của giáo án';

  @override
  String get editSetValue => 'Sửa giá trị';

  @override
  String get saveForToday => 'Lưu cho hôm nay';

  @override
  String get saveForTodayDetail => 'Chỉ ghi giá trị cho buổi tập này';

  @override
  String get updateRoutineTarget => 'Cập nhật mục tiêu';

  @override
  String get updateRoutineTargetDetail =>
      'Thay đổi mục tiêu cho các buổi tập sau';

  @override
  String get errorEmptyName => 'Tên giáo án không được để trống';

  @override
  String get noRoutinesAvailable => 'Chưa có giáo án nào';

  @override
  String get createRoutineToGetStarted => 'Tạo một giáo án để bắt đầu';

  @override
  String get errorNoExercises => 'Giáo án phải có ít nhất một bài tập';

  @override
  String get errorEmptySets => 'Mỗi bài tập phải có ít nhất một hiệp';

  @override
  String get noSetsDefined => 'Chưa thiết lập hiệp nào';

  @override
  String get authAccount => 'Tài khoản';

  @override
  String get authAnonymous => 'Ẩn danh';

  @override
  String get authAnonymousSubtitle =>
      'Dữ liệu của bạn chỉ lưu trên máy này. Hãy liên kết tài khoản để đồng bộ.';

  @override
  String get authLinkedWithGoogle => 'Đã liên kết với Google';

  @override
  String get authContinueWithGoogle => 'Tiếp tục với Google';

  @override
  String get authDisconnectGoogle => 'Ngắt liên kết Google';

  @override
  String get authLinkSuccess => 'Đã liên kết tài khoản!';

  @override
  String get authGoogleSignInConfigurationError =>
      'Đăng nhập Google chưa được cấu hình cho bản phát hành này. Hãy thêm dấu vân tay SHA của bản release và Play App Signing vào Firebase.';

  @override
  String get authGoogleSignInTimeout =>
      'Đăng nhập Google mất quá nhiều thời gian. Vui lòng thử lại.';

  @override
  String get authUnavailable => 'Không dùng được xác thực đám mây';

  @override
  String get appInfoSection => 'ỨNG DỤNG';

  @override
  String get appVersionLabel => 'Phiên bản';

  @override
  String get appBuildLabel => 'Bản dựng';

  @override
  String get darkMode => 'Chế độ tối';

  @override
  String get trainingDefaultsSection => 'GIÁ TRỊ TẬP LUYỆN MẶC ĐỊNH';

  @override
  String get defaultRest => 'Thời gian nghỉ mặc định';

  @override
  String get defaultRepetitions => 'Số lần mặc định';

  @override
  String get defaultWeight => 'Mức tạ mặc định';

  @override
  String get autoStartRestTimerOnComplete => 'Tự đếm giờ nghỉ khi xong hiệp';

  @override
  String get autoStartRestTimerOnCompleteSubtitle =>
      'Khi bạn đánh dấu một hiệp đã xong, đồng hồ sẽ tự chạy';

  @override
  String get restSecondsDialogTitle => 'Nghỉ (giây)';

  @override
  String get repetitionsDialogTitle => 'Số lần lặp';

  @override
  String get weightKgDialogTitle => 'Mức tạ (kg)';

  @override
  String get globalManagementSection => 'QUẢN LÝ CHUNG';

  @override
  String get manageExercises => 'Quản lý bài tập';

  @override
  String get manageExercisesSubtitle =>
      'Tạo, sửa và xoá bài tập ở cùng một nơi';

  @override
  String get exerciseLibraryTitle => 'Thư viện bài tập';

  @override
  String get newLabel => 'Mới';

  @override
  String get newExerciseTitle => 'Bài tập mới';

  @override
  String get editExerciseTitle => 'Sửa bài tập';

  @override
  String get deleteExerciseTitle => 'Xoá bài tập';

  @override
  String deleteExerciseConfirm(String name) {
    return 'Bạn có chắc muốn xoá $name không?';
  }

  @override
  String get changesSaved => 'Đã lưu thay đổi';

  @override
  String get exerciseNameHint => 'Tên bài tập';

  @override
  String get noExercisesToShow => 'Không có bài tập nào để hiện';

  @override
  String get customLabel => 'Tự tạo';

  @override
  String get libraryLabel => 'Thư viện';

  @override
  String get syncCloudSection => 'ĐỒNG BỘ ĐÁM MÂY';

  @override
  String get neverSynced => 'Chưa từng đồng bộ';

  @override
  String get syncing => 'Đang đồng bộ...';

  @override
  String get globalSyncOverlayTitle => 'Đang đồng bộ dữ liệu của bạn';

  @override
  String get globalSyncOverlaySubtitle =>
      'Đang tải giáo án và lịch sử từ đám mây...';

  @override
  String get routinesSyncingPlaceholder =>
      'Đang tải giáo án của bạn từ đám mây...';

  @override
  String get syncPending => 'Chờ đồng bộ';

  @override
  String get synced => 'Đã sao lưu';

  @override
  String get syncLocked => 'Sao lưu đang tắt';

  @override
  String lastSync(String date) {
    return 'Đồng bộ lần cuối: $date';
  }

  @override
  String get linkGoogleForSync =>
      'Liên kết tài khoản Google để bật đồng bộ đám mây';

  @override
  String get refreshNow => 'Làm mới ngay';

  @override
  String lastTimeValue(String value) {
    return 'Lần trước: $value';
  }

  @override
  String get exerciseProgressTitle => 'Tiến bộ';

  @override
  String get viewProgress => 'Xem tiến bộ';

  @override
  String get noProgressYet =>
      'Chưa có dữ liệu. Hãy hoàn thành một buổi tập với bài này để xem tiến bộ của bạn ở đây.';

  @override
  String progressSessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count buổi tập',
    );
    return '$_temp0';
  }

  @override
  String get helpFeedbackSection => 'Trợ giúp và góp ý';

  @override
  String get sendFeedback => 'Gửi góp ý';

  @override
  String get sendFeedbackSubtitle => 'Đề xuất, ý tưởng hoặc báo lỗi';

  @override
  String get feedbackEmailSubject => 'Muscleup — Góp ý';

  @override
  String get feedbackEmailBody =>
      'Hãy viết góp ý, ý tưởng hoặc vấn đề của bạn ở đây:';

  @override
  String get emailCopiedToClipboard =>
      'Không mở được ứng dụng email. Địa chỉ đã được sao chép vào bộ nhớ tạm.';

  @override
  String get legalSection => 'Pháp lý';

  @override
  String get privacyPolicy => 'Chính sách quyền riêng tư';

  @override
  String get privacyPolicySubtitle =>
      'Muscleup xử lý dữ liệu của bạn như thế nào';

  @override
  String privacyPolicyLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Cập nhật lần cuối: $dateString';
  }

  @override
  String get privacyPolicyIntro =>
      'Muscleup là ứng dụng ghi lại quá trình tập luyện. Chính sách này giải thích ứng dụng có thể thu thập những dữ liệu nào, dữ liệu đó được dùng ra sao và bạn có những lựa chọn gì đối với dữ liệu của mình.';

  @override
  String get privacyPolicyDataTitle => 'Dữ liệu chúng tôi thu thập';

  @override
  String get privacyPolicyDataItem1 =>
      'Thông tin tài khoản như tên, địa chỉ email và mã người dùng.';

  @override
  String get privacyPolicyDataItem2 =>
      'Dữ liệu tập luyện như giáo án, bài tập, hiệp, mức tạ, số lần lặp, buổi tập, lịch sử và các ghi chú tuỳ chọn bạn nhập trong ứng dụng.';

  @override
  String get privacyPolicyDataItem3 =>
      'Cài đặt ứng dụng như ngôn ngữ, giao diện và các tuỳ chọn liên quan đến tập luyện.';

  @override
  String get privacyPolicyCollectionTitle =>
      'Dữ liệu được thu thập như thế nào';

  @override
  String get privacyPolicyCollectionItem1 =>
      'Bạn có thể dùng ứng dụng ngay trên máy mà không cần liên kết tài khoản.';

  @override
  String get privacyPolicyCollectionItem2 =>
      'Nếu bạn chọn liên kết tài khoản với Google, Muscleup dùng Firebase Authentication để đăng nhập.';

  @override
  String get privacyPolicyCollectionItem3 =>
      'Nếu bạn chọn đồng bộ đám mây, dữ liệu được lưu trên Google Firebase Cloud Firestore và gắn với tài khoản của bạn.';

  @override
  String get privacyPolicyUsageTitle => 'Chúng tôi dùng dữ liệu ra sao';

  @override
  String get privacyPolicyUsageItem1 =>
      'Để cho phép đăng nhập và quản lý tài khoản.';

  @override
  String get privacyPolicyUsageItem2 =>
      'Để lưu, đồng bộ và khôi phục giáo án cùng lịch sử tập luyện của bạn.';

  @override
  String get privacyPolicyUsageItem3 =>
      'Để giữ các tuỳ chọn của bạn và cung cấp những chức năng chính của ứng dụng.';

  @override
  String get privacyPolicySharingTitle => 'Chia sẻ dữ liệu';

  @override
  String get privacyPolicySharingBody =>
      'Muscleup không bán dữ liệu của bạn và không chia sẻ dữ liệu với bên thứ ba cho mục đích quảng cáo hay tiếp thị. Dữ liệu có thể được xử lý bởi các nhà cung cấp hạ tầng cần thiết để ứng dụng hoạt động, chẳng hạn Firebase Authentication và Cloud Firestore.';

  @override
  String get privacyPolicySecurityTitle => 'Mã hoá và bảo mật';

  @override
  String get privacyPolicySecurityBody =>
      'Dữ liệu được truyền qua các kết nối an toàn và đã mã hoá. Chỉ người dùng đã đăng nhập và sở hữu dữ liệu mới truy cập được dữ liệu đã đồng bộ.';

  @override
  String get privacyPolicyRetentionTitle => 'Thời gian lưu giữ dữ liệu';

  @override
  String get privacyPolicyRetentionBody =>
      'Dữ liệu được giữ trong thời gian bạn còn tài khoản và còn dùng đồng bộ đám mây, trừ khi bạn yêu cầu xoá. Một lượng nhỏ dữ liệu kỹ thuật có thể còn lại tạm thời trong các bản sao lưu hạ tầng trong một khoảng thời gian giới hạn.';

  @override
  String get privacyPolicyDeletionTitle => 'Xoá tài khoản và dữ liệu';

  @override
  String get privacyPolicyDeletionBody =>
      'Bạn có thể yêu cầu xoá tài khoản cùng toàn bộ dữ liệu liên quan bất cứ lúc nào. Trang xoá tài khoản có hướng dẫn đầy đủ, nêu rõ những gì sẽ bị xoá và mất bao lâu. Chúng tôi sẽ xác nhận qua email khi dữ liệu của bạn đã được xoá.';

  @override
  String get privacyPolicyChildrenTitle => 'Quyền riêng tư của trẻ em';

  @override
  String get privacyPolicyChildrenBody =>
      'Muscleup không nhắm riêng đến trẻ em dưới 13 tuổi.';

  @override
  String get privacyPolicyContactTitle => 'Liên hệ';

  @override
  String get privacyPolicyContactBody =>
      'Nếu bạn có thắc mắc về chính sách này, hãy viết cho chúng tôi tại:';

  @override
  String get privacyPolicyOpenOnline => 'Xem bản trực tuyến';

  @override
  String get privacyPolicyAccountDeletionPage => 'Mở trang xoá tài khoản';

  @override
  String get privacyPolicyAccountDeletion => 'Yêu cầu xoá qua email';

  @override
  String get accountDeletionEmailSubject => 'Muscleup — Yêu cầu xoá tài khoản';

  @override
  String get accountDeletionEmailBody =>
      'Tôi muốn yêu cầu xoá tài khoản Muscleup của mình cùng toàn bộ dữ liệu liên quan.';

  @override
  String get couldNotOpenLink => 'Không mở được liên kết trên thiết bị này.';

  @override
  String get exitAppTitle => 'Thoát Muscleup?';

  @override
  String get exitAppMessage => 'Bạn có chắc muốn đóng ứng dụng không?';

  @override
  String get exitAppConfirm => 'Thoát';
}
