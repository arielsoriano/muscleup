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

  // Back
  'Pull-up': 'Pull-up',
  'Chin-up': 'Chin-up',
  'Barbell Row': 'Barbell Row',
  'Dumbbell Row': 'Dumbbell Row',
  'Lat Pulldown': 'Lat Pulldown',
  'Deadlift': 'Deadlift',
  'T-Bar Row': 'T-Bar Row',

  // Shoulders
  'Overhead Press': 'Overhead Press',
  'Lateral Raise': 'Lateral Raise',
  'Front Raise': 'Front Raise',
  'Rear Delt Fly': 'Rear Delt Fly',
  'Arnold Press': 'Arnold Press',
  'Shrugs': 'Shrug Bahu',

  // Arms
  'Barbell Curl': 'Barbell Curl',
  'Dumbbell Curl': 'Dumbbell Curl',
  'Hammer Curl': 'Hammer Curl',
  'Preacher Curl': 'Preacher Curl',
  'Triceps Pushdown': 'Triceps Pushdown',
  'Overhead Triceps Extension': 'Triceps Extension di Atas Kepala',
  'Triceps Dips': 'Dip untuk Trisep',
  'Close-Grip Bench Press': 'Bench Press Pegangan Sempit',

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

  // Core
  'Plank': 'Plank',
  'Crunches': 'Crunch',
  'Russian Twist': 'Russian Twist',
  'Leg Raise': 'Angkat Kaki',
  'Mountain Climbers': 'Mountain Climber',
  'Bicycle Crunches': 'Crunch Sepeda',

  // Cardio
  'Running': 'Lari',
  'Cycling': 'Bersepeda',
  'Rowing': 'Mesin Dayung',
  'Jump Rope': 'Lompat Tali',

  // Full body
  'Burpees': 'Burpee',
  'Thrusters': 'Thruster',
  'Clean and Jerk': 'Clean and Jerk',
  'Snatch': 'Snatch',
};
