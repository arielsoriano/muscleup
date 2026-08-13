class AppConstants {
  static const String appName = 'Muscleup';
  static const String databaseName = 'muscleup.db';
  static const int databaseVersion = 4;

  /// Address published in the Play Store listing and in the privacy policy.
  static const String contactEmail = 'lrarielsoriano@gmail.com';

  /// Date the privacy policy text bundled in the app was last revised. Keep it
  /// in sync with `docs/privacy-policy.html`.
  static const String privacyPolicyLastUpdated = '2026-04-18';

  static const String privacyPolicyUrl =
      'https://arielsoriano.github.io/muscleup/privacy-policy.html';

  /// Public deletion instructions page. Google Play requires this URL to be
  /// reachable without signing in; it is also declared in the Play Console
  /// under App content -> Data safety.
  static const String accountDeletionUrl =
      'https://arielsoriano.github.io/muscleup/account-deletion.html';
}
