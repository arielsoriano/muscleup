import 'package:flutter_test/flutter_test.dart';
import 'package:muscleup/core/l10n/localized_text.dart';

void main() {
  group('LocalizedText resolution', () {
    const names = LocalizedText(<String, String>{
      'en': 'Deadlift',
      'es': 'Peso Muerto',
    });

    test('returns the exact language when present', () {
      expect(names.resolve('es'), 'Peso Muerto');
    });

    test('falls back to English for an untranslated language', () {
      // The whole point of shipping a language before it is fully translated:
      // a missing name renders in English instead of rendering blank.
      expect(names.resolve('pt'), 'Deadlift');
    });

    test('matches a regional locale against its base language', () {
      expect(names.resolve('es_AR'), 'Peso Muerto');
      expect(names.resolve('es-419'), 'Peso Muerto');
      expect(names.resolve('ES'), 'Peso Muerto');
    });

    test('falls back to any translation when English is absent', () {
      const spanishOnly = LocalizedText(<String, String>{'es': 'Sentadilla'});
      expect(spanishOnly.resolve('de'), 'Sentadilla');
    });

    test('resolves to empty rather than throwing when there is nothing', () {
      expect(const LocalizedText.empty().resolve('en'), '');
    });
  });

  group('LocalizedText encoding', () {
    test('survives a round trip through the stored form', () {
      const original = LocalizedText(<String, String>{
        'en': 'Pull-up',
        'es': 'Dominadas',
        'fr': "Traction à la barre",
      });

      expect(LocalizedText.decode(original.encode()), original);
    });

    test('degrades to the fallback instead of throwing on bad input', () {
      // One corrupted row must not take down the whole exercise picker.
      expect(
        LocalizedText.decode('not json at all', fallback: 'Squat').resolve('en'),
        'Squat',
      );
      expect(
        LocalizedText.decode(null, fallback: 'Squat').resolve('en'),
        'Squat',
      );
      expect(
        LocalizedText.decode('[1,2,3]', fallback: 'Squat').resolve('en'),
        'Squat',
      );
    });

    test('drops non-string and blank entries when reading remote data', () {
      final parsed = LocalizedText.fromDynamicMap(<Object?, Object?>{
        'en': 'Row',
        'es': '   ',
        'de': 42,
        7: 'nonsense',
      });

      expect(parsed.byLanguageCode, <String, String>{'en': 'Row'});
    });
  });

  group('LocalizedText editing', () {
    const names = LocalizedText(<String, String>{
      'en': 'Bench Press',
      'es': 'Press de Banca',
    });

    test('withValue replaces only the language being edited', () {
      final edited = names.withValue('es', 'Press Plano');

      expect(edited.resolve('es'), 'Press Plano');
      expect(edited.resolve('en'), 'Bench Press');
    });

    test('withValue normalizes a regional code onto its base language', () {
      final edited = names.withValue('es_MX', 'Press Plano');

      expect(edited.byLanguageCode.containsKey('es_MX'), isFalse);
      expect(edited.resolve('es'), 'Press Plano');
    });

    test('mergedWith lets the argument win per language', () {
      const incoming = LocalizedText(<String, String>{
        'es': 'Press Plano',
        'pt': 'Supino',
      });

      final merged = names.mergedWith(incoming);

      expect(merged.resolve('en'), 'Bench Press');
      expect(merged.resolve('es'), 'Press Plano');
      expect(merged.resolve('pt'), 'Supino');
    });
  });
}
