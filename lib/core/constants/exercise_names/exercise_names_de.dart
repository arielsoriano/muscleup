/// German names for the seeded exercise catalog, keyed by the canonical English
/// name in `ExerciseLibrary`.
///
/// German gyms keep the English term for several movements (Bench Press, Lat
/// Pulldown, Hip Thrust, Crunches), so those are left as they are rather than
/// translated into words nobody says on the gym floor.
///
/// A missing key is not an error: the exercise falls back to its English name.
const Map<String, String> exerciseNamesDe = <String, String>{
  // Chest
  'Bench Press': 'Bankdrücken',
  'Incline Bench Press': 'Schrägbankdrücken',
  'Decline Bench Press': 'Negativbankdrücken',
  'Dumbbell Fly': 'Kurzhantel-Fliegende',
  'Push-ups': 'Liegestütze',
  'Chest Dips': 'Dips für die Brust',
  'Machine Chest Press': 'Brustpresse an der Maschine',
  'Cable Crossover': 'Kabelkreuzen',
  'Pec Deck': 'Butterfly',

  // Back
  'Pull-up': 'Klimmzug',
  'Chin-up': 'Klimmzug im Untergriff',
  'Barbell Row': 'Langhantelrudern',
  'Dumbbell Row': 'Kurzhantelrudern',
  'Lat Pulldown': 'Latzug',
  'Deadlift': 'Kreuzheben',
  'T-Bar Row': 'T-Bar-Rudern',
  'Seated Cable Row': 'Rudern am Kabel sitzend',
  'Chest-Supported Row': 'Rudern mit Brustauflage',
  'Straight-Arm Pulldown': 'Latzug mit gestreckten Armen',
  'Inverted Row': 'Umgekehrtes Rudern',
  'Sumo Deadlift': 'Sumo-Kreuzheben',

  // Shoulders
  'Overhead Press': 'Schulterdrücken',
  'Lateral Raise': 'Seitheben',
  'Front Raise': 'Frontheben',
  'Rear Delt Fly': 'Reverse Fliegende',
  'Arnold Press': 'Arnold-Press',
  'Shrugs': 'Schulterheben',
  'Face Pull': 'Face Pull',
  'Machine Shoulder Press': 'Schulterpresse an der Maschine',
  'Cable Lateral Raise': 'Seitheben am Kabel',
  'Upright Row': 'Aufrechtes Rudern',

  // Arms
  'Barbell Curl': 'Langhantel-Curl',
  'Dumbbell Curl': 'Kurzhantel-Curl',
  'Hammer Curl': 'Hammer-Curl',
  'Preacher Curl': 'Scott-Curl',
  'Triceps Pushdown': 'Trizepsdrücken am Kabel',
  'Overhead Triceps Extension': 'Trizepsdrücken über Kopf',
  'Triceps Dips': 'Dips für den Trizeps',
  'Close-Grip Bench Press': 'Enges Bankdrücken',
  'Cable Curl': 'Curl am Kabel',
  'Concentration Curl': 'Konzentrationscurl',
  'Skull Crusher': 'French Press',
  'Reverse Curl': 'Reverse Curl',
  'Wrist Curl': 'Handgelenk-Curl',

  // Legs
  'Squat': 'Kniebeuge',
  'Front Squat': 'Frontkniebeuge',
  'Leg Press': 'Beinpresse',
  'Leg Extension': 'Beinstrecker',
  'Leg Curl': 'Beinbeuger',
  'Romanian Deadlift': 'Rumänisches Kreuzheben',
  'Lunges': 'Ausfallschritte',
  'Bulgarian Split Squat': 'Bulgarische Kniebeuge',
  'Calf Raise': 'Wadenheben',
  'Hip Thrust': 'Hip Thrust',
  'Hack Squat': 'Hackenschmidt-Kniebeuge',
  'Goblet Squat': 'Goblet-Kniebeuge',
  'Step-up': 'Step-up',
  'Good Morning': 'Good Morning',
  'Hip Abduction': 'Abduktorenmaschine',
  'Hip Adduction': 'Adduktorenmaschine',
  'Glute Kickback': 'Gesäß-Kickback',

  // Core
  'Plank': 'Unterarmstütz',
  'Crunches': 'Crunches',
  'Russian Twist': 'Russian Twist',
  'Leg Raise': 'Beinheben',
  'Mountain Climbers': 'Mountain Climbers',
  'Bicycle Crunches': 'Fahrrad-Crunches',
  'Cable Crunch': 'Crunch am Kabel',
  'Dead Bug': 'Dead Bug',
  'Side Plank': 'Seitstütz',
  'Hanging Leg Raise': 'Hängendes Beinheben',
  'Ab Wheel Rollout': 'Bauchroller',
  'Sit-ups': 'Sit-ups',
  'Bird Dog': 'Bird Dog',

  // Cardio
  'Running': 'Laufen',
  'Cycling': 'Radfahren',
  'Rowing': 'Rudern',
  'Jump Rope': 'Seilspringen',
  'Walking': 'Gehen',
  'Elliptical': 'Crosstrainer',
  'Stair Climber': 'Stepper',
  'Swimming': 'Schwimmen',

  // Full body
  'Burpees': 'Burpees',
  'Thrusters': 'Thrusters',
  'Clean and Jerk': 'Umsetzen und Stoßen',
  'Snatch': 'Reißen',
  'Kettlebell Swing': 'Kettlebell-Swing',
  'Farmer\'s Walk': 'Farmer\'s Walk',
  'Box Jump': 'Box Jump',
  'Battle Ropes': 'Battle Ropes',
};
