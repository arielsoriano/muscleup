// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Muscleup';

  @override
  String get workouts => 'वर्कआउट';

  @override
  String get exercises => 'एक्सरसाइज़';

  @override
  String get history => 'हिस्ट्री';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get routines => 'रूटीन';

  @override
  String get sets => 'सेट';

  @override
  String get weight => 'वज़न';

  @override
  String get reps => 'रेप्स';

  @override
  String get addRoutine => 'रूटीन जोड़ें';

  @override
  String get addExercise => 'एक्सरसाइज़ जोड़ें';

  @override
  String get save => 'सेव करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get back => 'वापस';

  @override
  String get routineDetailsTitle => 'रूटीन की जानकारी';

  @override
  String get noRoutines => 'कोई रूटीन नहीं मिली';

  @override
  String get errorLoading => 'रूटीन लोड नहीं हो सकीं';

  @override
  String get retry => 'फिर कोशिश करें';

  @override
  String get dashboardTitle => 'डैशबोर्ड';

  @override
  String get today => 'आज';

  @override
  String get noWorkoutToday => 'इस दिन का कोई वर्कआउट दर्ज नहीं है';

  @override
  String get startWorkout => 'कोई रूटीन शुरू करें';

  @override
  String get finishWorkout => 'वर्कआउट खत्म करें';

  @override
  String get workoutSavedSuccess => 'वर्कआउट सेव हो गया!';

  @override
  String get finishWorkoutConfirmation =>
      'क्या आप वाकई यह वर्कआउट खत्म करके सेव करना चाहते हैं?';

  @override
  String get activeWorkoutTitle => 'चल रहा वर्कआउट';

  @override
  String get set => 'सेट';

  @override
  String get target => 'लक्ष्य';

  @override
  String get actual => 'असल';

  @override
  String get routineName => 'रूटीन का नाम';

  @override
  String get exerciseName => 'एक्सरसाइज़ का नाम';

  @override
  String get notes => 'नोट्स';

  @override
  String get exerciseNotesLabel => 'नोट्स (वैकल्पिक)';

  @override
  String get exerciseNotesHint => 'जैसे एलिप्टिकल या साइकिल';

  @override
  String get removeExercise => 'एक्सरसाइज़ हटाएँ';

  @override
  String get addSet => 'सेट जोड़ें';

  @override
  String get saveRoutineSuccess => 'रूटीन सेव हो गई!';

  @override
  String get editRoutine => 'रूटीन बदलें';

  @override
  String get routineNameHint => 'जैसे लेग डे, सोमवार';

  @override
  String get searchExercises => 'एक्सरसाइज़ खोजें...';

  @override
  String get noResults => 'कोई एक्सरसाइज़ नहीं मिली';

  @override
  String get noExercisesAdded => 'अभी कोई एक्सरसाइज़ नहीं जोड़ी गई';

  @override
  String addCustomExercise(String name) {
    return '\'$name\' जोड़ें';
  }

  @override
  String get searchHelper => 'खोजने या जोड़ने के लिए टाइप करें...';

  @override
  String get noSetsAdded => 'कोई सेट नहीं जोड़ा गया';

  @override
  String get restTimeSeconds => 'आराम (सेकंड)';

  @override
  String removeConfirmation(String name) {
    return 'क्या आप वाकई $name हटाना चाहते हैं?';
  }

  @override
  String get remove => 'हटाएँ';

  @override
  String get unitKg => 'किग्रा';

  @override
  String get unitLb => 'पाउंड';

  @override
  String get unitReps => 'रेप्स';

  @override
  String get unitSeconds => 'से';

  @override
  String get unitMinutes => 'मिन';

  @override
  String get unitKm => 'किमी';

  @override
  String get unitMeters => 'मी';

  @override
  String get unitNone => 'कोई नहीं';

  @override
  String get unitLevel => 'लेवल';

  @override
  String get unitIncline => 'झुकाव';

  @override
  String setsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सेट',
      one: '$count सेट',
    );
    return '$_temp0';
  }

  @override
  String get language => 'भाषा';

  @override
  String get appSkin => 'ऐप थीम';

  @override
  String get skinVolt => 'वोल्ट';

  @override
  String get skinCyan => 'सियान';

  @override
  String get skinCrimson => 'क्रिमसन';

  @override
  String get skinRoyalGold => 'रॉयल गोल्ड';

  @override
  String get skinMonochrome => 'मोनोक्रोम';

  @override
  String get selectSkin => 'ऐप थीम चुनें';

  @override
  String get noExercisesInRoutine => 'इस रूटीन में कोई एक्सरसाइज़ नहीं है';

  @override
  String get deleteRoutineConfirm => 'क्या आप वाकई यह रूटीन मिटाना चाहते हैं?';

  @override
  String get delete => 'मिटाएँ';

  @override
  String get routineDeletedSuccess => 'रूटीन मिटा दी गई!';

  @override
  String get emptyRoutine => 'खाली';

  @override
  String get startNewSession => 'नया सेशन शुरू करें';

  @override
  String startRoutineName(String name) {
    return '$name शुरू करें';
  }

  @override
  String get addExercisesFirst => 'पहले एक्सरसाइज़ जोड़ें';

  @override
  String get deleteSessionConfirm =>
      'क्या आप वाकई यह वर्कआउट सेशन मिटाना चाहते हैं?';

  @override
  String get sessionDeleted => 'सेशन मिटा दिया गया';

  @override
  String get resting => 'आराम';

  @override
  String get add30Seconds => '+30 से';

  @override
  String get resumeWorkout => 'चल रहा वर्कआउट जारी रखें';

  @override
  String routineAlreadyActive(String name) {
    return '$name पहले से चल रही है। इसे जारी रखा जा रहा है।';
  }

  @override
  String get noLogsFound => 'इस सेशन का कोई रिकॉर्ड नहीं मिला';

  @override
  String get activeWorkout => 'चल रहा वर्कआउट';

  @override
  String get inProgress => 'चल रहा है...';

  @override
  String get completed => 'पूरा हुआ';

  @override
  String get pendingExercises => 'बाकी';

  @override
  String get completedExercises => 'पूरे हुए';

  @override
  String get showCompletedExercises => 'दिखाएँ';

  @override
  String get hideCompletedExercises => 'छिपाएँ';

  @override
  String get completedSession => 'पूरा हुआ सेशन';

  @override
  String get saveAsRoutineTarget => 'रूटीन के लक्ष्य के रूप में सेव करें';

  @override
  String get saveAsRoutineTargetSuccess =>
      'आगे के वर्कआउट के लिए लक्ष्य अपडेट हो गया';

  @override
  String get saveAsRoutineTargetError => 'रूटीन का लक्ष्य अपडेट नहीं हो सका';

  @override
  String get editSetValue => 'वैल्यू बदलें';

  @override
  String get saveForToday => 'आज के लिए सेव करें';

  @override
  String get saveForTodayDetail =>
      'यह वैल्यू सिर्फ़ इसी वर्कआउट के लिए दर्ज करता है';

  @override
  String get updateRoutineTarget => 'लक्ष्य अपडेट करें';

  @override
  String get updateRoutineTargetDetail => 'आगे के वर्कआउट का लक्ष्य बदलता है';

  @override
  String get errorEmptyName => 'रूटीन का नाम खाली नहीं हो सकता';

  @override
  String get noRoutinesAvailable => 'कोई रूटीन उपलब्ध नहीं है';

  @override
  String get createRoutineToGetStarted => 'शुरू करने के लिए एक रूटीन बनाएँ';

  @override
  String get errorNoExercises => 'रूटीन में कम से कम एक एक्सरसाइज़ होनी चाहिए';

  @override
  String get errorEmptySets => 'हर एक्सरसाइज़ में कम से कम एक सेट होना चाहिए';

  @override
  String get noSetsDefined => 'कोई सेट तय नहीं किया गया';

  @override
  String get authAccount => 'अकाउंट';

  @override
  String get authAnonymous => 'अनाम';

  @override
  String get authAnonymousSubtitle =>
      'आपका डेटा सिर्फ़ इसी डिवाइस पर है। सिंक करने के लिए अकाउंट जोड़ें।';

  @override
  String get authLinkedWithGoogle => 'Google से जुड़ा है';

  @override
  String get authContinueWithGoogle => 'Google से जारी रखें';

  @override
  String get authDisconnectGoogle => 'Google हटाएँ';

  @override
  String get authLinkSuccess => 'अकाउंट जुड़ गया!';

  @override
  String get authGoogleSignInConfigurationError =>
      'इस रिलीज़ बिल्ड के लिए Google साइन-इन सेट नहीं है। Firebase में रिलीज़ और Play App Signing के SHA फ़िंगरप्रिंट जोड़ें।';

  @override
  String get authGoogleSignInTimeout =>
      'Google साइन-इन में बहुत समय लग गया। कृपया फिर कोशिश करें।';

  @override
  String get authUnavailable => 'क्लाउड साइन-इन उपलब्ध नहीं है';

  @override
  String get appInfoSection => 'ऐप';

  @override
  String get appVersionLabel => 'वर्ज़न';

  @override
  String get appBuildLabel => 'बिल्ड';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get trainingDefaultsSection => 'डिफ़ॉल्ट ट्रेनिंग वैल्यू';

  @override
  String get defaultRest => 'डिफ़ॉल्ट आराम';

  @override
  String get defaultRepetitions => 'डिफ़ॉल्ट रेप्स';

  @override
  String get defaultWeight => 'डिफ़ॉल्ट वज़न';

  @override
  String get autoStartRestTimerOnComplete =>
      'सेट पूरा होते ही आराम का टाइमर चालू करें';

  @override
  String get autoStartRestTimerOnCompleteSubtitle =>
      'जब आप किसी सेट को पूरा मार्क करते हैं, टाइमर अपने आप चालू हो जाता है';

  @override
  String get restSecondsDialogTitle => 'आराम (सेकंड)';

  @override
  String get repetitionsDialogTitle => 'रेप्स';

  @override
  String get weightKgDialogTitle => 'वज़न (किग्रा)';

  @override
  String get globalManagementSection => 'सामान्य प्रबंधन';

  @override
  String get manageExercises => 'एक्सरसाइज़ मैनेज करें';

  @override
  String get manageExercisesSubtitle =>
      'एक ही जगह से एक्सरसाइज़ बनाएँ, बदलें और मिटाएँ';

  @override
  String get exerciseLibraryTitle => 'एक्सरसाइज़ लाइब्रेरी';

  @override
  String get newLabel => 'नई';

  @override
  String get newExerciseTitle => 'नई एक्सरसाइज़';

  @override
  String get editExerciseTitle => 'एक्सरसाइज़ बदलें';

  @override
  String get deleteExerciseTitle => 'एक्सरसाइज़ मिटाएँ';

  @override
  String deleteExerciseConfirm(String name) {
    return 'क्या आप वाकई $name मिटाना चाहते हैं?';
  }

  @override
  String get changesSaved => 'बदलाव सेव हो गए';

  @override
  String get exerciseNameHint => 'एक्सरसाइज़ का नाम';

  @override
  String get noExercisesToShow => 'दिखाने के लिए कोई एक्सरसाइज़ नहीं है';

  @override
  String get customLabel => 'अपनी';

  @override
  String get libraryLabel => 'लाइब्रेरी';

  @override
  String get syncCloudSection => 'क्लाउड सिंक';

  @override
  String get neverSynced => 'कभी सिंक नहीं हुआ';

  @override
  String get syncing => 'सिंक हो रहा है...';

  @override
  String get globalSyncOverlayTitle => 'आपका डेटा सिंक हो रहा है';

  @override
  String get globalSyncOverlaySubtitle =>
      'क्लाउड से रूटीन और हिस्ट्री लाई जा रही हैं...';

  @override
  String get routinesSyncingPlaceholder =>
      'क्लाउड से आपकी रूटीन लाई जा रही हैं...';

  @override
  String get syncPending => 'सिंक बाकी है';

  @override
  String get synced => 'बैकअप हो गया';

  @override
  String get syncLocked => 'बैकअप बंद है';

  @override
  String lastSync(String date) {
    return 'पिछला सिंक: $date';
  }

  @override
  String get linkGoogleForSync =>
      'क्लाउड सिंक चालू करने के लिए अपना Google अकाउंट जोड़ें';

  @override
  String get refreshNow => 'अभी रिफ़्रेश करें';

  @override
  String lastTimeValue(String value) {
    return 'पिछली बार: $value';
  }

  @override
  String get exerciseProgressTitle => 'प्रोग्रेस';

  @override
  String get viewProgress => 'प्रोग्रेस देखें';

  @override
  String get noProgressYet =>
      'अभी कोई रिकॉर्ड नहीं है। अपनी प्रोग्रेस यहाँ देखने के लिए इस एक्सरसाइज़ के साथ एक वर्कआउट पूरा करें।';

  @override
  String progressSessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सेशन',
      one: '$count सेशन',
    );
    return '$_temp0';
  }

  @override
  String get helpFeedbackSection => 'मदद और फ़ीडबैक';

  @override
  String get sendFeedback => 'फ़ीडबैक भेजें';

  @override
  String get sendFeedbackSubtitle => 'सुझाव, आइडिया या कोई समस्या बताएँ';

  @override
  String get feedbackEmailSubject => 'Muscleup — फ़ीडबैक';

  @override
  String get feedbackEmailBody => 'अपना फ़ीडबैक, आइडिया या समस्या यहाँ लिखें:';

  @override
  String get emailCopiedToClipboard =>
      'आपका ईमेल ऐप नहीं खुल सका। पता क्लिपबोर्ड पर कॉपी कर दिया गया है।';

  @override
  String get legalSection => 'कानूनी';

  @override
  String get privacyPolicy => 'प्राइवेसी पॉलिसी';

  @override
  String get privacyPolicySubtitle => 'Muscleup आपके डेटा को कैसे संभालता है';

  @override
  String privacyPolicyLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'आखिरी अपडेट: $dateString';
  }

  @override
  String get privacyPolicyIntro =>
      'Muscleup वर्कआउट ट्रैक करने वाला ऐप है। यह पॉलिसी बताती है कि ऐप कौन-सा डेटा ले सकता है, उसका इस्तेमाल कैसे होता है और उस डेटा को लेकर आपके पास क्या विकल्प हैं।';

  @override
  String get privacyPolicyDataTitle => 'हम कौन-सा डेटा लेते हैं';

  @override
  String get privacyPolicyDataItem1 =>
      'अकाउंट की जानकारी, जैसे नाम, ईमेल पता और यूज़र आईडी।';

  @override
  String get privacyPolicyDataItem2 =>
      'वर्कआउट का डेटा, जैसे रूटीन, एक्सरसाइज़, सेट, वज़न, रेप्स, सेशन, हिस्ट्री और ऐप में लिखे गए वैकल्पिक नोट्स।';

  @override
  String get privacyPolicyDataItem3 =>
      'ऐप की सेटिंग्स, जैसे भाषा, थीम और ट्रेनिंग से जुड़ी पसंद।';

  @override
  String get privacyPolicyCollectionTitle => 'डेटा कैसे लिया जाता है';

  @override
  String get privacyPolicyCollectionItem1 =>
      'ऐप को बिना अकाउंट जोड़े, सिर्फ़ डिवाइस पर इस्तेमाल किया जा सकता है।';

  @override
  String get privacyPolicyCollectionItem2 =>
      'अगर आप अपना अकाउंट Google से जोड़ते हैं, तो Muscleup साइन-इन के लिए Firebase Authentication का इस्तेमाल करता है।';

  @override
  String get privacyPolicyCollectionItem3 =>
      'अगर आप क्लाउड सिंक चुनते हैं, तो डेटा Google Firebase Cloud Firestore में आपके अकाउंट से जुड़ा हुआ रखा जाता है।';

  @override
  String get privacyPolicyUsageTitle => 'हम डेटा का इस्तेमाल कैसे करते हैं';

  @override
  String get privacyPolicyUsageItem1 => 'साइन-इन और अकाउंट मैनेज करने के लिए।';

  @override
  String get privacyPolicyUsageItem2 =>
      'आपकी रूटीन और वर्कआउट हिस्ट्री सेव, सिंक और रिस्टोर करने के लिए।';

  @override
  String get privacyPolicyUsageItem3 =>
      'आपकी पसंद सहेजने और ऐप की मुख्य सुविधाएँ देने के लिए।';

  @override
  String get privacyPolicySharingTitle => 'डेटा साझा करना';

  @override
  String get privacyPolicySharingBody =>
      'Muscleup आपका डेटा न बेचता है और न ही विज्ञापन या मार्केटिंग के लिए किसी तीसरे पक्ष के साथ साझा करता है। ऐप चलाने के लिए ज़रूरी इंफ़्रास्ट्रक्चर सेवाएँ, जैसे Firebase Authentication और Cloud Firestore, डेटा प्रोसेस कर सकती हैं।';

  @override
  String get privacyPolicySecurityTitle => 'एन्क्रिप्शन और सुरक्षा';

  @override
  String get privacyPolicySecurityBody =>
      'डेटा सुरक्षित, एन्क्रिप्टेड कनेक्शन से भेजा जाता है। सिंक किए गए डेटा तक पहुँच सिर्फ़ उसी साइन-इन किए हुए यूज़र के पास है जिसका वह डेटा है।';

  @override
  String get privacyPolicyRetentionTitle => 'डेटा कितने समय रखा जाता है';

  @override
  String get privacyPolicyRetentionBody =>
      'जब तक आप अपना अकाउंट रखते हैं और क्लाउड सिंक इस्तेमाल करते हैं, डेटा सहेजा जाता है, बशर्ते आप उसे मिटाने का अनुरोध न करें। थोड़ा-सा तकनीकी डेटा सीमित समय के लिए इंफ़्रास्ट्रक्चर बैकअप में रह सकता है।';

  @override
  String get privacyPolicyDeletionTitle => 'अकाउंट और डेटा मिटाना';

  @override
  String get privacyPolicyDeletionBody =>
      'आप कभी भी अपना अकाउंट और उससे जुड़ा सारा डेटा मिटाने का अनुरोध कर सकते हैं। अकाउंट मिटाने वाले पेज पर पूरी जानकारी है कि क्या-क्या मिटेगा और कितना समय लगेगा। डेटा मिट जाने पर हम आपको ईमेल से पुष्टि करते हैं।';

  @override
  String get privacyPolicyChildrenTitle => 'बच्चों की प्राइवेसी';

  @override
  String get privacyPolicyChildrenBody =>
      'Muscleup खास तौर पर 13 साल से कम उम्र के बच्चों के लिए नहीं है।';

  @override
  String get privacyPolicyContactTitle => 'संपर्क';

  @override
  String get privacyPolicyContactBody =>
      'इस पॉलिसी को लेकर कोई सवाल हो तो हमें यहाँ लिखें:';

  @override
  String get privacyPolicyOpenOnline => 'ऑनलाइन वर्ज़न देखें';

  @override
  String get privacyPolicyAccountDeletionPage => 'अकाउंट मिटाने वाला पेज खोलें';

  @override
  String get privacyPolicyAccountDeletion => 'ईमेल से मिटाने का अनुरोध करें';

  @override
  String get accountDeletionEmailSubject =>
      'Muscleup — अकाउंट मिटाने का अनुरोध';

  @override
  String get accountDeletionEmailBody =>
      'मैं अपना Muscleup अकाउंट और उससे जुड़ा सारा डेटा मिटाने का अनुरोध करना चाहता/चाहती हूँ।';

  @override
  String get couldNotOpenLink => 'इस डिवाइस पर लिंक नहीं खुल सका।';

  @override
  String get exitAppTitle => 'Muscleup बंद करें?';

  @override
  String get exitAppMessage => 'क्या आप वाकई ऐप बंद करना चाहते हैं?';

  @override
  String get exitAppConfirm => 'बंद करें';

  @override
  String get importTitle => 'रूटीन इंपोर्ट करें';

  @override
  String get importHeadline => 'अपना पूरा प्लान एक ही कदम में लाएँ';

  @override
  String get importIntro =>
      'अपना वर्कआउट प्लान पेस्ट करें और Muscleup सभी रूटीन बना देगा — एक्सरसाइज़, सेट, वज़न, दोहराव और नोट्स के साथ। कोई भी AI असिस्टेंट आपके नोट्स को ऐप के ज़रूरी फ़ॉर्मैट में बदल सकता है।';

  @override
  String get importStep1 => 'निर्देश कॉपी करें।';

  @override
  String get importStep2 =>
      'उन्हें किसी AI चैट में पेस्ट करें — ChatGPT, Claude, Gemini — और उसके बाद अपने वर्कआउट नोट्स जैसे लिखे हैं वैसे ही पेस्ट करें।';

  @override
  String get importStep3 =>
      'जवाब कॉपी करें, नीचे पेस्ट करें और इंपोर्ट करने से पहले जाँच लें।';

  @override
  String get importCopyInstructions => 'निर्देश कॉपी करें';

  @override
  String get importInstructionsCopied =>
      'निर्देश कॉपी हो गए। इन्हें अपने नोट्स के साथ किसी AI चैट में पेस्ट करें।';

  @override
  String importInstructionsLanguageNote(String language) {
    return 'निर्देश अंग्रेज़ी में हैं क्योंकि असिस्टेंट उन्हें इसी तरह सबसे सही ढंग से मानते हैं। आपके रूटीन $language में वापस आएँगे।';
  }

  @override
  String get importPasteLabel => 'असिस्टेंट का जवाब';

  @override
  String get importPasteHint => 'JSON यहाँ पेस्ट करें';

  @override
  String get importPasteFromClipboard => 'पेस्ट करें';

  @override
  String get importClipboardEmpty => 'पेस्ट करने के लिए कुछ नहीं है।';

  @override
  String get importCheck => 'जाँचें';

  @override
  String get importClear => 'साफ़ करें';

  @override
  String get importAction => 'इंपोर्ट करें';

  @override
  String get importPreviewTitle => 'यह बनाया जाएगा';

  @override
  String importRoutineSummary(int exerciseCount, int setCount) {
    return 'एक्सरसाइज़: $exerciseCount · सेट: $setCount';
  }

  @override
  String get importNoticesTitle => 'देख लेने लायक';

  @override
  String get importSuccess => 'रूटीन इंपोर्ट हो गए';

  @override
  String get importErrorEmptyInput => 'पहले असिस्टेंट का जवाब पेस्ट करें।';

  @override
  String get importErrorInvalidJson =>
      'यह टेक्स्ट मान्य JSON नहीं है। जवाब को ब्रेसेज़ सहित फिर से कॉपी करें, या असिस्टेंट से कहें कि वह सिर्फ़ JSON में जवाब दे।';

  @override
  String get importErrorNoRoutines =>
      'उस टेक्स्ट में कोई रूटीन नहीं मिला। इसमें “routines” की सूची चाहिए, जिसमें कम से कम एक दिन में एक्सरसाइज़ हों।';

  @override
  String importNoticeNoExercises(String name) {
    return '“$name” छोड़ दिया गया: इसमें कोई एक्सरसाइज़ नहीं है।';
  }

  @override
  String importNoticeSkippedRoutines(int count) {
    return 'नाम न होने के कारण छोड़ी गई प्रविष्टियाँ: $count।';
  }

  @override
  String importNoticeSkippedExercises(String name, int count) {
    return '“$name” में नाम न होने के कारण छोड़ी गई एक्सरसाइज़: $count।';
  }

  @override
  String importNoticeDuplicateName(String name) {
    return 'आपके पास “$name” नाम का रूटीन पहले से है। यह उसके साथ जोड़ दिया जाएगा।';
  }

  @override
  String get importSettingsSubtitle =>
      'प्लान पेस्ट करें और सारे रूटीन एक बार में बनाएँ';

  @override
  String get exportTitle => 'रूटीन एक्सपोर्ट करें';

  @override
  String get exportSettingsSubtitle =>
      'एक कॉपी सेव करें जिसे आप वापस पेस्ट कर सकें';

  @override
  String get exportIntro =>
      'ये आपके सारे रूटीन हैं, उसी फ़ॉर्मैट में जिसे इंपोर्ट स्क्रीन पढ़ती है। इसे किसी नोट या फ़ाइल में रखें: वापस पेस्ट करने पर ये अपनी एक्सरसाइज़, सेट, वज़न और नोट्स के साथ दोबारा बन जाते हैं — यहाँ या किसी नए फ़ोन पर।';

  @override
  String get exportHistoryNote =>
      'रिकॉर्ड किए गए वर्कआउट इसमें शामिल नहीं हैं: यहाँ सिर्फ़ आपके रूटीन हैं।';

  @override
  String exportSummary(int routineCount, int exerciseCount, int setCount) {
    return 'रूटीन: $routineCount · एक्सरसाइज़: $exerciseCount · सेट: $setCount';
  }

  @override
  String get exportCopy => 'JSON कॉपी करें';

  @override
  String get exportCopied =>
      'रूटीन कॉपी हो गए। इन्हें कहीं ऐसी जगह पेस्ट करें जहाँ आप रख सकें।';

  @override
  String get exportEmpty =>
      'आपके पास एक्सपोर्ट करने के लिए अभी कोई रूटीन नहीं है।';

  @override
  String get exportError => 'आपके रूटीन पढ़े नहीं जा सके। फिर कोशिश करें।';
}
