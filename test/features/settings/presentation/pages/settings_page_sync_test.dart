import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muscleup/core/di/injection_container.dart';
import 'package:muscleup/core/settings/settings_data_source.dart';
import 'package:muscleup/core/theme/app_theme.dart';
import 'package:muscleup/features/auth/domain/entities/cloud_user.dart';
import 'package:muscleup/features/auth/domain/repositories/cloud_auth_repository.dart';
import 'package:muscleup/features/auth/domain/usecases/link_with_google_usecase.dart';
import 'package:muscleup/features/auth/domain/usecases/sign_in_anonymously_usecase.dart';
import 'package:muscleup/features/auth/domain/usecases/sign_out_cloud_usecase.dart';
import 'package:muscleup/features/auth/domain/usecases/watch_auth_state_usecase.dart';
import 'package:muscleup/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:muscleup/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:muscleup/features/settings/presentation/cubit/sync_status_cubit.dart';
import 'package:muscleup/features/settings/presentation/pages/settings_page.dart';
import 'package:muscleup/features/workout/domain/sync/sync_engine.dart';
import 'package:muscleup/features/workout/domain/sync/sync_run_state.dart';
import 'package:muscleup/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('SettingsPage sync integration', () {
    late _FakeCloudAuthRepository fakeCloudAuthRepository;
    late _FakeSyncEngine fakeSyncEngine;
    late _TestSyncStatusCubit testSyncStatusCubit;

    setUp(() async {
      await serviceLocator.reset();
      SharedPreferences.setMockInitialValues(<String, Object>{});
      final sharedPreferences = await SharedPreferences.getInstance();

      fakeCloudAuthRepository = _FakeCloudAuthRepository();
      fakeSyncEngine = _FakeSyncEngine();
      testSyncStatusCubit = _TestSyncStatusCubit(fakeSyncEngine);

      serviceLocator.registerSingleton<SettingsCubit>(
        SettingsCubit(SettingsDataSource(sharedPreferences)),
      );

      serviceLocator.registerSingleton<AuthCubit>(
        AuthCubit(
          signInAnonymouslyUseCase: SignInAnonymouslyUseCase(fakeCloudAuthRepository),
          linkWithGoogleUseCase: LinkWithGoogleUseCase(fakeCloudAuthRepository),
          watchAuthStateUseCase: WatchAuthStateUseCase(fakeCloudAuthRepository),
          signOutCloudUseCase: SignOutCloudUseCase(fakeCloudAuthRepository),
        ),
      );

      serviceLocator.registerSingleton<SyncStatusCubit>(testSyncStatusCubit);

      fakeCloudAuthRepository.authStreamController.add(
        const CloudUser(uid: 'anon-1', isAnonymous: true),
      );
    });

    tearDown(() async {
      await serviceLocator<AuthCubit>().close();
      await serviceLocator<SettingsCubit>().close();
      await serviceLocator<SyncStatusCubit>().close();
      await fakeCloudAuthRepository.dispose();
      await fakeSyncEngine.dispose();
      await serviceLocator.reset();
    });

    testWidgets('renders anonymous account state', (tester) async {
      await tester.pumpWidget(_testApp(const SettingsPage()));
      await tester.pumpAndSettle();

      expect(find.text('Continue with Google'), findsOneWidget);
    });

    testWidgets('sync now button is disabled during syncing', (tester) async {
      await tester.pumpWidget(_testApp(const SettingsPage()));
      await tester.pumpAndSettle();

      fakeSyncEngine.emitState(Syncing(startedAt: DateTime(2025, 1, 1, 10, 0)));
      testSyncStatusCubit.emitSyncing(DateTime(2025, 1, 1, 10, 0));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));

      expect(serviceLocator<SyncStatusCubit>().state.isSyncing, isTrue);

      final filledButton = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'Sync now'),
      );

      expect(filledButton.onPressed, isNull);
    });

    testWidgets('shows last sync metrics and error message', (tester) async {
      fakeCloudAuthRepository.authStreamController.add(
        const CloudUser(
          uid: 'google-uid',
          isAnonymous: false,
          email: 'test@example.com',
        ),
      );
      await tester.pumpWidget(_testApp(const SettingsPage()));
      await tester.pumpAndSettle();

      testSyncStatusCubit.emitSuccess(
        SyncRunMetrics(
          pushedCount: 2,
          pulledCount: 3,
          conflictsResolvedCount: 1,
          failedCount: 0,
          startedAt: DateTime(2025, 1, 1, 10, 0),
          endedAt: DateTime(2025, 1, 1, 10, 1),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));

      expect(serviceLocator<SyncStatusCubit>().state.lastRunMetrics, isNotNull);

      expect(find.textContaining('Pushed 2'), findsOneWidget);

      testSyncStatusCubit.emitError('Firestore timeout on routines during fetchUpdatedSince');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));

      expect(find.textContaining('Firestore timeout'), findsOneWidget);
    });
  });
}

Widget _testApp(Widget child) {
  return MaterialApp(
    localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const <Locale>[Locale('en'), Locale('es')],
    theme: AppTheme.getTheme(skin: AppSkin.volt, isDarkMode: false),
    home: child,
  );
}

class _FakeCloudAuthRepository implements CloudAuthRepository {
  final StreamController<CloudUser?> authStreamController =
      StreamController<CloudUser?>.broadcast();

  @override
  Stream<CloudUser?> watchAuthState() => authStreamController.stream;

  @override
  Future<CloudUser> signInAnonymously() async {
    return const CloudUser(uid: 'anon-generated', isAnonymous: true);
  }

  @override
  Future<CloudUser> linkWithGoogle() async {
    return const CloudUser(uid: 'google-uid', isAnonymous: false);
  }

  @override
  Future<void> signOutCloud() async {}

  Future<void> dispose() async {
    await authStreamController.close();
  }
}

class _FakeSyncEngine implements SyncEngine {
  final StreamController<SyncRunState> syncStateStreamController =
      StreamController<SyncRunState>.broadcast();

  @override
  Stream<SyncRunState> get stateStream => syncStateStreamController.stream;

  @override
  Future<void> notifyConnectivityRestored() async {}

  @override
  Future<void> startAutoSync() async {}

  @override
  Future<SyncRunResult> triggerManualSync() async {
    return SyncRunResult(
      success: true,
      metrics: SyncRunMetrics(
        pushedCount: 1,
        pulledCount: 1,
        conflictsResolvedCount: 0,
        failedCount: 0,
        startedAt: DateTime(2025, 1, 1, 10, 0),
        endedAt: DateTime(2025, 1, 1, 10, 1),
      ),
    );
  }

  void emitState(SyncRunState syncRunState) {
    syncStateStreamController.add(syncRunState);
  }

  Future<void> dispose() async {
    await syncStateStreamController.close();
  }
}

class _TestSyncStatusCubit extends SyncStatusCubit {
  _TestSyncStatusCubit(super.syncEngine);

  void emitSyncing(DateTime startedAt) {
    emit(state.copyWith(isSyncing: true, clearErrorMessage: true));
  }

  void emitSuccess(SyncRunMetrics syncRunMetrics) {
    emit(state.copyWith(
      isSyncing: false,
      lastRunMetrics: syncRunMetrics,
      clearErrorMessage: true,
    ),);
  }

  void emitError(String message) {
    emit(state.copyWith(
      isSyncing: false,
      lastErrorMessage: message,
    ),);
  }
}
