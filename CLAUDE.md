# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Muscleup is a Flutter workout-tracking app for Android, published on the Play Store (`version: 1.0.1+16` in `pubspec.yaml`). Offline-first: everything works on-device, and cloud sync to Firebase is opt-in behind a Google account link. Ad-free, no analytics, GPL v3.

`README.md` covers features and stack. `ARCHITECTURE.md` (~2000 lines) documents the Clean Architecture layers phase by phase — read it for layer-level detail rather than re-deriving it.

## Commands

```bash
flutter pub get
flutter run
flutter analyze
flutter test
flutter test test/features/workout/data/dtos/          # a directory
flutter test test/l10n/plural_forms_test.dart          # a single file
flutter test --plain-name 'links routine exercises'    # a single test by name
```

### Code generation — two separate steps

Both must be re-run after the relevant edits, and forgetting either produces confusing "undefined getter" errors:

```bash
dart run build_runner build --delete-conflicting-outputs   # Drift tables + Freezed entities
flutter gen-l10n                                           # ARB files -> AppLocalizations
```

`build_runner` after touching any Drift table or `@freezed` class. `gen-l10n` after touching any `lib/l10n/app_*.arb`. Config lives in `l10n.yaml`; generated localization sources are committed under `lib/l10n/`.

### Test baseline

**9 tests fail on a clean checkout** and are unrelated to current work — `AuthCubit bootstrap signs in anonymously…`, 3 × `SettingsPage sync integration…`, and 5 × `WorkoutSyncEngine…`. `auth_cubit.dart` has unused fields and an unreferenced method, so it looks like an unfinished refactor. Before claiming a change broke something, compare against this baseline (`git stash -u -- lib test`, run, unstash). `flutter analyze` likewise reports **7 pre-existing issues** (5 in `auth_cubit.dart`, 1 in `dev_logger.dart`, 1 deprecation in `routines_page.dart`).

## Architecture

Clean Architecture, three layers under each of `lib/features/{workout,auth,settings}/`: `domain/` (Freezed entities, repository contracts, use cases), `data/` (Drift database, DTOs, repository impls, sync engine), `presentation/` (Cubits + pages). `lib/core/` holds cross-cutting concerns; `get_it` wires everything in `core/di/injection_container.dart`.

The workout feature is by far the largest and is where almost all work lands.

### Offline-first sync

Local writes are the source of truth. Every mutation writes to Drift **and** enqueues a row in `outbox_changes`; `WorkoutSyncEngine` drains the outbox to Firestore and pulls remote changes back, resolving conflicts through `SyncConflictPolicy` (last-write-wins on `updatedAt`, with tombstones via `deletedAt`). Sync is debounced ~700 ms after a mutation.

Consequence: adding a field to a synced entity means touching **five** places — the Drift table, the domain entity, the repository mapping *and* its outbox payload, the `*RemoteDto`, and the sync engine's insert/update companions. Missing one fails silently at runtime rather than at compile time.

### Database migrations

`AppConstants.databaseVersion` is the schema version (currently **6**); `AppDatabase.migration` in `workout_database.dart` holds the `onUpgrade` chain. Every schema change needs a bump, a `_migrateVxToVy` step, and a test in `test/features/workout/data/drift_sync_migration_test.dart` — that file builds an old schema with raw SQL, opens `AppDatabase` over it and asserts the result. Migration steps must be **idempotent**: a database arriving from v1 runs every step in sequence, and a step that blindly `ALTER TABLE ... ADD COLUMN`s a column an earlier step already created will throw and leave the app unable to open its database.

`migration` also has a `beforeOpen` hook that runs `refreshSeededExerciseTranslations()` on every launch (see below).

## Localization

The app ships in **13 languages**: en, es, pt, de, fr, it, tr, ru, pl, nl, id, vi, hi. Two separate systems, both keyed off the same idea — store a language-independent identity, resolve the display text at render time.

### UI strings

Standard Flutter ARB in `lib/l10n/app_<code>.arb`. `app_en.arb` is the template and the only file carrying `@key` metadata. Reached in widgets via `context.l10n.<key>` (`core/utils/l10n_extension.dart`).

Which locales exist is derived from the ARB files — `AppLocalizations.supportedLocales` — and `SupportedLanguages` (`core/l10n/supported_languages.dart`) wraps that with each language's own native name. `main.dart` and the settings picker read from it, so neither needs editing when a language is added.

**Plurals**: `setsCount` and `progressSessionsCount` are ICU plurals. Categories are per language and not negotiable — Russian and Polish need `one/few/many/other` (the cycle restarts at 21), Indonesian and Vietnamese take only `other` because they do not inflect for number. `test/l10n/plural_forms_test.dart` asserts real runtime output for the edge cases.

### Exercise names

Exercise names are content, not UI strings, so they live outside the ARB files.

`ExerciseLibrary` (`core/constants/exercise_library.dart`) holds ~51 exercises as `(canonical English name, category)`. Translations live one file per language in `core/constants/exercise_names/`, keyed **by the canonical English name**, and registered in `exercise_name_translations.dart`. Keys must match byte-for-byte; a missing key is legal and falls back to English, so a language can ship partly translated.

`LocalizedText` (`core/l10n/localized_text.dart`) is the value type: a `Map<languageCode, text>` with a fallback chain (exact locale → base language, so `pt_BR` hits `pt` → English → any translation → empty). It is stored as JSON in `library_exercises.names_json` and as a `names` map in Firestore.

### The two naming rules that are easy to get wrong

**Library exercises** carry every translation. `refreshSeededExerciseTranslations()` runs at database open and merges the current catalog into rows seeded by earlier builds, which is how a newly shipped language reaches an existing install without a reinstall. It only fills in *missing* languages, so exercises the user renamed keep their own text.

**Routine exercises** (`exercises` table) store a `canonicalName` — the English catalog key, or `null` for an exercise the user typed in. The displayed text comes from `WorkoutExercise.displayName(languageCode)`, never from `.name`. Storing the link instead of the translated text is what lets a routine built in Spanish read correctly in German, and lets routines pick up languages added later. `ExerciseLibrary.canonicalNameFor(name)` recovers that link from a bare name in any language; it is used by the v5→v6 migration and by `ExerciseRemoteDto.fromFirestore` so older rows self-heal.

**When rendering any routine exercise name, use `displayName(...)`.** Using `.name` directly is the bug that leaves a routine stuck in the language it was created in.

### Adding a language

Three edits, documented in full in `docs/adding-a-language.md`: a translated `lib/l10n/app_<code>.arb`, the native name in `SupportedLanguages._nativeNames`, and a translation table in `core/constants/exercise_names/` registered in `exercise_name_translations.dart`. Then re-run `flutter gen-l10n`.

Guard rails already in place: `test/core/constants/exercise_translations_test.dart` fails the build if a translation key matches no exercise (otherwise that exercise silently stays English forever), and checks every exercise resolves non-empty in every registered language.

Watch string length — German runs ~30% longer than English and Russian ~20%. Spanish is the longest of the languages already shipping, so it is a useful worst-case reference for whether a new string will fit.

## Conventions

`analysis_options.yaml` extends `flutter_lints` and additionally requires trailing commas, `const` where possible, `final` locals and fields, declared return types, and constructors first.

Comments in this codebase explain **why**, not what — the non-obvious constraint, the bug a piece of code exists to prevent, the reason an approach was rejected. See the dedupe logic in `workout_repository_impl.dart` or the migration steps for the house style. (`README.md` claims a no-comments rule; the code has not followed that for a long time.)

`docs/` holds the published privacy policy and account-deletion pages (referenced from the Play Store listing) plus `adding-a-language.md`. `firebase/firestore.rules` holds the security rules.
