# Adding a language

Adding a language touches three files and creates two. Nothing in the database
schema, the sync payloads or the widgets needs to change — that is what the
`LocalizedText` refactor bought.

Throughout, `<code>` is the ISO 639-1 language code: `pt`, `de`, `fr`, `it`,
`tr`, `ru`, `ja`. Use the base language, without a region, unless the wording
genuinely differs between regions — `pt_BR` and `pt` resolve to the same table
otherwise.

## 1. Translate the UI strings

```bash
cp lib/l10n/app_en.arb lib/l10n/app_<code>.arb
```

Translate the values, leave the keys alone, and delete the `@`-prefixed
metadata blocks — those live in the template file only.

Two things to get right:

- **Plurals.** `setsCount` and `progressSessionsCount` are ICU plurals. English
  and Spanish need two forms (`=1` and `other`); Russian, Polish, Arabic and
  Czech need more (`one`, `few`, `many`, `other`). Supply the categories the
  language actually has, not a copy of the English two.
- **Placeholders.** `{name}`, `{count}`, `{date}` must survive translation
  exactly. `flutter gen-l10n` fails the build if one is dropped or renamed, so a
  mistake here is caught at compile time rather than in production.

## 2. Register the language name

In [`lib/core/l10n/supported_languages.dart`](../lib/core/l10n/supported_languages.dart),
add one entry to `_nativeNames`:

```dart
'pt': 'Português',
```

Write the name in its own language and script. Someone who has the app stuck in
a language they cannot read needs to recognize their own entry in the picker.

The locale list itself is derived from the `.arb` files, so `main.dart` and the
settings picker pick the new language up on their own.

## 3. Translate the exercise names

```bash
cp lib/core/constants/exercise_names/exercise_names_es.dart \
   lib/core/constants/exercise_names/exercise_names_<code>.dart
```

Rename the constant to `exerciseNames<Code>`, then translate the **values**.
The keys are canonical English names and must stay byte-identical — they are
what links a translation to its catalog entry.

Register the table in
[`exercise_name_translations.dart`](../lib/core/constants/exercise_names/exercise_name_translations.dart):

```dart
'pt': exerciseNamesPt,
```

A key you leave out is not an error: that exercise falls back to English, so a
language can ship half-translated and be completed later.

Gym vocabulary is the part most worth having a native speaker check. Most
languages keep the English term for some movements (*set*, *curl*, *press*,
*burpee*) and translate others, and machine translation reliably gets this
wrong.

## 4. Regenerate and check

```bash
flutter gen-l10n
flutter analyze
flutter test
```

Then run the app and switch to the new language. Look for:

- **Overflow.** German runs about 30% longer than English and Russian about
  20%. Buttons, tabs and list subtitles are where it shows first.
- **Right-to-left.** Arabic, Hebrew, Persian and Urdu need the layout checked,
  not just the strings. Flutter mirrors most widgets automatically, but
  directional icons, custom paddings and anything positioned by hand need a
  look.

## What reaches existing users

Users who installed an earlier build already have their exercise catalog seeded
with the languages that existed back then. `refreshSeededExerciseTranslations`
runs on every database open and merges the current catalog into those rows, so
a newly shipped language appears without a reinstall. It only fills in missing
languages, so exercises the user renamed keep their own names.

## Also worth translating: the Play Store listing

The store listing is translated in the Play Console, not in this repo, and it
moves installs more than the in-app strings do — Google Play shows each user the
listing in their own language. It is roughly 4,000 characters (title, short
description, full description, screenshot captions), and it can be published in
more languages than the app itself supports.
