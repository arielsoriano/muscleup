import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/settings/presentation/pages/exercise_library_page.dart';
import '../../features/settings/presentation/pages/privacy_policy_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/workout/domain/entities/workout_entities.dart';
import '../../features/workout/presentation/pages/active_workout_page.dart';
import '../../features/workout/presentation/pages/dashboard_page.dart';
import '../../features/workout/presentation/pages/exercise_progress_page.dart';
import '../../features/workout/presentation/pages/routine_form_page.dart';
import '../../features/workout/presentation/pages/routine_export_page.dart';
import '../../features/workout/presentation/pages/routine_import_page.dart';
import '../../features/workout/presentation/pages/routines_page.dart';
import '../../features/workout/presentation/pages/workout_details_page.dart';

class AppRoutes {
  static const String dashboard = '/';
  static const String routines = '/routines';
  static const String routineDetails = '/routine/:id';
  static const String activeWorkout = '/active-workout';
  static const String manageRoutine = '/manage-routine';
  static const String editRoutine = '/edit-routine/:id';
  static const String importRoutines = '/import-routines';
  static const String exportRoutines = '/export-routines';
  static const String settings = '/settings';
  static const String exerciseLibrary = '/exercise-library';
  static const String exerciseProgress = '/exercise-progress';
  static const String privacyPolicy = '/privacy-policy';

  static String routineDetailsPath(String id) => '/routine/$id';
  static String editRoutinePath(String id) => '/edit-routine/$id';
}

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.dashboard,
    routes: [
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: AppRoutes.routines,
        builder: (context, state) => const RoutinesPage(),
      ),
      GoRoute(
        path: AppRoutes.routineDetails,
        pageBuilder: (context, state) {
          final routineId = state.pathParameters['id'] ?? '';
          return _buildFadeTransitionPage(
            context: context,
            state: state,
            child: WorkoutDetailsPage(routineId: routineId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.activeWorkout,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return _buildFadeTransitionPage(
            context: context,
            state: state,
            child: ActiveWorkoutPage(
              routine: extra?['routine'] as WorkoutRoutine?,
              routineId: extra?['routineId'] as String?,
              sessionId: extra?['sessionId'] as String?,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.manageRoutine,
        pageBuilder: (context, state) {
          return _buildFadeTransitionPage(
            context: context,
            state: state,
            child: const RoutineFormPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.editRoutine,
        pageBuilder: (context, state) {
          final routine = state.extra;
          return _buildFadeTransitionPage(
            context: context,
            state: state,
            child: RoutineFormPage(
              routine: routine as dynamic,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.importRoutines,
        pageBuilder: (context, state) {
          return _buildFadeTransitionPage(
            context: context,
            state: state,
            child: const RoutineImportPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.exportRoutines,
        pageBuilder: (context, state) {
          return _buildFadeTransitionPage(
            context: context,
            state: state,
            child: const RoutineExportPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.settings,
        pageBuilder: (context, state) {
          return _buildFadeTransitionPage(
            context: context,
            state: state,
            child: const SettingsPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.exerciseLibrary,
        pageBuilder: (context, state) {
          return _buildFadeTransitionPage(
            context: context,
            state: state,
            child: const ExerciseLibraryPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.privacyPolicy,
        pageBuilder: (context, state) {
          return _buildFadeTransitionPage(
            context: context,
            state: state,
            child: const PrivacyPolicyPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.exerciseProgress,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return _buildFadeTransitionPage(
            context: context,
            state: state,
            child: ExerciseProgressPage(
              workoutExerciseId: extra?['workoutExerciseId'] as String? ?? '',
              exerciseName: extra?['exerciseName'] as String? ?? '',
            ),
          );
        },
      ),
    ],
  );
}

CustomTransitionPage _buildFadeTransitionPage({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}
