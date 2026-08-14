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
  'Machine Chest Press': 'मशीन चेस्ट प्रेस',
  'Cable Crossover': 'केबल क्रॉसओवर',
  'Pec Deck': 'पेक डेक',

  // Back
  'Pull-up': 'पुल-अप',
  'Chin-up': 'चिन-अप',
  'Barbell Row': 'बारबेल रो',
  'Dumbbell Row': 'डम्बल रो',
  'Lat Pulldown': 'लैट पुलडाउन',
  'Deadlift': 'डेडलिफ्ट',
  'T-Bar Row': 'टी-बार रो',
  'Seated Cable Row': 'सीटेड केबल रो',
  'Chest-Supported Row': 'चेस्ट-सपोर्टेड रो',
  'Straight-Arm Pulldown': 'स्ट्रेट-आर्म पुलडाउन',
  'Inverted Row': 'इनवर्टेड रो',
  'Sumo Deadlift': 'सूमो डेडलिफ्ट',

  // Shoulders
  'Overhead Press': 'ओवरहेड प्रेस',
  'Lateral Raise': 'लैटरल रेज़',
  'Front Raise': 'फ्रंट रेज़',
  'Rear Delt Fly': 'रियर डेल्ट फ्लाई',
  'Arnold Press': 'अर्नोल्ड प्रेस',
  'Shrugs': 'श्रग्स',
  'Face Pull': 'फेस पुल',
  'Machine Shoulder Press': 'मशीन शोल्डर प्रेस',
  'Cable Lateral Raise': 'केबल लैटरल रेज़',
  'Upright Row': 'अपराइट रो',

  // Arms
  'Barbell Curl': 'बारबेल कर्ल',
  'Dumbbell Curl': 'डम्बल कर्ल',
  'Hammer Curl': 'हैमर कर्ल',
  'Preacher Curl': 'प्रीचर कर्ल',
  'Triceps Pushdown': 'ट्राइसेप्स पुशडाउन',
  'Overhead Triceps Extension': 'ओवरहेड ट्राइसेप्स एक्सटेंशन',
  'Triceps Dips': 'ट्राइसेप्स डिप्स',
  'Close-Grip Bench Press': 'क्लोज़-ग्रिप बेंच प्रेस',
  'Cable Curl': 'केबल कर्ल',
  'Concentration Curl': 'कंसन्ट्रेशन कर्ल',
  'Skull Crusher': 'स्कल क्रशर',
  'Reverse Curl': 'रिवर्स कर्ल',
  'Wrist Curl': 'रिस्ट कर्ल',

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
  'Hack Squat': 'हैक स्क्वाट',
  'Goblet Squat': 'गॉब्लेट स्क्वाट',
  'Step-up': 'स्टेप-अप',
  'Good Morning': 'गुड मॉर्निंग',
  'Hip Abduction': 'हिप एबडक्शन',
  'Hip Adduction': 'हिप एडक्शन',
  'Glute Kickback': 'ग्लूट किकबैक',

  // Core
  'Plank': 'प्लैंक',
  'Crunches': 'क्रंचेस',
  'Russian Twist': 'रशियन ट्विस्ट',
  'Leg Raise': 'लेग रेज़',
  'Mountain Climbers': 'माउंटेन क्लाइंबर',
  'Bicycle Crunches': 'साइकिल क्रंचेस',
  'Cable Crunch': 'केबल क्रंच',
  'Dead Bug': 'डेड बग',
  'Side Plank': 'साइड प्लैंक',
  'Hanging Leg Raise': 'हैंगिंग लेग रेज़',
  'Ab Wheel Rollout': 'एब व्हील रोलआउट',
  'Sit-ups': 'सिट-अप',
  'Bird Dog': 'बर्ड डॉग',

  // Cardio
  'Running': 'दौड़ना',
  'Cycling': 'साइकिलिंग',
  'Rowing': 'रोइंग मशीन',
  'Jump Rope': 'रस्सी कूद',
  'Walking': 'पैदल चलना',
  'Elliptical': 'एलिप्टिकल',
  'Stair Climber': 'स्टेयर क्लाइंबर',
  'Swimming': 'तैराकी',

  // Full body
  'Burpees': 'बर्पी',
  'Thrusters': 'थ्रस्टर',
  'Clean and Jerk': 'क्लीन एंड जर्क',
  'Snatch': 'स्नैच',
  'Kettlebell Swing': 'केटलबेल स्विंग',
  'Farmer\'s Walk': 'फार्मर्स वॉक',
  'Box Jump': 'बॉक्स जंप',
  'Battle Ropes': 'बैटल रोप्स',
};
