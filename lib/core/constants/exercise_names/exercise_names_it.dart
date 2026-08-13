/// Italian names for the seeded exercise catalog, keyed by the canonical
/// English name in `ExerciseLibrary`.
///
/// Italian gyms use the English term for a good number of movements (panca
/// piana is translated, but lat machine, curl, dips, plank and crunch are said
/// as they are), so those are kept rather than forced into Italian.
///
/// A missing key is not an error: the exercise falls back to its English name.
const Map<String, String> exerciseNamesIt = <String, String>{
  // Chest
  'Bench Press': 'Panca Piana',
  'Incline Bench Press': 'Panca Inclinata',
  'Decline Bench Press': 'Panca Declinata',
  'Dumbbell Fly': 'Croci con Manubri',
  'Push-ups': 'Piegamenti sulle Braccia',
  'Chest Dips': 'Dips alle Parallele',

  // Back
  'Pull-up': 'Trazioni alla Sbarra',
  'Chin-up': 'Trazioni Presa Supina',
  'Barbell Row': 'Rematore con Bilanciere',
  'Dumbbell Row': 'Rematore con Manubrio',
  'Lat Pulldown': 'Lat Machine',
  'Deadlift': 'Stacco da Terra',
  'T-Bar Row': 'Rematore a T',

  // Shoulders
  'Overhead Press': 'Lento Avanti',
  'Lateral Raise': 'Alzate Laterali',
  'Front Raise': 'Alzate Frontali',
  'Rear Delt Fly': 'Alzate Posteriori',
  'Arnold Press': 'Arnold Press',
  'Shrugs': 'Scrollate',

  // Arms
  'Barbell Curl': 'Curl con Bilanciere',
  'Dumbbell Curl': 'Curl con Manubri',
  'Hammer Curl': 'Curl a Martello',
  'Preacher Curl': 'Curl su Panca Scott',
  'Triceps Pushdown': 'Push Down ai Cavi',
  'Overhead Triceps Extension': 'Estensioni Tricipiti sopra la Testa',
  'Triceps Dips': 'Dips per Tricipiti',
  'Close-Grip Bench Press': 'Panca Piana Presa Stretta',

  // Legs
  'Squat': 'Squat',
  'Front Squat': 'Front Squat',
  'Leg Press': 'Leg Press',
  'Leg Extension': 'Leg Extension',
  'Leg Curl': 'Leg Curl',
  'Romanian Deadlift': 'Stacco Rumeno',
  'Lunges': 'Affondi',
  'Bulgarian Split Squat': 'Squat Bulgaro',
  'Calf Raise': 'Calf Raise',
  'Hip Thrust': 'Hip Thrust',

  // Core
  'Plank': 'Plank',
  'Crunches': 'Crunch',
  'Russian Twist': 'Russian Twist',
  'Leg Raise': 'Sollevamento Gambe',
  'Mountain Climbers': 'Mountain Climber',
  'Bicycle Crunches': 'Crunch Bicicletta',

  // Cardio
  'Running': 'Corsa',
  'Cycling': 'Ciclismo',
  'Rowing': 'Vogatore',
  'Jump Rope': 'Salto con la Corda',

  // Full body
  'Burpees': 'Burpees',
  'Thrusters': 'Thruster',
  'Clean and Jerk': 'Slancio',
  'Snatch': 'Strappo',
};
