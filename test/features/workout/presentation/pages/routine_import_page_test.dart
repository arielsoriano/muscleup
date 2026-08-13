import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:muscleup/core/di/injection_container.dart';
import 'package:muscleup/features/settings/data/training_defaults_repository.dart';
import 'package:muscleup/features/workout/data/datasources/local/workout_database.dart';
import 'package:muscleup/features/workout/data/datasources/remote/firestore_workout_remote_data_source.dart';
import 'package:muscleup/features/workout/data/repositories/workout_repository_impl.dart';
import 'package:muscleup/features/workout/domain/usecases/save_routine_usecase.dart';
import 'package:muscleup/features/workout/presentation/cubit/routine_import_cubit.dart';
import 'package:muscleup/features/workout/presentation/pages/routine_import_page.dart';
import 'package:muscleup/l10n/app_localizations.dart';

void main() {
  late AppDatabase database;
  final List<String> copied = <String>[];

  setUp(() async {
    database = AppDatabase.forExecutor(NativeDatabase.memory());
    final repository = WorkoutRepositoryImpl(database);
    await database.select(database.libraryExercises).get();

    serviceLocator.registerFactory(
      () => RoutineImportCubit(
        saveRoutineUseCase: SaveRoutineUseCase(repository),
        repository: repository,
        trainingDefaultsRepository: TrainingDefaultsRepository(
          database: database,
          workoutRemoteDataSource: NoopWorkoutRemoteDataSource(),
        ),
      ),
    );

    copied.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') {
        copied.add((call.arguments as Map)['text'] as String);
      }
      return null;
    });
  });

  tearDown(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
    await serviceLocator.reset();
    await database.close();
  });

  /// The check button sits below the fold on a test-sized screen, and the list
  /// is lazy, so it has to be scrolled into existence before it can be tapped.
  Future<void> tapCheck(WidgetTester tester) async {
    await tester.dragUntilVisible(
      find.text('Revisar'),
      find.byType(ListView),
      const Offset(0, -120),
    );
    await tester.tap(find.text('Revisar'));
    await tester.pumpAndSettle();
  }

  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: RoutineImportPage(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('explains the flow in the app language', (tester) async {
    await pumpPage(tester);

    expect(find.text('Importar rutinas'), findsOneWidget);
    expect(find.text('Traé todo tu plan en un solo paso'), findsOneWidget);
    expect(find.text('Copiar instrucciones'), findsOneWidget);
  });

  testWidgets('copies a prompt aimed at the app language', (tester) async {
    await pumpPage(tester);

    await tester.tap(find.text('Copiar instrucciones'));
    await tester.pumpAndSettle();

    expect(copied, hasLength(1));
    expect(copied.single, contains('Español (es)'));
    // The catalog goes out translated, which is what brings back names the
    // parser can link to catalog entries.
    expect(copied.single, contains('Press de Banca'));
  });

  testWidgets('shows what a pasted plan would create', (tester) async {
    await pumpPage(tester);

    await tester.enterText(
      find.byType(TextField),
      '{"routines":[{"name":"Lunes — Torso","exercises":['
      '{"name":"Press de banca","sets":3,"reps":8,"weight":60}]}]}',
    );
    await tester.pumpAndSettle();

    await tapCheck(tester);

    expect(find.text('Esto es lo que se va a crear'), findsOneWidget);
    expect(find.text('Lunes — Torso'), findsOneWidget);
    expect(find.textContaining('Ejercicios: 1'), findsOneWidget);
    expect(find.textContaining('Series: 3'), findsOneWidget);

    await tester.dragUntilVisible(
      find.text('Importar'),
      find.byType(ListView),
      const Offset(0, -120),
    );
    expect(find.text('Importar'), findsOneWidget);
  });

  testWidgets('explains unusable text instead of failing silently',
      (tester) async {
    await pumpPage(tester);

    await tester.enterText(find.byType(TextField), 'LUNES — Torso\n1. Press');
    await tester.pumpAndSettle();

    await tapCheck(tester);

    expect(find.textContaining('no es JSON válido'), findsOneWidget);
    expect(find.text('Importar'), findsNothing);
  });
}
