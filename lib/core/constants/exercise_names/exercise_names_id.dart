/// Indonesian names for the seeded exercise catalog, keyed by the canonical
/// English name in `ExerciseLibrary`.
///
/// Indonesian gyms use the English name for most weight-room movements (bench
/// press, deadlift, squat, curl, plank), so the pattern here is the English
/// term with an Indonesian qualifier where one is needed, rather than a full
/// translation nobody uses.
///
/// A missing key is not an error: the exercise falls back to its English name.
const Map<String, String> exerciseNamesId = <String, String>{
  // Chest
  'Bench Press': 'Bench Press',
  'Incline Bench Press': 'Bench Press Miring Atas',
  'Decline Bench Press': 'Bench Press Miring Bawah',
  'Dumbbell Fly': 'Dumbbell Fly',
  'Push-ups': 'Push-up',
  'Chest Dips': 'Dip untuk Dada',
  'Machine Chest Press': 'Chest Press Mesin',
  'Cable Crossover': 'Cable Crossover',
  'Pec Deck': 'Pec Deck',

  // Back
  'Pull-up': 'Pull-up',
  'Chin-up': 'Chin-up',
  'Barbell Row': 'Barbell Row',
  'Dumbbell Row': 'Dumbbell Row',
  'Lat Pulldown': 'Lat Pulldown',
  'Deadlift': 'Deadlift',
  'T-Bar Row': 'T-Bar Row',
  'Seated Cable Row': 'Seated Cable Row',
  'Chest-Supported Row': 'Row dengan Sandaran Dada',
  'Straight-Arm Pulldown': 'Straight-Arm Pulldown',
  'Inverted Row': 'Inverted Row',
  'Sumo Deadlift': 'Sumo Deadlift',

  // Shoulders
  'Overhead Press': 'Overhead Press',
  'Lateral Raise': 'Lateral Raise',
  'Front Raise': 'Front Raise',
  'Rear Delt Fly': 'Rear Delt Fly',
  'Arnold Press': 'Arnold Press',
  'Shrugs': 'Shrug Bahu',
  'Face Pull': 'Face Pull',
  'Machine Shoulder Press': 'Shoulder Press Mesin',
  'Cable Lateral Raise': 'Lateral Raise Cable',
  'Upright Row': 'Upright Row',

  // Arms
  'Barbell Curl': 'Barbell Curl',
  'Dumbbell Curl': 'Dumbbell Curl',
  'Hammer Curl': 'Hammer Curl',
  'Preacher Curl': 'Preacher Curl',
  'Triceps Pushdown': 'Triceps Pushdown',
  'Overhead Triceps Extension': 'Triceps Extension di Atas Kepala',
  'Triceps Dips': 'Dip untuk Trisep',
  'Close-Grip Bench Press': 'Bench Press Pegangan Sempit',
  'Cable Curl': 'Cable Curl',
  'Concentration Curl': 'Concentration Curl',
  'Skull Crusher': 'Skull Crusher',
  'Reverse Curl': 'Reverse Curl',
  'Wrist Curl': 'Wrist Curl',

  // Legs
  'Squat': 'Squat',
  'Front Squat': 'Front Squat',
  'Leg Press': 'Leg Press',
  'Leg Extension': 'Leg Extension',
  'Leg Curl': 'Leg Curl',
  'Romanian Deadlift': 'Romanian Deadlift',
  'Lunges': 'Lunge',
  'Bulgarian Split Squat': 'Bulgarian Split Squat',
  'Calf Raise': 'Calf Raise',
  'Hip Thrust': 'Hip Thrust',
  'Hack Squat': 'Hack Squat',
  'Goblet Squat': 'Goblet Squat',
  'Step-up': 'Step-up',
  'Good Morning': 'Good Morning',
  'Hip Abduction': 'Hip Abduction',
  'Hip Adduction': 'Hip Adduction',
  'Glute Kickback': 'Glute Kickback',

  // Core
  'Plank': 'Plank',
  'Crunches': 'Crunch',
  'Russian Twist': 'Russian Twist',
  'Leg Raise': 'Angkat Kaki',
  'Mountain Climbers': 'Mountain Climber',
  'Bicycle Crunches': 'Crunch Sepeda',
  'Cable Crunch': 'Cable Crunch',
  'Dead Bug': 'Dead Bug',
  'Side Plank': 'Plank Samping',
  'Hanging Leg Raise': 'Hanging Leg Raise',
  'Ab Wheel Rollout': 'Ab Wheel',
  'Sit-ups': 'Sit-up',
  'Bird Dog': 'Bird Dog',

  // Cardio
  'Running': 'Lari',
  'Cycling': 'Bersepeda',
  'Rowing': 'Mesin Dayung',
  'Jump Rope': 'Lompat Tali',
  'Walking': 'Jalan Kaki',
  'Elliptical': 'Mesin Elliptical',
  'Stair Climber': 'Stair Climber',
  'Swimming': 'Berenang',

  // Full body
  'Burpees': 'Burpee',
  'Thrusters': 'Thruster',
  'Clean and Jerk': 'Clean and Jerk',
  'Snatch': 'Snatch',
  'Kettlebell Swing': 'Kettlebell Swing',
  'Farmer\'s Walk': 'Farmer\'s Walk',
  'Box Jump': 'Box Jump',
  'Battle Ropes': 'Battle Rope',
};
