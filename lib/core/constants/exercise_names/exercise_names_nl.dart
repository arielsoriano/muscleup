/// Dutch names for the seeded exercise catalog, keyed by the canonical English
/// name in `ExerciseLibrary`.
///
/// Dutch gyms use the English term for most barbell and machine work (bench
/// press, deadlift, squat, lat pulldown, curl), so those stay as they are said
/// on the gym floor rather than being forced into Dutch.
///
/// A missing key is not an error: the exercise falls back to its English name.
const Map<String, String> exerciseNamesNl = <String, String>{
  // Chest
  'Bench Press': 'Bankdrukken',
  'Incline Bench Press': 'Schuin bankdrukken',
  'Decline Bench Press': 'Aflopend bankdrukken',
  'Dumbbell Fly': 'Dumbbell fly',
  'Push-ups': 'Opdrukken',
  'Chest Dips': 'Dips voor de borst',
  'Machine Chest Press': 'Chest press machine',
  'Cable Crossover': 'Cable crossover',
  'Pec Deck': 'Pec deck',

  // Back
  'Pull-up': 'Optrekken bovenhands',
  'Chin-up': 'Optrekken onderhands',
  'Barbell Row': 'Roeien met barbell',
  'Dumbbell Row': 'Roeien met dumbbell',
  'Lat Pulldown': 'Lat pulldown',
  'Deadlift': 'Deadlift',
  'T-Bar Row': 'T-bar row',
  'Seated Cable Row': 'Zittend roeien aan kabel',
  'Chest-Supported Row': 'Roeien met bruststeun',
  'Straight-Arm Pulldown': 'Pulldown met gestrekte armen',
  'Inverted Row': 'Omgekeerd roeien',
  'Sumo Deadlift': 'Sumo deadlift',

  // Shoulders
  'Overhead Press': 'Schouderdrukken',
  'Lateral Raise': 'Zijwaartse heffing',
  'Front Raise': 'Voorwaartse heffing',
  'Rear Delt Fly': 'Reverse fly',
  'Arnold Press': 'Arnold press',
  'Shrugs': 'Shrugs',
  'Face Pull': 'Face pull',
  'Machine Shoulder Press': 'Shoulder press machine',
  'Cable Lateral Raise': 'Zijwaartse heffing aan kabel',
  'Upright Row': 'Rechtop roeien',

  // Arms
  'Barbell Curl': 'Barbell curl',
  'Dumbbell Curl': 'Dumbbell curl',
  'Hammer Curl': 'Hamer curl',
  'Preacher Curl': 'Preacher curl',
  'Triceps Pushdown': 'Triceps pushdown',
  'Overhead Triceps Extension': 'Triceps extensie boven het hoofd',
  'Triceps Dips': 'Dips voor de triceps',
  'Close-Grip Bench Press': 'Bankdrukken smalle greep',
  'Cable Curl': 'Cable curl',
  'Concentration Curl': 'Concentratiecurl',
  'Skull Crusher': 'Skull crusher',
  'Reverse Curl': 'Reverse curl',
  'Wrist Curl': 'Wrist curl',

  // Legs
  'Squat': 'Squat',
  'Front Squat': 'Front squat',
  'Leg Press': 'Beenpers',
  'Leg Extension': 'Leg extension',
  'Leg Curl': 'Leg curl',
  'Romanian Deadlift': 'Roemeense deadlift',
  'Lunges': 'Lunges',
  'Bulgarian Split Squat': 'Bulgaarse split squat',
  'Calf Raise': 'Kuitheffing',
  'Hip Thrust': 'Hip thrust',
  'Hack Squat': 'Hack squat',
  'Goblet Squat': 'Goblet squat',
  'Step-up': 'Step-up',
  'Good Morning': 'Good morning',
  'Hip Abduction': 'Abductiemachine',
  'Hip Adduction': 'Adductiemachine',
  'Glute Kickback': 'Glute kickback',

  // Core
  'Plank': 'Plank',
  'Crunches': 'Crunches',
  'Russian Twist': 'Russian twist',
  'Leg Raise': 'Beenheffen',
  'Mountain Climbers': 'Mountain climbers',
  'Bicycle Crunches': 'Fietscrunches',
  'Cable Crunch': 'Crunch aan kabel',
  'Dead Bug': 'Dead bug',
  'Side Plank': 'Zijplank',
  'Hanging Leg Raise': 'Hangend beenheffen',
  'Ab Wheel Rollout': 'Ab wheel rollout',
  'Sit-ups': 'Sit-ups',
  'Bird Dog': 'Bird dog',

  // Cardio
  'Running': 'Hardlopen',
  'Cycling': 'Fietsen',
  'Rowing': 'Roeien',
  'Jump Rope': 'Touwtjespringen',
  'Walking': 'Wandelen',
  'Elliptical': 'Crosstrainer',
  'Stair Climber': 'Stepper',
  'Swimming': 'Zwemmen',

  // Full body
  'Burpees': 'Burpees',
  'Thrusters': 'Thrusters',
  'Clean and Jerk': 'Stoten',
  'Snatch': 'Trekken',
  'Kettlebell Swing': 'Kettlebell swing',
  'Farmer\'s Walk': 'Farmer\'s walk',
  'Box Jump': 'Box jump',
  'Battle Ropes': 'Battle ropes',
};
