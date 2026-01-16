import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/settings/settings_data_source.dart';
import '../../../../l10n/app_localizations.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsDataSource)
      : super(const SettingsState(locale: Locale('en'))) {
    _initialize();
  }

  final SettingsDataSource _settingsDataSource;

  Future<void> _initialize() async {
    final savedLanguageCode = await _settingsDataSource.getLanguageCode();
    
    final Locale locale;
    if (savedLanguageCode != null) {
      locale = Locale(savedLanguageCode);
    } else {
      final platformLocale = PlatformDispatcher.instance.locale;
      final isSupported = AppLocalizations.supportedLocales.any(
        (supportedLocale) => supportedLocale.languageCode == platformLocale.languageCode,
      );
      locale = isSupported ? platformLocale : const Locale('en');
    }

    emit(SettingsState(locale: locale));
  }

  Future<void> changeLanguage(String languageCode) async {
    await _settingsDataSource.saveLanguageCode(languageCode);
    emit(SettingsState(locale: Locale(languageCode)));
  }
}
