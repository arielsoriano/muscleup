import 'package:shared_preferences/shared_preferences.dart';

class SettingsDataSource {
  SettingsDataSource(this._preferences);

  final SharedPreferences _preferences;

  static const String _languageCodeKey = 'language_code';

  Future<String?> getLanguageCode() async {
    return _preferences.getString(_languageCodeKey);
  }

  Future<void> saveLanguageCode(String code) async {
    await _preferences.setString(_languageCodeKey, code);
  }
}
