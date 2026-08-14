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
  'Machine Chest Press': 'Chest Press a Macchina',
  'Cable Crossover': 'Croci ai Cavi',
  'Pec Deck': 'Pectoral Machine',

  // Back
  'Pull-up': 'Trazioni alla Sbarra',
  'Chin-up': 'Trazioni Presa Supina',
  'Barbell Row': 'Rematore con Bilanciere',
  'Dumbbell Row': 'Rematore con Manubrio',
  'Lat Pulldown': 'Lat Machine',
  'Deadlift': 'Stacco da Terra',
  'T-Bar Row': 'Rematore a T',
  'Seated Cable Row': 'Pulley Basso',
  'Chest-Supported Row': 'Rematore con Appoggio al Petto',
  'Straight-Arm Pulldown': 'Pulldown a Braccia Tese',
  'Inverted Row': 'Rematore Inverso',
  'Sumo Deadlift': 'Stacco Sumo',

  // Shoulders
  'Overhead Press': 'Lento Avanti',
  'Lateral Raise': 'Alzate Laterali',
  'Front Raise': 'Alzate Frontali',
  'Rear Delt Fly': 'Alzate Posteriori',
  'Arnold Press': 'Arnold Press',
  'Shrugs': 'Scrollate',
  'Face Pull': 'Face Pull',
  'Machine Shoulder Press': 'Shoulder Press a Macchina',
  'Cable Lateral Raise': 'Alzate Laterali ai Cavi',
  'Upright Row': 'Rematore al Mento',

  // Arms
  'Barbell Curl': 'Curl con Bilanciere',
  'Dumbbell Curl': 'Curl con Manubri',
  'Hammer Curl': 'Curl a Martello',
  'Preacher Curl': 'Curl su Panca Scott',
  'Triceps Pushdown': 'Push Down ai Cavi',
  'Overhead Triceps Extension': 'Estensioni Tricipiti sopra la Testa',
  'Triceps Dips': 'Dips per Tricipiti',
  'Close-Grip Bench Press': 'Panca Piana Presa Stretta',
  'Cable Curl': 'Curl ai Cavi',
  'Concentration Curl': 'Curl Concentrato',
  'Skull Crusher': 'French Press',
  'Reverse Curl': 'Curl Inverso',
  'Wrist Curl': 'Curl per Polsi',

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
  'Hack Squat': 'Hack Squat',
  'Goblet Squat': 'Goblet Squat',
  'Step-up': 'Step-up',
  'Good Morning': 'Good Morning',
  'Hip Abduction': 'Abduttori a Macchina',
  'Hip Adduction': 'Adduttori a Macchina',
  'Glute Kickback': 'Slanci per i Glutei',

  // Core
  'Plank': 'Plank',
  'Crunches': 'Crunch',
  'Russian Twist': 'Russian Twist',
  'Leg Raise': 'Sollevamento Gambe',
  'Mountain Climbers': 'Mountain Climber',
  'Bicycle Crunches': 'Crunch Bicicletta',
  'Cable Crunch': 'Crunch ai Cavi',
  'Dead Bug': 'Dead Bug',
  'Side Plank': 'Plank Laterale',
  'Hanging Leg Raise': 'Sollevamento Gambe alla Sbarra',
  'Ab Wheel Rollout': 'Ruota per Addominali',
  'Sit-ups': 'Sit-up',
  'Bird Dog': 'Bird Dog',

  // Cardio
  'Running': 'Corsa',
  'Cycling': 'Ciclismo',
  'Rowing': 'Vogatore',
  'Jump Rope': 'Salto con la Corda',
  'Walking': 'Camminata',
  'Elliptical': 'Ellittica',
  'Stair Climber': 'Stair Climber',
  'Swimming': 'Nuoto',

  // Full body
  'Burpees': 'Burpees',
  'Thrusters': 'Thruster',
  'Clean and Jerk': 'Slancio',
  'Snatch': 'Strappo',
  'Kettlebell Swing': 'Swing con Kettlebell',
  'Farmer\'s Walk': 'Farmer\'s Walk',
  'Box Jump': 'Box Jump',
  'Battle Ropes': 'Battle Rope',
};
