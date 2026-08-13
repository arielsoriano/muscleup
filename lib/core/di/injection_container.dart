import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasources/firebase_auth_data_source.dart';
import '../../features/auth/data/repositories/cloud_auth_repository_impl.dart';
import '../../features/auth/domain/entities/cloud_user.dart';
import '../../features/auth/domain/repositories/cloud_auth_repository.dart';
import '../../features/auth/domain/usecases/link_with_google_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_anonymously_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_cloud_usecase.dart';
import '../../features/auth/domain/usecases/watch_auth_state_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/workout/data/datasources/local/workout_database.dart';
import '../../features/workout/data/datasources/remote/firestore_workout_remote_data_source.dart';
import '../../features/workout/data/datasources/remote/workout_remote_data_source.dart';
import '../../features/workout/data/repositories/workout_repository_impl.dart';
import '../../features/workout/data/sync/sync_checkpoint_store.dart';
import '../../features/workout/data/sync/workout_sync_engine.dart';
import '../../features/workout/domain/entities/workout_entities.dart';
import '../../features/workout/domain/repositories/workout_repository.dart';
import '../../features/workout/domain/sync/sync_engine.dart';
import '../../features/workout/domain/usecases/delete_routine_usecase.dart';
import '../../features/workout/domain/usecases/delete_session_usecase.dart';
import '../../features/workout/domain/usecases/get_logs_for_session_usecase.dart';
import '../../features/workout/domain/usecases/get_routine_by_id_usecase.dart';
import '../../features/workout/domain/usecases/get_session_by_id_usecase.dart';
import '../../features/workout/domain/usecases/save_routine_usecase.dart';
import '../../features/workout/domain/usecases/save_session_usecase.dart';
import '../../features/workout/domain/usecases/save_set_log_usecase.dart';
import '../../features/workout/domain/usecases/trigger_manual_sync_usecase.dart';
import '../../features/workout/domain/usecases/update_routine_order_usecase.dart';
import '../../features/workout/domain/usecases/watch_routines_usecase.dart';
import '../../features/workout/domain/usecases/watch_sessions_usecase.dart';
import '../../features/settings/data/training_defaults_repository.dart';
import '../../features/settings/presentation/cubit/settings_cubit.dart';
import '../../features/settings/presentation/cubit/sync_status_cubit.dart';
import '../../features/settings/presentation/cubit/training_defaults_cubit.dart';
import '../../features/workout/presentation/cubit/active_workout_cubit.dart';
import '../../features/workout/presentation/cubit/dashboard_cubit.dart';
import '../../features/workout/presentation/cubit/routine_form_cubit.dart';
import '../../features/workout/presentation/cubit/routine_import_cubit.dart';
import '../../features/workout/presentation/cubit/workout_cubit.dart';
import '../../features/workout/presentation/services/rest_timer_service.dart';
import '../router/app_router.dart';
import '../settings/settings_data_source.dart';

final serviceLocator = GetIt.instance;

Future<void> initialize() async {
  await _initializeCore();
  await _initializeAuth();
  await _initializeDomain();
  await _initializePresentation();
  await serviceLocator<SyncEngine>().startAutoSync();
}

Future<void> _initializeCore() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(sharedPreferences);

  serviceLocator.registerLazySingleton<SettingsDataSource>(
    () => SettingsDataSource(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AppDatabase>(() => AppDatabase());

  serviceLocator.registerLazySingleton<SyncCheckpointStore>(
    () => SyncCheckpointStore(serviceLocator()),
  );

  serviceLocator.registerSingleton<GoRouter>(createAppRouter());
}

Future<void> _initializeAuth() async {
  bool firebaseReady = false;

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    firebaseReady = true;
  } catch (_) {}

  if (firebaseReady) {
    serviceLocator.registerLazySingleton<FirebaseAuthDataSource>(
      () => FirebaseAuthDataSource(
        firebaseAuth: FirebaseAuth.instance,
        googleSignIn: GoogleSignIn(),
      ),
    );

    serviceLocator.registerLazySingleton<CloudAuthRepository>(
      () => CloudAuthRepositoryImpl(serviceLocator()),
    );

    serviceLocator.registerLazySingleton<WorkoutRemoteDataSource>(
      () => FirestoreWorkoutRemoteDataSource(FirebaseFirestore.instance),
    );
  } else {
    serviceLocator.registerLazySingleton<CloudAuthRepository>(
      () => _NoopCloudAuthRepository(),
    );

    serviceLocator.registerLazySingleton<WorkoutRemoteDataSource>(
      () => NoopWorkoutRemoteDataSource(),
    );
  }

  serviceLocator.registerFactory(
    () => SignInAnonymouslyUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => LinkWithGoogleUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => WatchAuthStateUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => SignOutCloudUseCase(serviceLocator()),
  );

  serviceLocator.registerSingleton<AuthCubit>(
    AuthCubit(
      signInAnonymouslyUseCase: serviceLocator(),
      linkWithGoogleUseCase: serviceLocator(),
      watchAuthStateUseCase: serviceLocator(),
      signOutCloudUseCase: serviceLocator(),
    ),
  );
}

Future<void> _initializeDomain() async {
  serviceLocator.registerLazySingleton<SyncEngine>(
    () => WorkoutSyncEngine(
      database: serviceLocator(),
      workoutRemoteDataSource: serviceLocator(),
      cloudAuthRepository: serviceLocator(),
      syncCheckpointStore: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<WorkoutRepository>(
    () => WorkoutRepositoryImpl(
      serviceLocator(),
      syncEngine: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<TrainingDefaultsRepository>(
    () => TrainingDefaultsRepository(
      database: serviceLocator(),
      workoutRemoteDataSource: serviceLocator(),
    ),
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
    () => GetSessionByIdUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => SaveSessionUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => DeleteSessionUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => SaveSetLogUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => GetLogsForSessionUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => TriggerManualSyncUseCase(serviceLocator()),
  );
}

Future<void> _initializePresentation() async {
  serviceLocator.registerSingleton<SettingsCubit>(
    SettingsCubit(serviceLocator()),
  );

  serviceLocator.registerSingleton<SyncStatusCubit>(
    SyncStatusCubit(serviceLocator()),
  );

  serviceLocator.registerSingleton<TrainingDefaultsCubit>(
    TrainingDefaultsCubit(
      serviceLocator(),
      serviceLocator(),
    ),
  );

  serviceLocator.registerSingleton<RestTimerService>(RestTimerService());

  serviceLocator.registerFactory(
    () => WorkoutCubit(
      watchRoutinesUseCase: serviceLocator(),
      deleteRoutineUseCase: serviceLocator(),
      updateRoutineOrderUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => DashboardCubit(
      watchRoutinesUseCase: serviceLocator(),
      watchSessionsUseCase: serviceLocator(),
      deleteSessionUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerFactoryParam<ActiveWorkoutCubit, WorkoutRoutine, String?>(
    (routine, sessionId) => ActiveWorkoutCubit(
      routineId: routine.id,
      routine: routine,
      repository: serviceLocator(),
      getRoutineByIdUseCase: serviceLocator(),
      getSessionByIdUseCase: serviceLocator(),
      saveSessionUseCase: serviceLocator(),
      saveSetLogUseCase: serviceLocator(),
      getLogsForSessionUseCase: serviceLocator(),
      restTimerService: serviceLocator(),
      sessionId: sessionId,
    ),
  );

  serviceLocator.registerFactory(
    () => RoutineImportCubit(
      saveRoutineUseCase: serviceLocator(),
      repository: serviceLocator(),
      trainingDefaultsRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactoryParam<RoutineFormCubit, WorkoutRoutine?, void>(
    (routine, _) => RoutineFormCubit(
      routine: routine,
      saveRoutineUseCase: serviceLocator(),
      repository: serviceLocator(),
      trainingDefaultsRepository: serviceLocator(),
    ),
  );
}

class _NoopCloudAuthRepository implements CloudAuthRepository {
  @override
  Stream<CloudUser?> watchAuthState() => Stream.value(null);

  @override
  Future<CloudUser> signInAnonymously() =>
      Future.error(Exception('Firebase not configured'));

  @override
  Future<CloudUser> linkWithGoogle() =>
      Future.error(Exception('Firebase not configured'));

  @override
  Future<void> signOutCloud() async {}
}
