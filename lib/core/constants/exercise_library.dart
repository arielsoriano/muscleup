class ExerciseLibraryEntry {
  const ExerciseLibraryEntry({
    required this.nameEn,
    required this.nameEs,
    required this.category,
  });

  final String nameEn;
  final String nameEs;
  final ExerciseCategory category;

  String getLocalizedName(String languageCode) {
    return languageCode == 'es' ? nameEs : nameEn;
  }
}

enum ExerciseCategory {
  chest,
  back,
  shoulders,
  arms,
  legs,
  core,
  cardio,
  fullBody,
}

class ExerciseLibrary {
  static const List<ExerciseLibraryEntry> exercises = [
    ExerciseLibraryEntry(
      nameEn: 'Bench Press',
      nameEs: 'Press de Banca',
      category: ExerciseCategory.chest,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Incline Bench Press',
      nameEs: 'Press Inclinado',
      category: ExerciseCategory.chest,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Decline Bench Press',
      nameEs: 'Press Declinado',
      category: ExerciseCategory.chest,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Dumbbell Fly',
      nameEs: 'Aperturas con Mancuernas',
      category: ExerciseCategory.chest,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Push-ups',
      nameEs: 'Flexiones',
      category: ExerciseCategory.chest,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Chest Dips',
      nameEs: 'Fondos en Paralelas',
      category: ExerciseCategory.chest,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Pull-up',
      nameEs: 'Dominadas',
      category: ExerciseCategory.back,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Chin-up',
      nameEs: 'Dominadas Supinas',
      category: ExerciseCategory.back,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Barbell Row',
      nameEs: 'Remo con Barra',
      category: ExerciseCategory.back,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Dumbbell Row',
      nameEs: 'Remo con Mancuerna',
      category: ExerciseCategory.back,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Lat Pulldown',
      nameEs: 'Jalón al Pecho',
      category: ExerciseCategory.back,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Deadlift',
      nameEs: 'Peso Muerto',
      category: ExerciseCategory.back,
    ),
    ExerciseLibraryEntry(
      nameEn: 'T-Bar Row',
      nameEs: 'Remo en T',
      category: ExerciseCategory.back,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Overhead Press',
      nameEs: 'Press Militar',
      category: ExerciseCategory.shoulders,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Lateral Raise',
      nameEs: 'Elevaciones Laterales',
      category: ExerciseCategory.shoulders,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Front Raise',
      nameEs: 'Elevaciones Frontales',
      category: ExerciseCategory.shoulders,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Rear Delt Fly',
      nameEs: 'Aperturas Posteriores',
      category: ExerciseCategory.shoulders,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Arnold Press',
      nameEs: 'Press Arnold',
      category: ExerciseCategory.shoulders,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Shrugs',
      nameEs: 'Encogimientos',
      category: ExerciseCategory.shoulders,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Barbell Curl',
      nameEs: 'Curl con Barra',
      category: ExerciseCategory.arms,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Dumbbell Curl',
      nameEs: 'Curl con Mancuerna',
      category: ExerciseCategory.arms,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Hammer Curl',
      nameEs: 'Curl Martillo',
      category: ExerciseCategory.arms,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Preacher Curl',
      nameEs: 'Curl en Banco Scott',
      category: ExerciseCategory.arms,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Triceps Pushdown',
      nameEs: 'Extensión de Tríceps en Polea',
      category: ExerciseCategory.arms,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Overhead Triceps Extension',
      nameEs: 'Extensión de Tríceps sobre Cabeza',
      category: ExerciseCategory.arms,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Triceps Dips',
      nameEs: 'Fondos de Tríceps',
      category: ExerciseCategory.arms,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Close-Grip Bench Press',
      nameEs: 'Press Cerrado',
      category: ExerciseCategory.arms,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Squat',
      nameEs: 'Sentadilla',
      category: ExerciseCategory.legs,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Front Squat',
      nameEs: 'Sentadilla Frontal',
      category: ExerciseCategory.legs,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Leg Press',
      nameEs: 'Prensa de Piernas',
      category: ExerciseCategory.legs,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Leg Extension',
      nameEs: 'Extensión de Cuádriceps',
      category: ExerciseCategory.legs,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Leg Curl',
      nameEs: 'Curl Femoral',
      category: ExerciseCategory.legs,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Romanian Deadlift',
      nameEs: 'Peso Muerto Rumano',
      category: ExerciseCategory.legs,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Lunges',
      nameEs: 'Zancadas',
      category: ExerciseCategory.legs,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Bulgarian Split Squat',
      nameEs: 'Sentadilla Búlgara',
      category: ExerciseCategory.legs,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Calf Raise',
      nameEs: 'Elevación de Talones',
      category: ExerciseCategory.legs,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Hip Thrust',
      nameEs: 'Empuje de Cadera',
      category: ExerciseCategory.legs,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Plank',
      nameEs: 'Plancha',
      category: ExerciseCategory.core,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Crunches',
      nameEs: 'Abdominales',
      category: ExerciseCategory.core,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Russian Twist',
      nameEs: 'Giro Ruso',
      category: ExerciseCategory.core,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Leg Raise',
      nameEs: 'Elevación de Piernas',
      category: ExerciseCategory.core,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Mountain Climbers',
      nameEs: 'Escaladores',
      category: ExerciseCategory.core,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Bicycle Crunches',
      nameEs: 'Abdominales Bicicleta',
      category: ExerciseCategory.core,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Running',
      nameEs: 'Correr',
      category: ExerciseCategory.cardio,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Cycling',
      nameEs: 'Ciclismo',
      category: ExerciseCategory.cardio,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Rowing',
      nameEs: 'Remo',
      category: ExerciseCategory.cardio,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Jump Rope',
      nameEs: 'Saltar la Cuerda',
      category: ExerciseCategory.cardio,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Burpees',
      nameEs: 'Burpees',
      category: ExerciseCategory.fullBody,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Thrusters',
      nameEs: 'Thrusters',
      category: ExerciseCategory.fullBody,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Clean and Jerk',
      nameEs: 'Cargada y Envión',
      category: ExerciseCategory.fullBody,
    ),
    ExerciseLibraryEntry(
      nameEn: 'Snatch',
      nameEs: 'Arrancada',
      category: ExerciseCategory.fullBody,
    ),
  ];

  static List<ExerciseLibraryEntry> searchExercises(
    String query,
    String languageCode,
  ) {
    if (query.isEmpty) return exercises;

    final lowerQuery = query.toLowerCase();
    return exercises.where((exercise) {
      final searchName = exercise.getLocalizedName(languageCode).toLowerCase();
      return searchName.contains(lowerQuery);
    }).toList();
  }
}
