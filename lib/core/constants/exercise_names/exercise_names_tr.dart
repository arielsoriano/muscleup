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
  'Machine Chest Press': 'Makinede Göğüs Press',
  'Cable Crossover': 'Cable Crossover',
  'Pec Deck': 'Pec Deck',

  // Back
  'Pull-up': 'Barfiks',
  'Chin-up': 'Ters Tutuş Barfiks',
  'Barbell Row': 'Barbell Kürek Çekişi',
  'Dumbbell Row': 'Dumbbell Kürek Çekişi',
  'Lat Pulldown': 'Lat Pulldown',
  'Deadlift': 'Deadlift',
  'T-Bar Row': 'T-Bar Kürek Çekişi',
  'Seated Cable Row': 'Oturarak Cable Row',
  'Chest-Supported Row': 'Göğüs Destekli Kürek Çekişi',
  'Straight-Arm Pulldown': 'Düz Kol Pulldown',
  'Inverted Row': 'Ters Kürek Çekişi',
  'Sumo Deadlift': 'Sumo Deadlift',

  // Shoulders
  'Overhead Press': 'Omuz Press',
  'Lateral Raise': 'Yan Omuz Kaldırış',
  'Front Raise': 'Ön Omuz Kaldırış',
  'Rear Delt Fly': 'Arka Omuz Fly',
  'Arnold Press': 'Arnold Press',
  'Shrugs': 'Trapez Silkme',
  'Face Pull': 'Face Pull',
  'Machine Shoulder Press': 'Makinede Omuz Press',
  'Cable Lateral Raise': 'Cable Yan Omuz Kaldırış',
  'Upright Row': 'Dikey Kürek Çekişi',

  // Arms
  'Barbell Curl': 'Barbell Curl',
  'Dumbbell Curl': 'Dumbbell Curl',
  'Hammer Curl': 'Çekiç Curl',
  'Preacher Curl': 'Scott Curl',
  'Triceps Pushdown': 'Triceps Pushdown',
  'Overhead Triceps Extension': 'Baş Üstü Triceps Açışı',
  'Triceps Dips': 'Triceps için Dips',
  'Close-Grip Bench Press': 'Dar Tutuş Bench Press',
  'Cable Curl': 'Cable Curl',
  'Concentration Curl': 'Konsantre Curl',
  'Skull Crusher': 'Skull Crusher',
  'Reverse Curl': 'Ters Curl',
  'Wrist Curl': 'El Bileği Curl',

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
  'Hack Squat': 'Hack Squat',
  'Goblet Squat': 'Goblet Squat',
  'Step-up': 'Step-up',
  'Good Morning': 'Good Morning',
  'Hip Abduction': 'Makinede Kalça Açma',
  'Hip Adduction': 'Makinede Kalça Kapama',
  'Glute Kickback': 'Kalça Kickback',

  // Core
  'Plank': 'Plank',
  'Crunches': 'Mekik',
  'Russian Twist': 'Russian Twist',
  'Leg Raise': 'Bacak Kaldırış',
  'Mountain Climbers': 'Mountain Climber',
  'Bicycle Crunches': 'Bisiklet Mekiği',
  'Cable Crunch': 'Cable Mekik',
  'Dead Bug': 'Dead Bug',
  'Side Plank': 'Yan Plank',
  'Hanging Leg Raise': 'Barfikste Bacak Kaldırış',
  'Ab Wheel Rollout': 'Karın Tekerleği',
  'Sit-ups': 'Tam Mekik',
  'Bird Dog': 'Bird Dog',

  // Cardio
  'Running': 'Koşu',
  'Cycling': 'Bisiklet',
  'Rowing': 'Kürek Çekme',
  'Jump Rope': 'İp Atlama',
  'Walking': 'Yürüyüş',
  'Elliptical': 'Eliptik Bisiklet',
  'Stair Climber': 'Merdiven Tırmanma',
  'Swimming': 'Yüzme',

  // Full body
  'Burpees': 'Burpee',
  'Thrusters': 'Thruster',
  'Clean and Jerk': 'Silkme',
  'Snatch': 'Koparma',
  'Kettlebell Swing': 'Kettlebell Swing',
  'Farmer\'s Walk': 'Çiftçi Yürüyüşü',
  'Box Jump': 'Kutu Sıçraması',
  'Battle Ropes': 'Battle Rope',
};
