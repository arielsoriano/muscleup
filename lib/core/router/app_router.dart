import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/workout/domain/entities/workout_entities.dart';
import '../../features/workout/presentation/pages/active_workout_page.dart';
import '../../features/workout/presentation/pages/dashboard_page.dart';
import '../../features/workout/presentation/pages/routine_form_page.dart';
import '../../features/workout/presentation/pages/routines_page.dart';
import '../../features/workout/presentation/pages/workout_details_page.dart';

class AppRoutes {
  static const String dashboard = '/';
  static const String routines = '/routines';
  static const String routineDetails = '/routine/:id';
  static const String activeWorkout = '/active-workout';
  static const String manageRoutine = '/manage-routine';
  static const String editRoutine = '/edit-routine/:id';
  
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
