import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/settings/settings_data_source.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsDataSource)
      : super(SettingsState(
          locale: _systemLocaleOrEnglish(),
          currentSkin: AppSkin.volt,
          isDarkMode: true,
        ),) {
    _initialize();
  }

  final SettingsDataSource _settingsDataSource;

  static Locale _systemLocaleOrEnglish() {
    final platformLanguageCode = PlatformDispatcher.instance.locale.languageCode;
    return _supportedLocaleOrNull(platformLanguageCode) ?? const Locale('en');
  }

  static Locale? _supportedLocaleOrNull(String languageCode) {
    final normalizedCode = languageCode.toLowerCase();
    for (final locale in AppLocalizations.supportedLocales) {
      if (locale.languageCode.toLowerCase() == normalizedCode) {
        return locale;
      }
    }
    return null;
  }

  Locale _resolveInitialLocale(String? savedLanguageCode) {
    if (savedLanguageCode != null) {
      final savedSupportedLocale = _supportedLocaleOrNull(savedLanguageCode);
      if (savedSupportedLocale != null) {
        return savedSupportedLocale;
      }
    }

    return _systemLocaleOrEnglish();
  }

  Future<void> _initialize() async {
    final savedLanguageCode = await _settingsDataSource.getLanguageCode();
    final savedSkinString = await _settingsDataSource.getSkin();
    final savedIsDarkMode = await _settingsDataSource.getIsDarkMode();

    final locale = _resolveInitialLocale(savedLanguageCode);

    final currentSkin = savedSkinString != null
        ? AppSkinExtension.fromString(savedSkinString)
        : AppSkin.volt;

    final isDarkMode = savedIsDarkMode ?? true;

    emit(SettingsState(
      locale: locale,
      currentSkin: currentSkin,
      isDarkMode: isDarkMode,
    ),);
  }

  Future<void> changeLanguage(String languageCode) async {
    await _settingsDataSource.saveLanguageCode(languageCode);
    emit(SettingsState(
      locale: Locale(languageCode),
      currentSkin: state.currentSkin,
      isDarkMode: state.isDarkMode,
    ),);
  }

  Future<void> changeSkin(AppSkin newSkin) async {
    await _settingsDataSource.saveSkin(newSkin.name);
    emit(SettingsState(
      locale: state.locale,
      currentSkin: newSkin,
      isDarkMode: state.isDarkMode,
    ),);
  }

  Future<void> toggleDarkMode() async {
    final newIsDarkMode = !state.isDarkMode;
    await _settingsDataSource.saveIsDarkMode(newIsDarkMode);
    emit(SettingsState(
      locale: state.locale,
      currentSkin: state.currentSkin,
      isDarkMode: newIsDarkMode,
    ),);
  }
}
