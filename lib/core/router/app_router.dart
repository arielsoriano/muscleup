import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/workout/presentation/pages/dashboard_page.dart';
import '../../features/workout/presentation/pages/routines_page.dart';
import '../../features/workout/presentation/pages/workout_details_page.dart';

class AppRoutes {
  static const String dashboard = '/';
  static const String routines = '/routines';
  static const String routineDetails = '/routine/:id';
  
  static String routineDetailsPath(String id) => '/routine/$id';
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
