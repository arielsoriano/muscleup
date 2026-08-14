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
  'Machine Chest Press': 'Développé poitrine à la machine',
  'Cable Crossover': 'Écarté à la poulie',
  'Pec Deck': 'Pec deck',

  // Back
  'Pull-up': 'Traction pronation',
  'Chin-up': 'Traction supination',
  'Barbell Row': 'Rowing barre',
  'Dumbbell Row': 'Rowing haltère',
  'Lat Pulldown': 'Tirage vertical',
  'Deadlift': 'Soulevé de terre',
  'T-Bar Row': 'Rowing T-bar',
  'Seated Cable Row': 'Rowing à la poulie basse',
  'Chest-Supported Row': 'Rowing buste appuyé',
  'Straight-Arm Pulldown': 'Tirage bras tendus',
  'Inverted Row': 'Rowing inversé',
  'Sumo Deadlift': 'Soulevé de terre sumo',

  // Shoulders
  'Overhead Press': 'Développé militaire',
  'Lateral Raise': 'Élévations latérales',
  'Front Raise': 'Élévations frontales',
  'Rear Delt Fly': 'Oiseau',
  'Arnold Press': 'Développé Arnold',
  'Shrugs': 'Haussements d\'épaules',
  'Face Pull': 'Face pull',
  'Machine Shoulder Press': 'Développé épaules à la machine',
  'Cable Lateral Raise': 'Élévations latérales à la poulie',
  'Upright Row': 'Rowing menton',

  // Arms
  'Barbell Curl': 'Curl barre',
  'Dumbbell Curl': 'Curl haltères',
  'Hammer Curl': 'Curl marteau',
  'Preacher Curl': 'Curl au pupitre',
  'Triceps Pushdown': 'Extension triceps à la poulie',
  'Overhead Triceps Extension': 'Extension triceps au-dessus de la tête',
  'Triceps Dips': 'Dips triceps',
  'Close-Grip Bench Press': 'Développé couché prise serrée',
  'Cable Curl': 'Curl à la poulie',
  'Concentration Curl': 'Curl concentré',
  'Skull Crusher': 'Barre au front',
  'Reverse Curl': 'Curl inversé',
  'Wrist Curl': 'Curl poignet',

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
  'Hack Squat': 'Hack squat',
  'Goblet Squat': 'Goblet squat',
  'Step-up': 'Step-up',
  'Good Morning': 'Good morning',
  'Hip Abduction': 'Abduction de la hanche',
  'Hip Adduction': 'Adduction de la hanche',
  'Glute Kickback': 'Kickback fessier',

  // Core
  'Plank': 'Gainage',
  'Crunches': 'Crunchs',
  'Russian Twist': 'Russian twist',
  'Leg Raise': 'Relevé de jambes',
  'Mountain Climbers': 'Mountain climbers',
  'Bicycle Crunches': 'Crunchs bicyclette',
  'Cable Crunch': 'Crunch à la poulie',
  'Dead Bug': 'Dead bug',
  'Side Plank': 'Gainage latéral',
  'Hanging Leg Raise': 'Relevé de jambes suspendu',
  'Ab Wheel Rollout': 'Roulette abdominale',
  'Sit-ups': 'Redressements assis',
  'Bird Dog': 'Bird dog',

  // Cardio
  'Running': 'Course à pied',
  'Cycling': 'Vélo',
  'Rowing': 'Rameur',
  'Jump Rope': 'Corde à sauter',
  'Walking': 'Marche',
  'Elliptical': 'Vélo elliptique',
  'Stair Climber': 'Simulateur d\'escalier',
  'Swimming': 'Natation',

  // Full body
  'Burpees': 'Burpees',
  'Thrusters': 'Thrusters',
  'Clean and Jerk': 'Épaulé-jeté',
  'Snatch': 'Arraché',
  'Kettlebell Swing': 'Swing kettlebell',
  'Farmer\'s Walk': 'Marche du fermier',
  'Box Jump': 'Saut sur box',
  'Battle Ropes': 'Battle ropes',
};
