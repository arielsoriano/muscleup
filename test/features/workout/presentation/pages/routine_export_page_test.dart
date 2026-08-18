import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:muscleup/core/di/injection_container.dart';
import 'package:muscleup/features/workout/data/datasources/local/workout_database.dart';
import 'package:muscleup/features/workout/data/import/routine_import_parser.dart';
import 'package:muscleup/features/workout/data/repositories/workout_repository_impl.dart';
import 'package:muscleup/features/workout/domain/entities/workout_entities.dart';
import 'package:muscleup/features/workout/presentation/cubit/routine_export_cubit.dart';
import 'package:muscleup/features/workout/presentation/pages/routine_export_page.dart';
import 'package:muscleup/l10n/app_localizations.dart';

void main() {
  late AppDatabase database;
  final List<String> copied = <String>[];

  setUp(() async {
    database = AppDatabase.forExecutor(NativeDatabase.memory());
    final repository = WorkoutRepositoryImpl(database);
    await database.select(database.libraryExercises).get();

    serviceLocator.registerFactory(
      () => RoutineExportCubit(repository: repository),
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

  Future<void> seedRoutine() async {
    await database.into(database.routines).insert(
          RoutinesCompanion.insert(
            id: 'routine-1',
            name: 'LUNES — Torso',
            sortOrder: 0,
          ),
        );

    await database.into(database.exercises).insert(
          ExercisesCompanion.insert(
            id: 'exercise-1',
            routineId: 'routine-1',
            name: 'Bench Press',
            canonicalName: const Value('Bench Press'),
            sortOrder: 0,
            restTimeSeconds: 90,
          ),
        );

    await database.into(database.sets).insert(
          SetsCompanion.insert(
            id: 'set-1',
            exerciseId: 'exercise-1',
            sortOrder: 0,
            targetValue1: const Value(60),
            targetValue2: const Value(10),
            unit1: const Value(WorkoutUnit.kilograms),
            unit2: const Value(WorkoutUnit.repetitions),
          ),
        );
  }

  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: RoutineExportPage(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows the totals and the JSON in the app language', (tester) async {
    await seedRoutine();
    await pumpPage(tester);

    expect(find.text('Exportar rutinas'), findsOneWidget);
    expect(
      find.text('Rutinas: 1 · Ejercicios: 1 · Series: 1'),
      findsOneWidget,
    );

    // The exercise is spelled in the reader's language, not as it was stored.
    expect(find.textContaining('Press de Banca'), findsOneWidget);
    expect(find.textContaining('LUNES — Torso'), findsOneWidget);
  });

  testWidgets('copies JSON the import parser accepts', (tester) async {
    await seedRoutine();
    await pumpPage(tester);

    await tester.tap(find.text('Copiar JSON'));
    await tester.pumpAndSettle();

    expect(copied, hasLength(1));

    final result = RoutineImportParser().parse(copied.single);
    expect(result.isSuccess, isTrue);

    final routine = result.routines.single;
    expect(routine.name, 'LUNES — Torso');

    final exercise = routine.exercises.single;
    expect(exercise.canonicalName, 'Bench Press');
    expect(exercise.restTimeSeconds, 90);
    expect(exercise.templateSets.single.targetValue1, 60.0);
    expect(exercise.templateSets.single.targetValue2, 10.0);
  });

  testWidgets('says so instead of offering an empty file', (tester) async {
    await pumpPage(tester);

    expect(find.text('Todavía no tenés rutinas para exportar.'), findsOneWidget);
    expect(find.text('Copiar JSON'), findsNothing);
  });
}
