/// French names for the seeded exercise catalog, keyed by the canonical English
/// name in `ExerciseLibrary`.
///
/// French gyms keep the English term for a number of movements (développé
/// couché is translated, but curl, dips, burpees and snatch are not), so those
/// stay as they are said on the gym floor.
///
/// A missing key is not an error: the exercise falls back to its English name.
const Map<String, String> exerciseNamesFr = <String, String>{
  // Chest
  'Bench Press': 'Développé couché',
  'Incline Bench Press': 'Développé incliné',
  'Decline Bench Press': 'Développé décliné',
  'Dumbbell Fly': 'Écarté avec haltères',
  'Push-ups': 'Pompes',
  'Chest Dips': 'Dips pectoraux',

  // Back
  'Pull-up': 'Traction pronation',
  'Chin-up': 'Traction supination',
  'Barbell Row': 'Rowing barre',
  'Dumbbell Row': 'Rowing haltère',
  'Lat Pulldown': 'Tirage vertical',
  'Deadlift': 'Soulevé de terre',
  'T-Bar Row': 'Rowing T-bar',

  // Shoulders
  'Overhead Press': 'Développé militaire',
  'Lateral Raise': 'Élévations latérales',
  'Front Raise': 'Élévations frontales',
  'Rear Delt Fly': 'Oiseau',
  'Arnold Press': 'Développé Arnold',
  'Shrugs': 'Haussements d\'épaules',

  // Arms
  'Barbell Curl': 'Curl barre',
  'Dumbbell Curl': 'Curl haltères',
  'Hammer Curl': 'Curl marteau',
  'Preacher Curl': 'Curl au pupitre',
  'Triceps Pushdown': 'Extension triceps à la poulie',
  'Overhead Triceps Extension': 'Extension triceps au-dessus de la tête',
  'Triceps Dips': 'Dips triceps',
  'Close-Grip Bench Press': 'Développé couché prise serrée',

  // Legs
  'Squat': 'Squat',
  'Front Squat': 'Squat avant',
  'Leg Press': 'Presse à cuisses',
  'Leg Extension': 'Leg extension',
  'Leg Curl': 'Leg curl',
  'Romanian Deadlift': 'Soulevé de terre roumain',
  'Lunges': 'Fentes',
  'Bulgarian Split Squat': 'Squat bulgare',
  'Calf Raise': 'Extension des mollets',
  'Hip Thrust': 'Hip thrust',

  // Core
  'Plank': 'Gainage',
  'Crunches': 'Crunchs',
  'Russian Twist': 'Russian twist',
  'Leg Raise': 'Relevé de jambes',
  'Mountain Climbers': 'Mountain climbers',
  'Bicycle Crunches': 'Crunchs bicyclette',

  // Cardio
  'Running': 'Course à pied',
  'Cycling': 'Vélo',
  'Rowing': 'Rameur',
  'Jump Rope': 'Corde à sauter',

  // Full body
  'Burpees': 'Burpees',
  'Thrusters': 'Thrusters',
  'Clean and Jerk': 'Épaulé-jeté',
  'Snatch': 'Arraché',
};
