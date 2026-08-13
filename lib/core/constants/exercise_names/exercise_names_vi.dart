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

  // Back
  'Pull-up': 'Hít Xà Đơn',
  'Chin-up': 'Hít Xà Tay Ngửa',
  'Barbell Row': 'Chèo Thuyền Với Tạ Đòn',
  'Dumbbell Row': 'Chèo Thuyền Với Tạ Đơn',
  'Lat Pulldown': 'Kéo Xô',
  'Deadlift': 'Deadlift',
  'T-Bar Row': 'Chèo Thuyền T-Bar',

  // Shoulders
  'Overhead Press': 'Đẩy Vai Qua Đầu',
  'Lateral Raise': 'Nâng Tạ Sang Ngang',
  'Front Raise': 'Nâng Tạ Trước Mặt',
  'Rear Delt Fly': 'Ép Vai Sau',
  'Arnold Press': 'Arnold Press',
  'Shrugs': 'Nhún Vai',

  // Arms
  'Barbell Curl': 'Cuốn Tay Với Tạ Đòn',
  'Dumbbell Curl': 'Cuốn Tay Với Tạ Đơn',
  'Hammer Curl': 'Cuốn Tay Kiểu Búa',
  'Preacher Curl': 'Cuốn Tay Trên Ghế Scott',
  'Triceps Pushdown': 'Đẩy Tay Sau Với Cáp',
  'Overhead Triceps Extension': 'Duỗi Tay Sau Qua Đầu',
  'Triceps Dips': 'Chống Xà Kép Cho Tay Sau',
  'Close-Grip Bench Press': 'Đẩy Ngực Tay Hẹp',

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

  // Core
  'Plank': 'Plank',
  'Crunches': 'Gập Bụng',
  'Russian Twist': 'Xoay Người Kiểu Nga',
  'Leg Raise': 'Nâng Chân',
  'Mountain Climbers': 'Leo Núi Tại Chỗ',
  'Bicycle Crunches': 'Gập Bụng Đạp Xe',

  // Cardio
  'Running': 'Chạy Bộ',
  'Cycling': 'Đạp Xe',
  'Rowing': 'Máy Chèo Thuyền',
  'Jump Rope': 'Nhảy Dây',

  // Full body
  'Burpees': 'Burpee',
  'Thrusters': 'Thruster',
  'Clean and Jerk': 'Cử Đẩy',
  'Snatch': 'Cử Giật',
};
