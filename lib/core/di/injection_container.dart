import 'package:get_it/get_it.dart';

import '../../features/workout/domain/usecases/delete_routine_usecase.dart';
import '../../features/workout/domain/usecases/get_logs_for_session_usecase.dart';
import '../../features/workout/domain/usecases/get_routine_by_id_usecase.dart';
import '../../features/workout/domain/usecases/save_routine_usecase.dart';
import '../../features/workout/domain/usecases/save_session_usecase.dart';
import '../../features/workout/domain/usecases/save_set_log_usecase.dart';
import '../../features/workout/domain/usecases/update_routine_order_usecase.dart';
import '../../features/workout/domain/usecases/watch_routines_usecase.dart';
import '../../features/workout/domain/usecases/watch_sessions_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> initialize() async {
  await _initializeCore();
  await _initializeFeatures();
}

Future<void> _initializeCore() async {}

Future<void> _initializeFeatures() async {
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
