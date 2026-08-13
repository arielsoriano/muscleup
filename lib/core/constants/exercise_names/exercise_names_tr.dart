/// Turkish names for the seeded exercise catalog, keyed by the canonical
/// English name in `ExerciseLibrary`.
///
/// Turkish gyms lean heavily on the English terms — press, curl, squat, lat,
/// plank, dips are all said as they are — so the pattern here is the English
/// movement name with a Turkish qualifier ("Dumbbell Curl" becomes "Dumbbell
/// Curl", "Barbell Row" becomes "Barbell ile Kürek Çekişi") rather than a full
/// translation nobody would say out loud.
///
/// A missing key is not an error: the exercise falls back to its English name.
const Map<String, String> exerciseNamesTr = <String, String>{
  // Chest
  'Bench Press': 'Bench Press',
  'Incline Bench Press': 'Eğimli Bench Press',
  'Decline Bench Press': 'Ters Eğimli Bench Press',
  'Dumbbell Fly': 'Dumbbell Fly',
  'Push-ups': 'Şınav',
  'Chest Dips': 'Göğüs için Dips',

  // Back
  'Pull-up': 'Barfiks',
  'Chin-up': 'Ters Tutuş Barfiks',
  'Barbell Row': 'Barbell Kürek Çekişi',
  'Dumbbell Row': 'Dumbbell Kürek Çekişi',
  'Lat Pulldown': 'Lat Pulldown',
  'Deadlift': 'Deadlift',
  'T-Bar Row': 'T-Bar Kürek Çekişi',

  // Shoulders
  'Overhead Press': 'Omuz Press',
  'Lateral Raise': 'Yan Omuz Kaldırış',
  'Front Raise': 'Ön Omuz Kaldırış',
  'Rear Delt Fly': 'Arka Omuz Fly',
  'Arnold Press': 'Arnold Press',
  'Shrugs': 'Trapez Silkme',

  // Arms
  'Barbell Curl': 'Barbell Curl',
  'Dumbbell Curl': 'Dumbbell Curl',
  'Hammer Curl': 'Çekiç Curl',
  'Preacher Curl': 'Scott Curl',
  'Triceps Pushdown': 'Triceps Pushdown',
  'Overhead Triceps Extension': 'Baş Üstü Triceps Açışı',
  'Triceps Dips': 'Triceps için Dips',
  'Close-Grip Bench Press': 'Dar Tutuş Bench Press',

  // Legs
  'Squat': 'Squat',
  'Front Squat': 'Ön Squat',
  'Leg Press': 'Leg Press',
  'Leg Extension': 'Leg Extension',
  'Leg Curl': 'Leg Curl',
  'Romanian Deadlift': 'Romen Deadlift',
  'Lunges': 'Lunge',
  'Bulgarian Split Squat': 'Bulgar Split Squat',
  'Calf Raise': 'Baldır Kaldırış',
  'Hip Thrust': 'Hip Thrust',

  // Core
  'Plank': 'Plank',
  'Crunches': 'Mekik',
  'Russian Twist': 'Russian Twist',
  'Leg Raise': 'Bacak Kaldırış',
  'Mountain Climbers': 'Mountain Climber',
  'Bicycle Crunches': 'Bisiklet Mekiği',

  // Cardio
  'Running': 'Koşu',
  'Cycling': 'Bisiklet',
  'Rowing': 'Kürek Çekme',
  'Jump Rope': 'İp Atlama',

  // Full body
  'Burpees': 'Burpee',
  'Thrusters': 'Thruster',
  'Clean and Jerk': 'Silkme',
  'Snatch': 'Koparma',
};
