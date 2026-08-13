import 'exercise_names_de.dart';
import 'exercise_names_es.dart';
import 'exercise_names_fr.dart';
import 'exercise_names_hi.dart';
import 'exercise_names_id.dart';
import 'exercise_names_it.dart';
import 'exercise_names_nl.dart';
import 'exercise_names_pl.dart';
import 'exercise_names_pt.dart';
import 'exercise_names_ru.dart';
import 'exercise_names_tr.dart';
import 'exercise_names_vi.dart';

/// Every translation table for the seeded exercise catalog, keyed by language
/// code.
///
/// To add a language:
///   1. Copy `exercise_names_es.dart` to `exercise_names_<code>.dart` and
///      translate the values, leaving the English keys untouched.
///   2. Import it here and add one entry to this map.
///   3. Add the locale to `SupportedLanguages` so the UI offers it.
///
/// Nothing else changes: the database, the sync payloads and the search all
/// read through this map. Keys missing from a table fall back to English, so a
/// language can ship before every exercise is translated.
const Map<String, Map<String, String>> exerciseNameTranslations =
    <String, Map<String, String>>{
  'de': exerciseNamesDe,
  'es': exerciseNamesEs,
  'fr': exerciseNamesFr,
  'hi': exerciseNamesHi,
  'id': exerciseNamesId,
  'it': exerciseNamesIt,
  'nl': exerciseNamesNl,
  'pl': exerciseNamesPl,
  'pt': exerciseNamesPt,
  'ru': exerciseNamesRu,
  'tr': exerciseNamesTr,
  'vi': exerciseNamesVi,
};
