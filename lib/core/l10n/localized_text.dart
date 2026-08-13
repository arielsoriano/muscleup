import 'dart:convert';

/// A piece of user-visible text stored in every language it has been
/// translated into, keyed by language code.
///
/// Exercise names are the only content the app stores per language, and they
/// arrive from three places that must agree: the seeded catalog, the local
/// database and Firestore. Keeping them in a map instead of one field per
/// language means adding a language touches the translation tables only, never
/// the schema, the DTOs or the queries.
class LocalizedText {
  const LocalizedText(this.byLanguageCode);

  /// Text that exists in a single language, or none in particular — a name the
  /// user typed themselves, which we file under the base language so it still
  /// resolves for every locale.
  factory LocalizedText.single(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return const LocalizedText.empty();
    }
    return LocalizedText(<String, String>{baseLanguageCode: trimmed});
  }

  const LocalizedText.empty() : byLanguageCode = const <String, String>{};

  /// Reads the map persisted by [encode]. Anything unparseable degrades to
  /// [fallback] rather than throwing, so one malformed row cannot take down the
  /// exercise picker.
  factory LocalizedText.decode(String? source, {String fallback = ''}) {
    if (source == null || source.trim().isEmpty) {
      return LocalizedText.single(fallback);
    }

    try {
      final decoded = jsonDecode(source);
      if (decoded is! Map) {
        return LocalizedText.single(fallback);
      }
      return LocalizedText.fromDynamicMap(decoded, fallback: fallback);
    } on FormatException {
      return LocalizedText.single(fallback);
    }
  }

  /// Builds from an untyped map, as read from Firestore or an outbox payload.
  factory LocalizedText.fromDynamicMap(Map<Object?, Object?> source, {
    String fallback = '',
  }) {
    final entries = <String, String>{};
    for (final entry in source.entries) {
      final code = entry.key;
      final value = entry.value;
      if (code is! String || value is! String) {
        continue;
      }
      final normalizedCode = normalizeLanguageCode(code);
      final trimmed = value.trim();
      if (normalizedCode.isEmpty || trimmed.isEmpty) {
        continue;
      }
      entries[normalizedCode] = trimmed;
    }

    if (entries.isEmpty) {
      return LocalizedText.single(fallback);
    }
    return LocalizedText(entries);
  }

  /// The language every other one falls back to. English is the language the
  /// exercise catalog is authored in, so it is the one guaranteed to be present.
  static const String baseLanguageCode = 'en';

  final Map<String, String> byLanguageCode;

  /// Strips region and script subtags: `pt_BR`, `pt-BR` and `PT` all resolve
  /// against the `pt` translation table. Regional variants only need their own
  /// entry when the wording actually differs.
  static String normalizeLanguageCode(String code) {
    final separatorIndex = code.indexOf(RegExp('[-_]'));
    final language = separatorIndex == -1 ? code : code.substring(0, separatorIndex);
    return language.trim().toLowerCase();
  }

  /// The best available text for [languageCode]: the exact locale, then its
  /// base language, then English, then whatever translation exists. Returning
  /// a name in the wrong language beats returning a blank row.
  String resolve(String languageCode) {
    if (byLanguageCode.isEmpty) {
      return '';
    }

    final exact = byLanguageCode[languageCode];
    if (exact != null && exact.isNotEmpty) {
      return exact;
    }

    final base = byLanguageCode[normalizeLanguageCode(languageCode)];
    if (base != null && base.isNotEmpty) {
      return base;
    }

    final english = byLanguageCode[baseLanguageCode];
    if (english != null && english.isNotEmpty) {
      return english;
    }

    return byLanguageCode.values.firstWhere(
      (value) => value.isNotEmpty,
      orElse: () => '',
    );
  }

  /// Every translation, for matching a search query or deduplicating rows that
  /// name the same exercise in different languages.
  Iterable<String> get values => byLanguageCode.values;

  bool get isEmpty => byLanguageCode.isEmpty;

  bool get isNotEmpty => byLanguageCode.isNotEmpty;

  /// Returns a copy with [value] set for [languageCode], dropping the entry
  /// when the value is blank.
  LocalizedText withValue(String languageCode, String value) {
    final code = normalizeLanguageCode(languageCode);
    final trimmed = value.trim();
    final next = Map<String, String>.of(byLanguageCode);

    if (trimmed.isEmpty) {
      next.remove(code);
    } else {
      next[code] = trimmed;
    }

    return LocalizedText(next);
  }

  /// Merges [other] on top of this text. Used when a row that carries only the
  /// user's language meets the seeded catalog entry that carries the rest.
  LocalizedText mergedWith(LocalizedText other) {
    if (other.isEmpty) {
      return this;
    }
    if (isEmpty) {
      return other;
    }
    return LocalizedText(<String, String>{...byLanguageCode, ...other.byLanguageCode});
  }

  /// The form stored in the `names_json` column.
  String encode() => jsonEncode(byLanguageCode);

  /// The form written to Firestore.
  Map<String, dynamic> toMap() => Map<String, dynamic>.of(byLanguageCode);

  @override
  String toString() => 'LocalizedText($byLanguageCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! LocalizedText) {
      return false;
    }
    if (other.byLanguageCode.length != byLanguageCode.length) {
      return false;
    }
    for (final entry in byLanguageCode.entries) {
      if (other.byLanguageCode[entry.key] != entry.value) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    // Order-independent, so two maps built in a different order still match.
    var result = 0;
    for (final entry in byLanguageCode.entries) {
      result ^= Object.hash(entry.key, entry.value);
    }
    return result;
  }
}
