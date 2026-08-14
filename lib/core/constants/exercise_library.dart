import '../l10n/localized_text.dart';
import 'exercise_names/exercise_name_translations.dart';

/// The muscle group an exercise belongs to.
///
/// Persisted by index in the `library_exercises` table, so entries may be
/// appended but never reordered or removed.
enum ExerciseCategory {
  chest,
  back,
  shoulders,
  arms,
  legs,
  core,
  cardio,
  fullBody,
}

/// One exercise in the seeded catalog.
///
/// The English name is canonical: it identifies the exercise across the
/// translation tables and never changes, while [names] carries whatever
/// translations currently exist for it.
class ExerciseLibraryEntry {
  const ExerciseLibraryEntry({
    required this.canonicalName,
    required this.names,
    required this.category,
  });

  final String canonicalName;
  final LocalizedText names;
  final ExerciseCategory category;

  /// A stable identifier derived from the canonical name, so a seeded row keeps
  /// the same primary key across installs and languages.
  String get id => canonicalName.toLowerCase().replaceAll(' ', '_');

  String getLocalizedName(String languageCode) => names.resolve(languageCode);
}

class ExerciseLibrary {
  /// The catalog, as canonical English name paired with its category.
  ///
  /// Translations live in `exercise_names/`, not here — adding a language means
  /// adding a table there, never editing this list.
  static const List<(String, ExerciseCategory)> _catalog =
      <(String, ExerciseCategory)>[
    ('Bench Press', ExerciseCategory.chest),
    ('Incline Bench Press', ExerciseCategory.chest),
    ('Decline Bench Press', ExerciseCategory.chest),
    ('Dumbbell Fly', ExerciseCategory.chest),
    ('Push-ups', ExerciseCategory.chest),
    ('Chest Dips', ExerciseCategory.chest),
    ('Machine Chest Press', ExerciseCategory.chest),
    ('Cable Crossover', ExerciseCategory.chest),
    ('Pec Deck', ExerciseCategory.chest),
    ('Pull-up', ExerciseCategory.back),
    ('Chin-up', ExerciseCategory.back),
    ('Barbell Row', ExerciseCategory.back),
    ('Dumbbell Row', ExerciseCategory.back),
    ('Lat Pulldown', ExerciseCategory.back),
    ('Deadlift', ExerciseCategory.back),
    ('T-Bar Row', ExerciseCategory.back),
    ('Seated Cable Row', ExerciseCategory.back),
    ('Chest-Supported Row', ExerciseCategory.back),
    ('Straight-Arm Pulldown', ExerciseCategory.back),
    ('Inverted Row', ExerciseCategory.back),
    ('Sumo Deadlift', ExerciseCategory.back),
    ('Overhead Press', ExerciseCategory.shoulders),
    ('Lateral Raise', ExerciseCategory.shoulders),
    ('Front Raise', ExerciseCategory.shoulders),
    ('Rear Delt Fly', ExerciseCategory.shoulders),
    ('Arnold Press', ExerciseCategory.shoulders),
    ('Shrugs', ExerciseCategory.shoulders),
    ('Face Pull', ExerciseCategory.shoulders),
    ('Machine Shoulder Press', ExerciseCategory.shoulders),
    ('Cable Lateral Raise', ExerciseCategory.shoulders),
    ('Upright Row', ExerciseCategory.shoulders),
    ('Barbell Curl', ExerciseCategory.arms),
    ('Dumbbell Curl', ExerciseCategory.arms),
    ('Hammer Curl', ExerciseCategory.arms),
    ('Preacher Curl', ExerciseCategory.arms),
    ('Triceps Pushdown', ExerciseCategory.arms),
    ('Overhead Triceps Extension', ExerciseCategory.arms),
    ('Triceps Dips', ExerciseCategory.arms),
    ('Close-Grip Bench Press', ExerciseCategory.arms),
    ('Cable Curl', ExerciseCategory.arms),
    ('Concentration Curl', ExerciseCategory.arms),
    ('Skull Crusher', ExerciseCategory.arms),
    ('Reverse Curl', ExerciseCategory.arms),
    ('Wrist Curl', ExerciseCategory.arms),
    ('Squat', ExerciseCategory.legs),
    ('Front Squat', ExerciseCategory.legs),
    ('Leg Press', ExerciseCategory.legs),
    ('Leg Extension', ExerciseCategory.legs),
    ('Leg Curl', ExerciseCategory.legs),
    ('Romanian Deadlift', ExerciseCategory.legs),
    ('Lunges', ExerciseCategory.legs),
    ('Bulgarian Split Squat', ExerciseCategory.legs),
    ('Calf Raise', ExerciseCategory.legs),
    ('Hip Thrust', ExerciseCategory.legs),
    ('Hack Squat', ExerciseCategory.legs),
    ('Goblet Squat', ExerciseCategory.legs),
    ('Step-up', ExerciseCategory.legs),
    ('Good Morning', ExerciseCategory.legs),
    ('Hip Abduction', ExerciseCategory.legs),
    ('Hip Adduction', ExerciseCategory.legs),
    ('Glute Kickback', ExerciseCategory.legs),
    ('Plank', ExerciseCategory.core),
    ('Crunches', ExerciseCategory.core),
    ('Russian Twist', ExerciseCategory.core),
    ('Leg Raise', ExerciseCategory.core),
    ('Mountain Climbers', ExerciseCategory.core),
    ('Bicycle Crunches', ExerciseCategory.core),
    ('Cable Crunch', ExerciseCategory.core),
    ('Dead Bug', ExerciseCategory.core),
    ('Side Plank', ExerciseCategory.core),
    ('Hanging Leg Raise', ExerciseCategory.core),
    ('Ab Wheel Rollout', ExerciseCategory.core),
    ('Sit-ups', ExerciseCategory.core),
    ('Bird Dog', ExerciseCategory.core),
    ('Running', ExerciseCategory.cardio),
    ('Cycling', ExerciseCategory.cardio),
    ('Rowing', ExerciseCategory.cardio),
    ('Jump Rope', ExerciseCategory.cardio),
    ('Walking', ExerciseCategory.cardio),
    ('Elliptical', ExerciseCategory.cardio),
    ('Stair Climber', ExerciseCategory.cardio),
    ('Swimming', ExerciseCategory.cardio),
    ('Burpees', ExerciseCategory.fullBody),
    ('Thrusters', ExerciseCategory.fullBody),
    ('Clean and Jerk', ExerciseCategory.fullBody),
    ('Snatch', ExerciseCategory.fullBody),
    ('Kettlebell Swing', ExerciseCategory.fullBody),
    ("Farmer's Walk", ExerciseCategory.fullBody),
    ('Box Jump', ExerciseCategory.fullBody),
    ('Battle Ropes', ExerciseCategory.fullBody),
  ];

  /// The catalog with every available translation attached. Built once.
  static final List<ExerciseLibraryEntry> exercises = List<ExerciseLibraryEntry>.unmodifiable(
    _catalog.map(
      (entry) => ExerciseLibraryEntry(
        canonicalName: entry.$1,
        names: namesFor(entry.$1),
        category: entry.$2,
      ),
    ),
  );

  /// Maps every name the catalog is known by, in any language, to its
  /// canonical name. Built once.
  static final Map<String, String> _canonicalByAnyName = <String, String>{
    for (final entry in exercises)
      for (final name in entry.names.values)
        _normalize(name): entry.canonicalName,
  };

  /// The catalog entry a name belongs to, whatever language it is written in,
  /// or null when the name is not in the catalog at all.
  ///
  /// This is how a name that was stored as plain text — a routine exercise
  /// added before the app knew about translations — is recognised as a catalog
  /// exercise and re-rendered in the reader's language.
  static String? canonicalNameFor(String name) {
    return _canonicalByAnyName[_normalize(name)];
  }

  /// Indexed rather than scanned: every routine exercise resolves its display
  /// name through here on each rebuild, and the catalog is long enough now that
  /// a linear scan per name would be doing real work for nothing.
  static final Map<String, ExerciseLibraryEntry> _byCanonicalName = {
    for (final entry in exercises) entry.canonicalName: entry,
  };

  static ExerciseLibraryEntry? entryFor(String canonicalName) {
    return _byCanonicalName[canonicalName];
  }

  static String _normalize(String value) => value.trim().toLowerCase();

  /// Collects every translation of [canonicalName] into one [LocalizedText].
  /// A language with no entry for this exercise simply contributes nothing, and
  /// the name resolves to English there.
  static LocalizedText namesFor(String canonicalName) {
    final names = <String, String>{
      LocalizedText.baseLanguageCode: canonicalName,
    };

    for (final table in exerciseNameTranslations.entries) {
      final translated = table.value[canonicalName];
      if (translated != null && translated.trim().isNotEmpty) {
        names[table.key] = translated.trim();
      }
    }

    return LocalizedText(names);
  }

  static List<ExerciseLibraryEntry> searchExercises(
    String query,
    String languageCode,
  ) {
    if (query.isEmpty) return exercises;

    final lowerQuery = query.toLowerCase();
    return exercises.where((exercise) {
      final searchName = exercise.getLocalizedName(languageCode).toLowerCase();
      return searchName.contains(lowerQuery);
    }).toList();
  }
}
