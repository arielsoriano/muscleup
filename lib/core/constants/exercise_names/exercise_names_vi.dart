/// Vietnamese names for the seeded exercise catalog, keyed by the canonical
/// English name in `ExerciseLibrary`.
///
/// Vietnamese gyms keep the English name for most barbell, dumbbell and machine
/// work, so the pattern here is the English movement with a Vietnamese
/// qualifier where one clarifies the variation ("Incline Bench Press" becomes
/// "Bench Press Dốc Lên"), and a full Vietnamese name only where one is
/// genuinely in use.
///
/// A missing key is not an error: the exercise falls back to its English name.
const Map<String, String> exerciseNamesVi = <String, String>{
  // Chest
  'Bench Press': 'Đẩy Ngực Nằm',
  'Incline Bench Press': 'Đẩy Ngực Dốc Lên',
  'Decline Bench Press': 'Đẩy Ngực Dốc Xuống',
  'Dumbbell Fly': 'Ép Ngực Với Tạ Đơn',
  'Push-ups': 'Hít Đất',
  'Chest Dips': 'Chống Xà Kép Cho Ngực',
  'Machine Chest Press': 'Đẩy Ngực Máy',
  'Cable Crossover': 'Ép Ngực Cáp Chéo',
  'Pec Deck': 'Máy Ép Ngực',

  // Back
  'Pull-up': 'Hít Xà Đơn',
  'Chin-up': 'Hít Xà Tay Ngửa',
  'Barbell Row': 'Chèo Thuyền Với Tạ Đòn',
  'Dumbbell Row': 'Chèo Thuyền Với Tạ Đơn',
  'Lat Pulldown': 'Kéo Xô',
  'Deadlift': 'Deadlift',
  'T-Bar Row': 'Chèo Thuyền T-Bar',
  'Seated Cable Row': 'Chèo Thuyền Cáp Ngồi',
  'Chest-Supported Row': 'Chèo Thuyền Tựa Ngực',
  'Straight-Arm Pulldown': 'Kéo Cáp Tay Thẳng',
  'Inverted Row': 'Chèo Thuyền Ngược',
  'Sumo Deadlift': 'Deadlift Sumo',

  // Shoulders
  'Overhead Press': 'Đẩy Vai Qua Đầu',
  'Lateral Raise': 'Nâng Tạ Sang Ngang',
  'Front Raise': 'Nâng Tạ Trước Mặt',
  'Rear Delt Fly': 'Ép Vai Sau',
  'Arnold Press': 'Arnold Press',
  'Shrugs': 'Nhún Vai',
  'Face Pull': 'Kéo Cáp Vào Mặt',
  'Machine Shoulder Press': 'Đẩy Vai Máy',
  'Cable Lateral Raise': 'Nâng Tạ Sang Ngang Với Cáp',
  'Upright Row': 'Kéo Tạ Lên Cằm',

  // Arms
  'Barbell Curl': 'Cuốn Tay Với Tạ Đòn',
  'Dumbbell Curl': 'Cuốn Tay Với Tạ Đơn',
  'Hammer Curl': 'Cuốn Tay Kiểu Búa',
  'Preacher Curl': 'Cuốn Tay Trên Ghế Scott',
  'Triceps Pushdown': 'Đẩy Tay Sau Với Cáp',
  'Overhead Triceps Extension': 'Duỗi Tay Sau Qua Đầu',
  'Triceps Dips': 'Chống Xà Kép Cho Tay Sau',
  'Close-Grip Bench Press': 'Đẩy Ngực Tay Hẹp',
  'Cable Curl': 'Cuốn Tay Với Cáp',
  'Concentration Curl': 'Cuốn Tay Tập Trung',
  'Skull Crusher': 'Skull Crusher',
  'Reverse Curl': 'Cuốn Tay Ngược',
  'Wrist Curl': 'Cuốn Cổ Tay',

  // Legs
  'Squat': 'Squat',
  'Front Squat': 'Front Squat',
  'Leg Press': 'Đạp Đùi',
  'Leg Extension': 'Duỗi Đùi Trước',
  'Leg Curl': 'Cuốn Đùi Sau',
  'Romanian Deadlift': 'Deadlift Kiểu Romania',
  'Lunges': 'Chùng Chân',
  'Bulgarian Split Squat': 'Squat Bulgaria',
  'Calf Raise': 'Nhón Bắp Chân',
  'Hip Thrust': 'Đẩy Hông',
  'Hack Squat': 'Hack Squat',
  'Goblet Squat': 'Goblet Squat',
  'Step-up': 'Bước Lên Bục',
  'Good Morning': 'Good Morning',
  'Hip Abduction': 'Máy Đẩy Hông Ra',
  'Hip Adduction': 'Máy Kẹp Hông Vào',
  'Glute Kickback': 'Đạp Chân Sau Cho Cơ Mông',

  // Core
  'Plank': 'Plank',
  'Crunches': 'Gập Bụng',
  'Russian Twist': 'Xoay Người Kiểu Nga',
  'Leg Raise': 'Nâng Chân',
  'Mountain Climbers': 'Leo Núi Tại Chỗ',
  'Bicycle Crunches': 'Gập Bụng Đạp Xe',
  'Cable Crunch': 'Gập Bụng Với Cáp',
  'Dead Bug': 'Dead Bug',
  'Side Plank': 'Plank Ngang',
  'Hanging Leg Raise': 'Nâng Chân Treo Người',
  'Ab Wheel Rollout': 'Con Lăn Tập Bụng',
  'Sit-ups': 'Gập Người Toàn Phần',
  'Bird Dog': 'Bird Dog',

  // Cardio
  'Running': 'Chạy Bộ',
  'Cycling': 'Đạp Xe',
  'Rowing': 'Máy Chèo Thuyền',
  'Jump Rope': 'Nhảy Dây',
  'Walking': 'Đi Bộ',
  'Elliptical': 'Máy Elliptical',
  'Stair Climber': 'Máy Leo Cầu Thang',
  'Swimming': 'Bơi',

  // Full body
  'Burpees': 'Burpee',
  'Thrusters': 'Thruster',
  'Clean and Jerk': 'Cử Đẩy',
  'Snatch': 'Cử Giật',
  'Kettlebell Swing': 'Vung Tạ Ấm',
  'Farmer\'s Walk': 'Đi Bộ Mang Tạ',
  'Box Jump': 'Nhảy Bục',
  'Battle Ropes': 'Dây Battle Rope',
};
