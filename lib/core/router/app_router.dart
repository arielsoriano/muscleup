import 'package:go_router/go_router.dart';

import '../../features/workout/presentation/pages/routines_page.dart';

class AppRoutes {
  static const String routines = '/';
}

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.routines,
    routes: [
      GoRoute(
        path: AppRoutes.routines,
        builder: (context, state) => const RoutinesPage(),
      ),
    ],
  );
}
