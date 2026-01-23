import 'package:shared_preferences/shared_preferences.dart';

class SettingsDataSource {
  SettingsDataSource(this._preferences);

  final SharedPreferences _preferences;

  static const String _languageCodeKey = 'language_code';
  static const String _skinKey = 'app_skin';
  static const String _isDarkModeKey = 'is_dark_mode';

  Future<String?> getLanguageCode() async {
    return _preferences.getString(_languageCodeKey);
  }

  Future<void> saveLanguageCode(String code) async {
    await _preferences.setString(_languageCodeKey, code);
  }

  Future<String?> getSkin() async {
    return _preferences.getString(_skinKey);
  }

  Future<void> saveSkin(String skin) async {
    await _preferences.setString(_skinKey, skin);
  }

  Future<bool?> getIsDarkMode() async {
    return _preferences.getBool(_isDarkModeKey);
  }

  Future<void> saveIsDarkMode(bool isDarkMode) async {
    await _preferences.setBool(_isDarkModeKey, isDarkMode);
  }
}
