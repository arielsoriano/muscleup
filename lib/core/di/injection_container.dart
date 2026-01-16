import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../features/workout/data/datasources/local/workout_database.dart';
import '../../features/workout/data/repositories/workout_repository_impl.dart';
import '../../features/workout/domain/repositories/workout_repository.dart';
import '../../features/workout/domain/usecases/delete_routine_usecase.dart';
import '../../features/workout/domain/usecases/get_logs_for_session_usecase.dart';
import '../../features/workout/domain/usecases/get_routine_by_id_usecase.dart';
import '../../features/workout/domain/usecases/save_routine_usecase.dart';
import '../../features/workout/domain/usecases/save_session_usecase.dart';
import '../../features/workout/domain/usecases/save_set_log_usecase.dart';
import '../../features/workout/domain/usecases/update_routine_order_usecase.dart';
import '../../features/workout/domain/usecases/watch_routines_usecase.dart';
import '../../features/workout/domain/usecases/watch_sessions_usecase.dart';
import '../../features/workout/presentation/cubit/dashboard_cubit.dart';
import '../../features/workout/presentation/cubit/workout_cubit.dart';
import '../router/app_router.dart';

final serviceLocator = GetIt.instance;

Future<void> initialize() async {
  await _initializeCore();
  await _initializeDomain();
  await _initializePresentation();
}

Future<void> _initializeCore() async {
  serviceLocator.registerLazySingleton<AppDatabase>(() => AppDatabase());
  
  serviceLocator.registerSingleton<GoRouter>(createAppRouter());
}

Future<void> _initializeDomain() async {
  serviceLocator.registerLazySingleton<WorkoutRepository>(
    () => WorkoutRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => WatchRoutinesUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => GetRoutineByIdUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => SaveRoutineUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => DeleteRoutineUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UpdateRoutineOrderUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => WatchSessionsUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => SaveSessionUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => SaveSetLogUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => GetLogsForSessionUseCase(serviceLocator()),
  );
}

Future<void> _initializePresentation() async {
  serviceLocator.registerFactory(
    () => WorkoutCubit(
      watchRoutinesUseCase: serviceLocator(),
      deleteRoutineUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => DashboardCubit(
      watchSessionsUseCase: serviceLocator(),
    ),
  );
}
