/// Brazilian Portuguese names for the seeded exercise catalog, keyed by the
/// canonical English name in `ExerciseLibrary`.
///
/// A missing key is not an error: the exercise falls back to its English name.
const Map<String, String> exerciseNamesPt = <String, String>{
  // Chest
  'Bench Press': 'Supino Reto',
  'Incline Bench Press': 'Supino Inclinado',
  'Decline Bench Press': 'Supino Declinado',
  'Dumbbell Fly': 'Crucifixo com Halteres',
  'Push-ups': 'Flexão de Braço',
  'Chest Dips': 'Mergulho nas Paralelas',

  // Back
  'Pull-up': 'Barra Fixa',
  'Chin-up': 'Barra Fixa Supinada',
  'Barbell Row': 'Remada Curvada com Barra',
  'Dumbbell Row': 'Remada Unilateral com Halter',
  'Lat Pulldown': 'Puxada na Polia Alta',
  'Deadlift': 'Levantamento Terra',
  'T-Bar Row': 'Remada Cavalinho',

  // Shoulders
  'Overhead Press': 'Desenvolvimento Militar',
  'Lateral Raise': 'Elevação Lateral',
  'Front Raise': 'Elevação Frontal',
  'Rear Delt Fly': 'Crucifixo Inverso',
  'Arnold Press': 'Desenvolvimento Arnold',
  'Shrugs': 'Encolhimento de Ombros',

  // Arms
  'Barbell Curl': 'Rosca Direta com Barra',
  'Dumbbell Curl': 'Rosca Alternada com Halteres',
  'Hammer Curl': 'Rosca Martelo',
  'Preacher Curl': 'Rosca Scott',
  'Triceps Pushdown': 'Tríceps na Polia',
  'Overhead Triceps Extension': 'Tríceps Testa Acima da Cabeça',
  'Triceps Dips': 'Mergulho para Tríceps',
  'Close-Grip Bench Press': 'Supino Fechado',

  // Legs
  'Squat': 'Agachamento Livre',
  'Front Squat': 'Agachamento Frontal',
  'Leg Press': 'Leg Press',
  'Leg Extension': 'Cadeira Extensora',
  'Leg Curl': 'Mesa Flexora',
  'Romanian Deadlift': 'Levantamento Terra Romeno',
  'Lunges': 'Afundo',
  'Bulgarian Split Squat': 'Agachamento Búlgaro',
  'Calf Raise': 'Elevação de Panturrilha',
  'Hip Thrust': 'Elevação Pélvica',

  // Core
  'Plank': 'Prancha',
  'Crunches': 'Abdominal Supra',
  'Russian Twist': 'Rotação Russa',
  'Leg Raise': 'Elevação de Pernas',
  'Mountain Climbers': 'Escalador',
  'Bicycle Crunches': 'Abdominal Bicicleta',

  // Cardio
  'Running': 'Corrida',
  'Cycling': 'Ciclismo',
  'Rowing': 'Remo Ergométrico',
  'Jump Rope': 'Pular Corda',

  // Full body
  'Burpees': 'Burpees',
  'Thrusters': 'Thrusters',
  'Clean and Jerk': 'Arremesso',
  'Snatch': 'Arranco',
};
