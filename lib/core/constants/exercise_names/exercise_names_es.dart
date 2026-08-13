/// Spanish names for the seeded exercise catalog, keyed by the canonical
/// English name in `ExerciseLibrary`.
///
/// A missing key is not an error: the exercise falls back to its English name.
/// That lets a language ship partially translated and be completed later.
const Map<String, String> exerciseNamesEs = <String, String>{
  // Chest
  'Bench Press': 'Press de Banca',
  'Incline Bench Press': 'Press Inclinado',
  'Decline Bench Press': 'Press Declinado',
  'Dumbbell Fly': 'Aperturas con Mancuernas',
  'Push-ups': 'Flexiones',
  'Chest Dips': 'Fondos en Paralelas',

  // Back
  'Pull-up': 'Dominadas',
  'Chin-up': 'Dominadas Supinas',
  'Barbell Row': 'Remo con Barra',
  'Dumbbell Row': 'Remo con Mancuerna',
  'Lat Pulldown': 'Jalón al Pecho',
  'Deadlift': 'Peso Muerto',
  'T-Bar Row': 'Remo en T',

  // Shoulders
  'Overhead Press': 'Press Militar',
  'Lateral Raise': 'Elevaciones Laterales',
  'Front Raise': 'Elevaciones Frontales',
  'Rear Delt Fly': 'Aperturas Posteriores',
  'Arnold Press': 'Press Arnold',
  'Shrugs': 'Encogimientos',

  // Arms
  'Barbell Curl': 'Curl con Barra',
  'Dumbbell Curl': 'Curl con Mancuerna',
  'Hammer Curl': 'Curl Martillo',
  'Preacher Curl': 'Curl en Banco Scott',
  'Triceps Pushdown': 'Extensión de Tríceps en Polea',
  'Overhead Triceps Extension': 'Extensión de Tríceps sobre Cabeza',
  'Triceps Dips': 'Fondos de Tríceps',
  'Close-Grip Bench Press': 'Press Cerrado',

  // Legs
  'Squat': 'Sentadilla',
  'Front Squat': 'Sentadilla Frontal',
  'Leg Press': 'Prensa de Piernas',
  'Leg Extension': 'Extensión de Cuádriceps',
  'Leg Curl': 'Curl Femoral',
  'Romanian Deadlift': 'Peso Muerto Rumano',
  'Lunges': 'Zancadas',
  'Bulgarian Split Squat': 'Sentadilla Búlgara',
  'Calf Raise': 'Elevación de Talones',
  'Hip Thrust': 'Empuje de Cadera',

  // Core
  'Plank': 'Plancha',
  'Crunches': 'Abdominales',
  'Russian Twist': 'Giro Ruso',
  'Leg Raise': 'Elevación de Piernas',
  'Mountain Climbers': 'Escaladores',
  'Bicycle Crunches': 'Abdominales Bicicleta',

  // Cardio
  'Running': 'Correr',
  'Cycling': 'Ciclismo',
  'Rowing': 'Remo',
  'Jump Rope': 'Saltar la Cuerda',

  // Full body
  'Burpees': 'Burpees',
  'Thrusters': 'Thrusters',
  'Clean and Jerk': 'Cargada y Envión',
  'Snatch': 'Arrancada',
};
