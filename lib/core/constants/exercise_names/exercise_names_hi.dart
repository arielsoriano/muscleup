/// Hindi names for the seeded exercise catalog, keyed by the canonical English
/// name in `ExerciseLibrary`.
///
/// Indian gyms overwhelmingly use the English movement names, so these are
/// transliterated into Devanagari rather than translated into Sanskritised
/// terms nobody says on the gym floor. Where a common Hindi word genuinely
/// exists (दंड-बैठक style movements, दौड़ना, साइकिलिंग), it is used.
///
/// A missing key is not an error: the exercise falls back to its English name.
const Map<String, String> exerciseNamesHi = <String, String>{
  // Chest
  'Bench Press': 'बेंच प्रेस',
  'Incline Bench Press': 'इनक्लाइन बेंच प्रेस',
  'Decline Bench Press': 'डिक्लाइन बेंच प्रेस',
  'Dumbbell Fly': 'डम्बल फ्लाई',
  'Push-ups': 'पुश-अप',
  'Chest Dips': 'चेस्ट डिप्स',

  // Back
  'Pull-up': 'पुल-अप',
  'Chin-up': 'चिन-अप',
  'Barbell Row': 'बारबेल रो',
  'Dumbbell Row': 'डम्बल रो',
  'Lat Pulldown': 'लैट पुलडाउन',
  'Deadlift': 'डेडलिफ्ट',
  'T-Bar Row': 'टी-बार रो',

  // Shoulders
  'Overhead Press': 'ओवरहेड प्रेस',
  'Lateral Raise': 'लैटरल रेज़',
  'Front Raise': 'फ्रंट रेज़',
  'Rear Delt Fly': 'रियर डेल्ट फ्लाई',
  'Arnold Press': 'अर्नोल्ड प्रेस',
  'Shrugs': 'श्रग्स',

  // Arms
  'Barbell Curl': 'बारबेल कर्ल',
  'Dumbbell Curl': 'डम्बल कर्ल',
  'Hammer Curl': 'हैमर कर्ल',
  'Preacher Curl': 'प्रीचर कर्ल',
  'Triceps Pushdown': 'ट्राइसेप्स पुशडाउन',
  'Overhead Triceps Extension': 'ओवरहेड ट्राइसेप्स एक्सटेंशन',
  'Triceps Dips': 'ट्राइसेप्स डिप्स',
  'Close-Grip Bench Press': 'क्लोज़-ग्रिप बेंच प्रेस',

  // Legs
  'Squat': 'स्क्वाट',
  'Front Squat': 'फ्रंट स्क्वाट',
  'Leg Press': 'लेग प्रेस',
  'Leg Extension': 'लेग एक्सटेंशन',
  'Leg Curl': 'लेग कर्ल',
  'Romanian Deadlift': 'रोमानियन डेडलिफ्ट',
  'Lunges': 'लंजेस',
  'Bulgarian Split Squat': 'बल्गेरियन स्प्लिट स्क्वाट',
  'Calf Raise': 'काफ़ रेज़',
  'Hip Thrust': 'हिप थ्रस्ट',

  // Core
  'Plank': 'प्लैंक',
  'Crunches': 'क्रंचेस',
  'Russian Twist': 'रशियन ट्विस्ट',
  'Leg Raise': 'लेग रेज़',
  'Mountain Climbers': 'माउंटेन क्लाइंबर',
  'Bicycle Crunches': 'साइकिल क्रंचेस',

  // Cardio
  'Running': 'दौड़ना',
  'Cycling': 'साइकिलिंग',
  'Rowing': 'रोइंग मशीन',
  'Jump Rope': 'रस्सी कूद',

  // Full body
  'Burpees': 'बर्पी',
  'Thrusters': 'थ्रस्टर',
  'Clean and Jerk': 'क्लीन एंड जर्क',
  'Snatch': 'स्नैच',
};
