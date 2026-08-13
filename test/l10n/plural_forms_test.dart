import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muscleup/l10n/app_localizations.dart';

/// Checks the languages whose plural rules English cannot express.
///
/// Slavic plurals are the single easiest thing to get wrong in a translated
/// app: Russian and Polish pick a different form for 1, for 2–4, and for 5–20,
/// and the cycle restarts at 21. A translation that only supplies the two forms
/// English needs looks fine for "1 set" and "3 sets" and then reads as broken
/// grammar for everything from 5 upwards.
Future<AppLocalizations> load(String languageCode) {
  return AppLocalizations.delegate.load(Locale(languageCode));
}

void main() {
  test('Russian picks the right form across the 1 / 2-4 / 5+ cycle', () async {
    final ru = await load('ru');

    expect(ru.setsCount(1), '1 подход');
    expect(ru.setsCount(2), '2 подхода');
    expect(ru.setsCount(4), '4 подхода');
    expect(ru.setsCount(5), '5 подходов');
    expect(ru.setsCount(11), '11 подходов');
    // The cycle restarts in the twenties: 21 takes the singular form again.
    expect(ru.setsCount(21), '21 подход');
    expect(ru.setsCount(22), '22 подхода');
    expect(ru.setsCount(25), '25 подходов');
  });

  test('Polish picks the right form across the 1 / 2-4 / 5+ cycle', () async {
    final pl = await load('pl');

    expect(pl.setsCount(1), '1 seria');
    expect(pl.setsCount(2), '2 serie');
    expect(pl.setsCount(4), '4 serie');
    expect(pl.setsCount(5), '5 serii');
    expect(pl.setsCount(12), '12 serii');
    expect(pl.setsCount(22), '22 serie');
    expect(pl.setsCount(25), '25 serii');
  });

  test('Indonesian and Vietnamese never inflect the noun', () async {
    final id = await load('id');
    final vi = await load('vi');

    // Neither language marks plural on the noun, so the same word has to serve
    // every count. Supplying an English-shaped singular/plural pair here would
    // have produced a form that does not exist in the language.
    expect(id.setsCount(1), '1 set');
    expect(id.setsCount(7), '7 set');
    expect(vi.setsCount(1), '1 hiệp');
    expect(vi.setsCount(7), '7 hiệp');
  });

  test('two-form languages still read correctly', () async {
    final nl = await load('nl');
    final hi = await load('hi');

    expect(nl.setsCount(1), '1 set');
    expect(nl.setsCount(3), '3 sets');
    expect(hi.setsCount(1), '1 सेट');
    expect(hi.setsCount(3), '3 सेट');
  });

  test('every supported locale loads and resolves a plural', () async {
    for (final locale in AppLocalizations.supportedLocales) {
      final l10n = await AppLocalizations.delegate.load(locale);

      expect(
        l10n.setsCount(3),
        isNotEmpty,
        reason: 'setsCount is blank in ${locale.languageCode}',
      );
      expect(
        l10n.progressSessionsCount(5),
        isNotEmpty,
        reason: 'progressSessionsCount is blank in ${locale.languageCode}',
      );
    }
  });
}
