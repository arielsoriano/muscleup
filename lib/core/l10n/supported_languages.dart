import 'dart:ui';

import '../../l10n/app_localizations.dart';
import 'localized_text.dart';

/// The languages the app ships in.
///
/// Which languages exist is decided by the `.arb` files: `flutter gen-l10n`
/// turns each one into an entry of [AppLocalizations.supportedLocales], and
/// this class reads from there rather than keeping a second list that could
/// drift out of sync.
///
/// To add a language:
///   1. Copy `lib/l10n/app_en.arb` to `app_<code>.arb` and translate it.
///   2. Add the language's own name to [_nativeNames] below.
///   3. Add its exercise names in `core/constants/exercise_names/`.
///
/// Everything else — the locale list, the settings picker, the fallback chain —
/// follows from those three edits.
class SupportedLanguages {
  const SupportedLanguages._();

  /// Names are written the way speakers of that language write them, not
  /// translated into the current UI language: someone who has the app stuck in
  /// a language they cannot read needs to recognize their own in the list.
  static const Map<String, String> _nativeNames = <String, String>{
    'en': 'English',
    'es': 'Español',
    'pt': 'Português',
    'de': 'Deutsch',
    'fr': 'Français',
    'it': 'Italiano',
    'tr': 'Türkçe',
    'ru': 'Русский',
    'pl': 'Polski',
    'nl': 'Nederlands',
    'id': 'Bahasa Indonesia',
    'vi': 'Tiếng Việt',
    'hi': 'हिन्दी',
    // When adding a language, keep the name in its own script:
    // 'ja': '日本語',
  };

  static List<Locale> get locales => AppLocalizations.supportedLocales;

  /// Language codes in the order the picker should list them.
  static List<String> get languageCodes {
    final codes = locales.map((locale) => locale.languageCode).toSet().toList()
      ..sort((a, b) => nativeName(a).toLowerCase().compareTo(nativeName(b).toLowerCase()));
    return codes;
  }

  /// The language's own name, falling back to the raw code so a language whose
  /// `.arb` landed before its entry here still shows something selectable
  /// instead of silently disappearing from the picker.
  static String nativeName(String languageCode) {
    return _nativeNames[LocalizedText.normalizeLanguageCode(languageCode)] ??
        languageCode.toUpperCase();
  }

  /// The supported locale matching [languageCode], ignoring region, or null.
  static Locale? resolve(String? languageCode) {
    if (languageCode == null) {
      return null;
    }

    final normalized = LocalizedText.normalizeLanguageCode(languageCode);
    if (normalized.isEmpty) {
      return null;
    }

    for (final locale in locales) {
      if (LocalizedText.normalizeLanguageCode(locale.languageCode) == normalized) {
        return locale;
      }
    }
    return null;
  }

  /// The locale to start in when nothing has been saved yet.
  static Locale get fallbackLocale =>
      resolve(LocalizedText.baseLanguageCode) ??
      locales.first;
}
