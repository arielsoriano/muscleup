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

  // Back
  'Pull-up': 'Klimmzug',
  'Chin-up': 'Klimmzug im Untergriff',
  'Barbell Row': 'Langhantelrudern',
  'Dumbbell Row': 'Kurzhantelrudern',
  'Lat Pulldown': 'Latzug',
  'Deadlift': 'Kreuzheben',
  'T-Bar Row': 'T-Bar-Rudern',

  // Shoulders
  'Overhead Press': 'Schulterdrücken',
  'Lateral Raise': 'Seitheben',
  'Front Raise': 'Frontheben',
  'Rear Delt Fly': 'Reverse Fliegende',
  'Arnold Press': 'Arnold-Press',
  'Shrugs': 'Schulterheben',

  // Arms
  'Barbell Curl': 'Langhantel-Curl',
  'Dumbbell Curl': 'Kurzhantel-Curl',
  'Hammer Curl': 'Hammer-Curl',
  'Preacher Curl': 'Scott-Curl',
  'Triceps Pushdown': 'Trizepsdrücken am Kabel',
  'Overhead Triceps Extension': 'Trizepsdrücken über Kopf',
  'Triceps Dips': 'Dips für den Trizeps',
  'Close-Grip Bench Press': 'Enges Bankdrücken',

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

  // Core
  'Plank': 'Unterarmstütz',
  'Crunches': 'Crunches',
  'Russian Twist': 'Russian Twist',
  'Leg Raise': 'Beinheben',
  'Mountain Climbers': 'Mountain Climbers',
  'Bicycle Crunches': 'Fahrrad-Crunches',

  // Cardio
  'Running': 'Laufen',
  'Cycling': 'Radfahren',
  'Rowing': 'Rudern',
  'Jump Rope': 'Seilspringen',

  // Full body
  'Burpees': 'Burpees',
  'Thrusters': 'Thrusters',
  'Clean and Jerk': 'Umsetzen und Stoßen',
  'Snatch': 'Reißen',
};
