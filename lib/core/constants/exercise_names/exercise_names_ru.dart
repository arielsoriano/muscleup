/// Russian names for the seeded exercise catalog, keyed by the canonical
/// English name in `ExerciseLibrary`.
///
/// A missing key is not an error: the exercise falls back to its English name.
const Map<String, String> exerciseNamesRu = <String, String>{
  // Chest
  'Bench Press': 'Жим лёжа',
  'Incline Bench Press': 'Жим лёжа на наклонной скамье',
  'Decline Bench Press': 'Жим лёжа головой вниз',
  'Dumbbell Fly': 'Разведение гантелей лёжа',
  'Push-ups': 'Отжимания',
  'Chest Dips': 'Отжимания на брусьях для груди',

  // Back
  'Pull-up': 'Подтягивания',
  'Chin-up': 'Подтягивания обратным хватом',
  'Barbell Row': 'Тяга штанги в наклоне',
  'Dumbbell Row': 'Тяга гантели в наклоне',
  'Lat Pulldown': 'Тяга верхнего блока',
  'Deadlift': 'Становая тяга',
  'T-Bar Row': 'Тяга Т-грифа',

  // Shoulders
  'Overhead Press': 'Жим стоя',
  'Lateral Raise': 'Махи гантелями в стороны',
  'Front Raise': 'Подъём гантелей перед собой',
  'Rear Delt Fly': 'Разведение на заднюю дельту',
  'Arnold Press': 'Жим Арнольда',
  'Shrugs': 'Шраги',

  // Arms
  'Barbell Curl': 'Подъём штанги на бицепс',
  'Dumbbell Curl': 'Подъём гантелей на бицепс',
  'Hammer Curl': 'Молотковый подъём',
  'Preacher Curl': 'Подъём на скамье Скотта',
  'Triceps Pushdown': 'Разгибание рук на блоке',
  'Overhead Triceps Extension': 'Разгибание рук из-за головы',
  'Triceps Dips': 'Отжимания на брусьях для трицепса',
  'Close-Grip Bench Press': 'Жим узким хватом',

  // Legs
  'Squat': 'Приседания',
  'Front Squat': 'Приседания со штангой на груди',
  'Leg Press': 'Жим ногами',
  'Leg Extension': 'Разгибание ног',
  'Leg Curl': 'Сгибание ног',
  'Romanian Deadlift': 'Румынская тяга',
  'Lunges': 'Выпады',
  'Bulgarian Split Squat': 'Болгарские выпады',
  'Calf Raise': 'Подъёмы на носки',
  'Hip Thrust': 'Ягодичный мост со штангой',

  // Core
  'Plank': 'Планка',
  'Crunches': 'Скручивания',
  'Russian Twist': 'Русский твист',
  'Leg Raise': 'Подъём ног',
  'Mountain Climbers': 'Скалолаз',
  'Bicycle Crunches': 'Скручивания «велосипед»',

  // Cardio
  'Running': 'Бег',
  'Cycling': 'Велотренажёр',
  'Rowing': 'Гребной тренажёр',
  'Jump Rope': 'Прыжки со скакалкой',

  // Full body
  'Burpees': 'Бёрпи',
  'Thrusters': 'Трастеры',
  'Clean and Jerk': 'Толчок',
  'Snatch': 'Рывок',
};
