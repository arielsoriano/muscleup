/// Polish names for the seeded exercise catalog, keyed by the canonical English
/// name in `ExerciseLibrary`.
///
/// A missing key is not an error: the exercise falls back to its English name.
const Map<String, String> exerciseNamesPl = <String, String>{
  // Chest
  'Bench Press': 'Wyciskanie leżąc',
  'Incline Bench Press': 'Wyciskanie na skosie dodatnim',
  'Decline Bench Press': 'Wyciskanie na skosie ujemnym',
  'Dumbbell Fly': 'Rozpiętki z hantlami',
  'Push-ups': 'Pompki',
  'Chest Dips': 'Dipy na poręczach',

  // Back
  'Pull-up': 'Podciąganie nachwytem',
  'Chin-up': 'Podciąganie podchwytem',
  'Barbell Row': 'Wiosłowanie sztangą',
  'Dumbbell Row': 'Wiosłowanie hantlem',
  'Lat Pulldown': 'Ściąganie drążka wyciągu górnego',
  'Deadlift': 'Martwy ciąg',
  'T-Bar Row': 'Wiosłowanie sztangą T',

  // Shoulders
  'Overhead Press': 'Wyciskanie żołnierskie',
  'Lateral Raise': 'Wznosy bokiem',
  'Front Raise': 'Wznosy przodem',
  'Rear Delt Fly': 'Odwrotne rozpiętki',
  'Arnold Press': 'Wyciskanie Arnolda',
  'Shrugs': 'Wzruszanie ramionami',

  // Arms
  'Barbell Curl': 'Uginanie ramion ze sztangą',
  'Dumbbell Curl': 'Uginanie ramion z hantlami',
  'Hammer Curl': 'Uginanie młotkowe',
  'Preacher Curl': 'Uginanie na modlitewniku',
  'Triceps Pushdown': 'Prostowanie ramion na wyciągu',
  'Overhead Triceps Extension': 'Wyciskanie francuskie zza głowy',
  'Triceps Dips': 'Dipy na triceps',
  'Close-Grip Bench Press': 'Wyciskanie wąskim uchwytem',

  // Legs
  'Squat': 'Przysiad ze sztangą',
  'Front Squat': 'Przysiad przedni',
  'Leg Press': 'Wyciskanie na suwnicy',
  'Leg Extension': 'Prostowanie nóg na maszynie',
  'Leg Curl': 'Uginanie nóg na maszynie',
  'Romanian Deadlift': 'Rumuński martwy ciąg',
  'Lunges': 'Wykroki',
  'Bulgarian Split Squat': 'Przysiad bułgarski',
  'Calf Raise': 'Wspięcia na palce',
  'Hip Thrust': 'Wypychanie bioder',

  // Core
  'Plank': 'Deska',
  'Crunches': 'Brzuszki',
  'Russian Twist': 'Rosyjski skręt',
  'Leg Raise': 'Unoszenie nóg',
  'Mountain Climbers': 'Wspinaczka górska',
  'Bicycle Crunches': 'Brzuszki rowerek',

  // Cardio
  'Running': 'Bieganie',
  'Cycling': 'Rower',
  'Rowing': 'Wioślarz',
  'Jump Rope': 'Skakanka',

  // Full body
  'Burpees': 'Burpees',
  'Thrusters': 'Thrustery',
  'Clean and Jerk': 'Podrzut',
  'Snatch': 'Rwanie',
};
