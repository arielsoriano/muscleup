# Muscleup Architecture

## Overview

Muscleup implements Clean Architecture principles combined with MVVM presentation pattern to ensure maintainability, testability, and separation of concerns. This document outlines architectural decisions and patterns used throughout the project.

## Core Principles

1. **Separation of Concerns**: Each layer has a single, well-defined responsibility
2. **Dependency Rule**: Dependencies point inward; inner layers know nothing of outer layers
3. **Testability**: Business logic is independent of frameworks and UI
4. **Self-Documenting Code**: No comments; code quality speaks for itself

## Project Structure

```
lib/
├── core/                     # Shared infrastructure
│   ├── constants/           # Application-wide constants
│   ├── di/                  # Dependency injection setup
│   ├── error/               # Error handling abstractions
│   ├── theme/               # Design system implementation
│   ├── usecases/            # Base use case contracts
│   └── utils/               # Helper utilities
├── features/                # Feature modules (domain-driven)
│   └── [feature_name]/
│       ├── data/           # Data sources, models, repositories
│       ├── domain/         # Entities, repository contracts, use cases
│       └── presentation/   # UI, BLoC/Cubit, view models
└── l10n/                    # Internationalization assets
```

## Phase 1: Foundations & Configuration

### Clean Architecture Choice

**Decision**: Implement Clean Architecture with MVVM for presentation layer.

**Rationale**:
- **Scalability**: Modular structure allows features to grow independently
- **Testability**: Business logic isolated from Flutter framework
- **Maintainability**: Clear boundaries prevent coupling between layers
- **Team Collaboration**: Well-defined contracts enable parallel development

**Layer Responsibilities**:

| Layer | Location | Responsibility | Dependencies |
|-------|----------|----------------|-------------|
| **Presentation** | `features/*/presentation` | UI, state management, user interaction | Domain layer only |
| **Domain** | `features/*/domain` | Business logic, entities, use cases | None (pure Dart) |
| **Data** | `features/*/data` | Data sources, repository implementations | Domain contracts |
| **Core** | `core/` | Cross-cutting concerns, utilities | None |

### Folder Structure Design

**Hybrid Approach**: Layer-first within feature modules.

```dart
features/
  workout/
    data/
      datasources/
      models/
      repositories/
    domain/
      entities/
      repositories/
      usecases/
    presentation/
      bloc/
      pages/
      widgets/
```

**Benefits**:
- Feature isolation enables modular development
- Layer separation within features maintains Clean Architecture
- Easy to locate and modify related functionality
- Supports feature-based team assignments

### Theme System

**Technology**: FlexColorScheme + Google Fonts

**Implementation**: `lib/core/theme/app_theme.dart`

**Design Decisions**:

1. **FlexColorScheme Integration**:
   - Professional, accessibility-compliant color schemes
   - Automatic Material 3 theming with consistent color relationships
   - Eliminates manual theme configuration and color matching

2. **Custom Color Palette**:
   ```dart
   Dark Mode:
     - Base: Midnight (#0A0E27)
     - Accent: Volt Green (#39FF14)
     - High contrast for workout tracking
   
   Light Mode:
     - Base: Soft White (#FAFAFA)
     - Accent: Deep Charcoal (#2C3E50)
     - Reduced eye strain for extended use
   ```

3. **Design Token System**:
   - Spacing constants (XSmall: 4, Small: 8, Medium: 16, Large: 24, XLarge: 32)
   - Border radius standards (Small: 8, Medium: 12, Large: 16)
   - Icon size presets (Small: 20, Medium: 24, Large: 32)

**Benefits**:
- Consistent visual language across the application
- Easy theme customization without touching individual widgets
- Accessibility standards met by default
- Performance optimized with compile-time constants

### Localization Strategy

**Technology**: Native Flutter Localization (ARB) with Custom Context Extensions

**Implementation**: `lib/l10n/` + `lib/core/utils/l10n_extension.dart`

**Architecture**:

1. **ARB Files** (`app_en.arb`, `app_es.arb`):
   - Industry-standard format for translations
   - Compile-time type safety via code generation
   - Metadata support for translator context

2. **BuildContext Extension (Senior Architectural Pattern)**:
   ```dart
   extension LocalizationsContext on BuildContext {
     AppLocalizations get l10n => AppLocalizations.of(this)!;
   }
   ```
   
   **Design Rationale**:
   - Eliminates verbose `AppLocalizations.of(context)!` repetition throughout UI layer
   - Provides single, canonical access point for all translations
   - Leverages Dart's extension methods for ergonomic API design
   - Maintains null-safety with explicit non-null assertion at extension boundary
   
   **Usage**:
   ```dart
   Text(context.l10n.workouts)  // Clean, IDE-autocomplete friendly
   ```

**Benefits**:
- Type-safe translation access (compile errors for missing keys)
- Dramatically reduced boilerplate in presentation layer
- Centralized translation management
- Easy addition of new languages without code changes
- Improved developer experience with consistent API across codebase

**Vocabulary Strategy**:
- Front-load common terms (workouts, exercises, sets, reps, weight)
- Reduces future rework when implementing features
- Maintains consistent terminology across the app

### Error Handling

**Pattern**: Failure abstraction + Either monad

**Implementation**: `lib/core/error/`

**Architecture**:

1. **Exceptions** (Data Layer):
   ```dart
   class DatabaseException implements Exception {
     const DatabaseException(this.message);
     final String message;
   }
   ```
   
   - Thrown in data sources
   - Technical, implementation-specific
   - Never exposed to presentation layer

2. **Failures** (Domain Layer):
   ```dart
   abstract class Failure extends Equatable {
     const Failure();
   }
   
   class DatabaseFailure extends Failure {
     const DatabaseFailure(this.message);
     final String message;
   }
   ```
   
   - Business-friendly error representation
   - Equatable for easy comparison in tests
   - Presentation layer handles these

3. **Either Monad** (Use Case Return Type):
   ```dart
   abstract class UseCase<Type, Params> {
     Future<Either<Failure, Type>> call(Params params);
   }
   ```
   
   **Usage**:
   ```dart
   final result = await useCase(params);
   result.fold(
     (failure) => handleError(failure),
     (data) => displayData(data),
   );
   ```

**Benefits**:
- Explicit error handling (no silent failures)
- Type-safe error flow from data to presentation
- Testable error scenarios
- Clean separation: exceptions in data, failures in domain
- Forces developers to handle both success and error cases

**Error Flow**:
```
Data Layer          Domain Layer         Presentation Layer
   ↓                    ↓                      ↓
Exception    →    Repository catches   →   Either<Failure, T>
(technical)       converts to Failure      (user-friendly)
                  (business logic)
```

## Phase 2: Domain Layer (The Heart)

### Domain Entities

**Technology**: Freezed + freezed_annotation

**Implementation**: `lib/features/workout/domain/entities/workout_entities.dart`

**Architecture**:

1. **Immutability with Freezed**:
   ```dart
   @freezed
   class WorkoutRoutine with _$WorkoutRoutine {
     const factory WorkoutRoutine({
       required String id,
       required String name,
       required int sortOrder,
       required List<WorkoutExercise> exercises,
     }) = _WorkoutRoutine;
   }
   ```
   
   **Design Rationale**:
   - Compile-time immutability guarantees prevent accidental mutations
   - Thread-safe by default (critical for multi-threaded operations)
   - Automatic copyWith methods for state updates
   - Value equality without manual overrides
   - Pattern matching support for exhaustive state handling

2. **Flexible Unit Design (WorkoutSet)**:
   ```dart
   enum WorkoutUnit {
     kilograms,
     pounds,
     repetitions,
     seconds,
     minutes,
     kilometers,
     meters,
     none,
   }
   
   @freezed
   class WorkoutSet with _$WorkoutSet {
     const factory WorkoutSet({
       required String id,
       required int sortOrder,
       double? targetValue1,
       double? targetValue2,
       WorkoutUnit? unit1,
       WorkoutUnit? unit2,
     }) = _WorkoutSet;
   }
   ```
   
   **Design Philosophy**:
   - **Universal Flexibility**: Single entity supports multiple workout types
   - **Type Safety**: WorkoutUnit enum eliminates magic strings and prevents typos
   - **Weight Training**: `targetValue1=weight, unit1=kilograms, targetValue2=reps, unit2=repetitions`
   - **Cardio (Time)**: `targetValue1=duration, unit1=seconds`
   - **Cardio (Distance)**: `targetValue1=distance, unit1=kilometers, targetValue2=time, unit2=seconds`
   - **Bodyweight**: `targetValue1=reps, unit1=repetitions`
   - **Scalability**: No schema changes needed for new workout types
   - **Data Consistency**: Compile-time guarantees for unit values

3. **Session and Log Entities (Progress Tracking)**:
   ```dart
   @freezed
   class WorkoutSession with _$WorkoutSession {
     const factory WorkoutSession({
       required String id,
       required String routineId,
       required DateTime date,
       String? notes,
     }) = _WorkoutSession;
   }
   
   @freezed
   class SetLog with _$SetLog {
     const factory SetLog({
       required String id,
       required String sessionId,
       required String workoutExerciseId,
       required int setNumber,
       double? actualValue1,
       double? actualValue2,
       WorkoutUnit? unit1,
       WorkoutUnit? unit2,
       required bool isCompleted,
       required DateTime timestamp,
     }) = _SetLog;
   }
   ```
   
   **Architecture Pattern**:
   - **Two-Layer Tracking**: Session as container, SetLog as granular performance record
   - **WorkoutSession**: Represents a single training day instance
     - Links to WorkoutRoutine via routineId (template reference)
     - Captures training date and session-level notes
     - Acts as parent entity for all SetLog records
   - **SetLog**: Records actual performance for each set
     - Links to specific WorkoutExercise being performed
     - Tracks actual values vs template targets
     - Completion status enables partial workout tracking
     - Timestamp allows temporal analysis and rest period calculations
   
   **Data Flow**:
   ```
   WorkoutRoutine (Template)
         ↓
   WorkoutSession (Instance)
         ↓
   SetLog (Performance)
   ```
   
   **Design Benefits**:
   - Historical tracking without modifying routine templates
   - Progress comparison across multiple sessions
   - Flexible partial completion (skip sets, stop early)
   - Support for progressive overload analysis
   - Independent session editing without affecting templates
   - **UI Simplicity**: Single component handles all set types

**Benefits**:
- Predictable state transitions throughout the application
- Zero runtime overhead for immutability checks
- Reduced boilerplate compared to manual implementations
- Eliminates entire classes of bugs related to mutable state
- Future-proof design accommodates new exercise modalities

### Repository Contract

**Technology**: Abstract classes with functional error handling

**Implementation**: `lib/features/workout/domain/repositories/workout_repository.dart`

**Architecture**:

1. **Stream-Based Reactivity**:
   ```dart
   Stream<Either<Failure, List<WorkoutRoutine>>> watchRoutines();
   ```
   
   **Design Rationale**:
   - Real-time UI synchronization without manual polling
   - Automatic updates when data changes (create, update, delete)
   - Memory-efficient with stream subscription management
   - Supports multiple listeners (BLoC states, widgets, services)
   - Database changes propagate instantly to UI layer
   
   **Use Case**:
   - User creates routine → Stream emits → UI rebuilds automatically
   - Background sync completes → Stream emits → UI updates
   - Multi-screen consistency without manual refresh logic

2. **Functional Error Handling**:
   ```dart
   Future<Either<Failure, WorkoutRoutine>> getRoutineById(String id);
   Future<Either<Failure, void>> saveRoutine(WorkoutRoutine routine);
   Future<Either<Failure, void>> deleteRoutine(String id);
   ```
   
   **Design Philosophy**:
   - **Explicit over Implicit**: No hidden exceptions, all errors are values
   - **Type Safety**: Compiler enforces error handling at call sites
   - **Railway-Oriented Programming**: Success and failure tracks clearly defined
   - **Composability**: Chain operations with flatMap/bind patterns
   - **Testability**: Mock failures as easily as successes
   
   **Benefits**:
   - Impossible to ignore errors (unlike try-catch which can be omitted)
   - Self-documenting API (return type shows operation can fail)
   - Consistent error handling across all features
   - No runtime surprises from unhandled exceptions

3. **Business-Driven Methods**:
   ```dart
   Future<Either<Failure, void>> updateRoutineOrder(List<WorkoutRoutine> routines);
   ```
   
   **Design Pattern**:
   - Methods reflect user actions, not database operations
   - `updateRoutineOrder` vs generic `updateAll` → intention clarity
   - Encapsulates business rules (validation, ordering logic)
   - Single source of truth for operation semantics

**Contract Guarantees**:
- Repository implementations must never throw exceptions
- All errors converted to typed Failure objects
- Domain layer remains framework-agnostic (no Flutter, no Drift)
- Testable with pure Dart mocks

### Use Case Layer

**Technology**: UseCase and StreamUseCase base classes

**Implementation**: `lib/features/workout/domain/usecases/`

**Architecture**:

1. **UseCase Pattern (Single Responsibility)**:
   ```dart
   abstract class UseCase<Type, Params> {
     Future<Either<Failure, Type>> call(Params params);
   }
   
   class SaveRoutineUseCase extends UseCase<void, SaveRoutineParams> {
     SaveRoutineUseCase(this.repository);
     final WorkoutRepository repository;
     
     @override
     Future<Either<Failure, void>> call(SaveRoutineParams params) {
       return repository.saveRoutine(params.routine);
     }
   }
   ```
   
   **Design Rationale**:
   - **One Business Operation Per Class**: SaveRoutine, DeleteRoutine, etc.
   - **Testable Units**: Each use case independently testable
   - **Dependency Inversion**: Depends on WorkoutRepository abstraction
   - **Parameter Objects**: Type-safe inputs with Equatable for comparisons
   - **Presentation Isolation**: BLoCs/Cubits know nothing about repositories

2. **StreamUseCase Pattern (Reactive Queries)**:
   ```dart
   abstract class StreamUseCase<Type, Params> {
     Stream<Either<Failure, Type>> call(Params params);
   }
   
   class WatchRoutinesUseCase extends StreamUseCase<List<WorkoutRoutine>, NoParams> {
     WatchRoutinesUseCase(this.repository);
     final WorkoutRepository repository;
     
     @override
     Stream<Either<Failure, List<WorkoutRoutine>>> call(NoParams params) {
       return repository.watchRoutines();
     }
   }
   
   class WatchSessionsUseCase extends StreamUseCase<List<WorkoutSession>, NoParams> {
     WatchSessionsUseCase(this.repository);
     final WorkoutRepository repository;
     
     @override
     Stream<Either<Failure, List<WorkoutSession>>> call(NoParams params) {
       return repository.watchSessions();
     }
   }
   ```
   
   **Design Extension**:
   - Mirrors UseCase pattern for consistency
   - Enables reactive data flows through architecture layers
   - Stream management encapsulated at domain boundary
   - BLoCs consume streams without knowing data source
   - **Advanced Application**: Both routines (templates) and sessions (instances) use reactive streams
   - Real-time synchronization between planning and execution views
   - Automatic UI updates when completing sets during workout

**Implemented Use Cases**:

| Use Case | Type | Purpose | Parameters |
|----------|------|---------|------------|
| **WatchRoutinesUseCase** | Stream | Real-time routine list updates | None |
| **GetRoutineByIdUseCase** | Future | Single routine retrieval | id: String |
| **SaveRoutineUseCase** | Future | Create or update routine | routine: WorkoutRoutine |
| **DeleteRoutineUseCase** | Future | Remove routine | id: String |
| **UpdateRoutineOrderUseCase** | Future | Persist drag-and-drop changes | routines: List<WorkoutRoutine> |
| **WatchSessionsUseCase** | Stream | Real-time session list updates | None |
| **SaveSessionUseCase** | Future | Create or update session | session: WorkoutSession |
| **SaveSetLogUseCase** | Future | Record set performance | log: SetLog |
| **GetLogsForSessionUseCase** | Future | Retrieve session performance history | sessionId: String |

**Benefits**:
- **Business Logic Isolation**: All domain rules in one testable layer
- **Presentation Simplicity**: BLoCs call use cases, no repository knowledge
- **Parallel Development**: Use cases defined before data layer exists
- **Change Insulation**: Repository implementation changes don't affect BLoCs
- **Testing Pyramid**: Fast unit tests for use cases, fewer integration tests needed

### Dependency Inversion Principle

**Implementation Across Domain Layer**:

```
Presentation Layer (BLoC)
         ↓ depends on
    Use Cases (concrete)
         ↓ depends on  
  Repository (abstract) ← Domain defines this
         ↑ implemented by
    Data Layer (concrete) ← Data conforms to domain
```

**Achieved Through**:
1. **Abstract Repository**: Domain defines interface, Data implements
2. **Dependency Injection**: Get_It wires concrete to abstract at runtime
3. **Entity Purity**: Domain entities have zero framework dependencies
4. **Use Case Contracts**: Accept abstractions, return abstractions

**Validation**:
- Domain layer compiles without Flutter SDK
- Domain tests run without database
- Domain entities serializable without knowing storage format
- Repository contract swappable (SQL → NoSQL → API)

**SOLID Compliance**:
- **S**: Each use case has single responsibility
- **O**: Entities closed for modification (immutable)
- **L**: Repository implementations substitutable
- **I**: Repository interface segregated by feature
- **D**: High-level (domain) doesn't depend on low-level (data)

## Phase 3: Data Layer (Persistence)

### Data Layer Implementation

**Technology**: Drift (SQLite) as local persistence engine

**Implementation**: `lib/features/workout/data/`

**Architecture**:

1. **Drift Database Engine**:
   ```dart
   @DriftDatabase(tables: [Routines, Exercises, Sets, Sessions, SetLogs])
   class AppDatabase extends _$AppDatabase {
     AppDatabase() : super(_openConnection());
     
     @override
     int get schemaVersion => AppConstants.databaseVersion;
   }
   ```
   
   **Design Rationale**:
   - **Type Safety**: Compile-time SQL validation eliminates runtime query errors
   - **Reactive Queries**: Built-in Stream support via `watch()` for automatic UI updates
   - **Code Generation**: Dart classes from table definitions reduce boilerplate
   - **Migration Support**: Schema versioning with explicit upgrade paths
   - **Performance**: Direct SQLite bindings with zero serialization overhead
   - **Offline-First**: No network dependency, instant data access
   
   **Benefits Over Alternatives**:
   - **vs sqflite**: Type-safe queries prevent SQL injection and typos
   - **vs Hive**: Relational model supports complex queries and joins
   - **vs SharedPreferences**: Structured data with ACID guarantees
   - **vs Isar**: Mature ecosystem, better Flutter integration

### Schema Design

**Relational Structure**: Hierarchical entity relationships with referential integrity

**Implementation**: `lib/features/workout/data/datasources/local/workout_database.dart`

**Tables Architecture**:

1. **Routines Table** (Root Entity):
   ```dart
   @DataClassName('RoutineData')
   class Routines extends Table {
     TextColumn get id => text()();
     TextColumn get name => text()();
     IntColumn get sortOrder => integer()();
     
     @override
     Set<Column<Object>> get primaryKey => {id};
   }
   ```
   
   **Design Decision**: String IDs for UUID/Firebase compatibility

2. **Exercises Table** (Child of Routines):
   ```dart
   @DataClassName('ExerciseData')
   class Exercises extends Table {
     TextColumn get id => text()();
     TextColumn get routineId => text().references(Routines, #id, onDelete: KeyAction.cascade)();
     TextColumn get name => text()();
     TextColumn get notes => text().nullable()();
     IntColumn get restTimeSeconds => integer()();
     IntColumn get sortOrder => integer()();
   }
   ```
   
   **Foreign Key Design**:
   - `onDelete: KeyAction.cascade`: Deleting routine removes all exercises automatically
   - Prevents orphaned data and maintains referential integrity
   - Database-level enforcement (faster than application-level cleanup)

3. **Sets Table** (Child of Exercises):
   ```dart
   @DataClassName('SetData')
   class Sets extends Table {
     TextColumn get id => text()();
     TextColumn get exerciseId => text().references(Exercises, #id, onDelete: KeyAction.cascade)();
     RealColumn get targetValue1 => real().nullable()();
     RealColumn get targetValue2 => real().nullable()();
     IntColumn get unit1 => intEnum<WorkoutUnit>().nullable()();
     IntColumn get unit2 => intEnum<WorkoutUnit>().nullable()();
     IntColumn get sortOrder => integer()();
   }
   ```
   
   **Enum Mapping Strategy**:
   - `intEnum<WorkoutUnit>()`: Type-safe enum storage as integers
   - Compile-time validation of enum values
   - Database-level constraints prevent invalid states
   - Zero serialization overhead (direct integer mapping)

4. **Sessions Table** (Workout Instances):
   ```dart
   @DataClassName('SessionData')
   class Sessions extends Table {
     TextColumn get id => text()();
     TextColumn get routineId => text().references(Routines, #id)();
     DateTimeColumn get date => dateTime()();
     TextColumn get notes => text().nullable()();
   }
   ```
   
   **Relationship Pattern**:
   - References Routine but NO cascade delete
   - Historical sessions preserved even if routine deleted
   - Enables progress tracking across routine modifications

5. **SetLogs Table** (Performance Records):
   ```dart
   @DataClassName('SetLogData')
   class SetLogs extends Table {
     TextColumn get id => text()();
     TextColumn get sessionId => text().references(Sessions, #id, onDelete: KeyAction.cascade)();
     TextColumn get workoutExerciseId => text()();
     IntColumn get setNumber => integer()();
     RealColumn get actualValue1 => real().nullable()();
     RealColumn get actualValue2 => real().nullable()();
     IntColumn get unit1 => intEnum<WorkoutUnit>().nullable()();
     IntColumn get unit2 => intEnum<WorkoutUnit>().nullable()();
     BoolColumn get isCompleted => boolean()();
     DateTimeColumn get timestamp => dateTime()();
   }
   ```
   
   **Cascade Strategy**:
   - Deleting session removes all logs (cleanup)
   - Logs tied to session lifecycle, not routine lifecycle
   - Supports partial workout completion tracking

**Relational Hierarchy**:
```
Routines (1) ←→ (N) Exercises (1) ←→ (N) Sets
    ↑                                    
    │ (reference only)                   
    │                                    
Sessions (1) ←→ (N) SetLogs
```

**Data Integrity Guarantees**:
- Primary keys enforce uniqueness
- Foreign keys prevent invalid references
- Cascade deletes maintain consistency
- NOT NULL constraints on required fields
- Enum constraints prevent invalid unit values

### Repository Implementation

**Implementation**: `lib/features/workout/data/repositories/workout_repository_impl.dart`

**Architecture Patterns**:

1. **Transaction-Based Saving Strategy**:
   ```dart
   @override
   Future<Either<Failure, void>> saveRoutine(WorkoutRoutine routine) async {
     try {
       await database.transaction(() async {
         // 1. Upsert routine
         await database.into(database.routines).insertOnConflictUpdate(
           RoutinesCompanion.insert(
             id: routine.id,
             name: routine.name,
             sortOrder: routine.sortOrder,
           ),
         );
         
         // 2. Delete existing exercises (cascade deletes sets)
         await (database.delete(database.exercises)
           ..where((exercise) => exercise.routineId.equals(routine.id))
         ).go();
         
         // 3. Insert new exercises and sets
         for (final exercise in routine.exercises) {
           await database.into(database.exercises).insert(...);
           for (final set in exercise.templateSets) {
             await database.into(database.sets).insert(...);
           }
         }
       });
       return const Either<Failure, void>.right(null);
     } catch (e) {
       return Either<Failure, void>.left(DatabaseFailure(e.toString()));
     }
   }
   ```
   
   **Design Rationale**:
   - **Atomicity**: All-or-nothing operation via transaction
   - **Simplicity**: Delete-and-recreate eliminates complex diff logic
   - **Consistency**: No partial updates possible
   - **Performance**: Single transaction = single disk write
   - **Correctness**: Cascade delete ensures no orphaned sets
   
   **Why Not Update-Only Strategy?**:
   - Complex: Must diff existing vs new (O(n²) comparison)
   - Error-Prone: Missing deletes leave orphaned data
   - Edge Cases: Reordering, ID changes, nested modifications
   - Performance: Similar for typical routine sizes (<50 sets)
   - Maintenance: Simple code = fewer bugs

2. **Reactive Query Implementation**:
   ```dart
   @override
   Stream<Either<Failure, List<WorkoutRoutine>>> watchRoutines() {
     try {
       return database
         .select(database.routines)
         .watch()
         .asyncMap((routineDataList) async {
           try {
             final routines = <WorkoutRoutine>[];
             for (final routineData in routineDataList) {
               final exercises = await _fetchExercisesForRoutine(routineData.id);
               routines.add(_mapRoutineDataToEntity(routineData, exercises));
             }
             return Either<Failure, List<WorkoutRoutine>>.right(routines);
           } catch (e) {
             return Either<Failure, List<WorkoutRoutine>>.left(
               DatabaseFailure(e.toString()),
             );
           }
         });
     } catch (e) {
       return Stream.value(
         Either<Failure, List<WorkoutRoutine>>.left(
           DatabaseFailure(e.toString()),
         ),
       );
     }
   }
   ```
   
   **Design Pattern**:
   - **watch()**: Drift's reactive primitive, emits on any table change
   - **asyncMap**: Async transformation for nested data fetching
   - **Either Wrapping**: Stream<Either<F,T>> vs Stream<T> for error propagation
   - **Nested Loading**: Fetch exercises → fetch sets per exercise
   - **Automatic Updates**: UI rebuilds on create/update/delete without manual triggers
   
   **Benefits**:
   - Real-time UI synchronization
   - Zero polling overhead
   - Automatic memory management
   - Multi-listener support
   - Error propagation through stream

3. **Nested Data Fetching Strategy**:
   ```dart
   Future<List<WorkoutExercise>> _fetchExercisesForRoutine(String routineId) async {
     final exerciseDataList = await (database.select(database.exercises)
       ..where((exercise) => exercise.routineId.equals(routineId))
       ..orderBy([(exercise) => OrderingTerm.asc(exercise.sortOrder)]))
       .get();
     
     final exercises = <WorkoutExercise>[];
     for (final exerciseData in exerciseDataList) {
       final setDataList = await (database.select(database.sets)
         ..where((set) => set.exerciseId.equals(exerciseData.id))
         ..orderBy([(set) => OrderingTerm.asc(set.sortOrder)]))
         .get();
       
       final templateSets = setDataList
         .map((setData) => _mapSetDataToEntity(setData))
         .toList();
       
       exercises.add(_mapExerciseDataToEntity(exerciseData, templateSets));
     }
     return exercises;
   }
   ```
   
   **Design Choice**:
   - **N+1 Queries vs JOIN**: Explicit queries over complex JOIN mapping
   - **Rationale**: Type-safe mapping, clear data flow, easier debugging
   - **Performance**: Acceptable for typical routine sizes (<20 exercises)
   - **Future Optimization**: Drift supports JOINs if needed
   - **sortOrder Enforcement**: Database-level ordering ensures consistency

### Mapping Strategy

**Architecture Pattern**: Strict boundary between Drift Data Classes and Domain Entities

**Implementation**: Private mapper methods in repository

**Design Philosophy**:

1. **Unidirectional Mapping**:
   ```dart
   // Drift Data → Domain Entity
   WorkoutRoutine _mapRoutineDataToEntity(RoutineData data, List<WorkoutExercise> exercises) {
     return WorkoutRoutine(
       id: data.id,
       name: data.name,
       sortOrder: data.sortOrder,
       exercises: exercises,
     );
   }
   
   // Domain Entity → Drift Companion (for inserts)
   RoutinesCompanion.insert(
     id: routine.id,
     name: routine.name,
     sortOrder: routine.sortOrder,
   )
   ```
   
   **Rationale**:
   - **Domain Purity**: Entities never import Drift types
   - **Single Responsibility**: Mapping logic isolated in repository
   - **Testability**: Mock mappers independently
   - **Change Insulation**: Database schema changes don't affect domain

2. **Five Private Mappers** (One per entity):
   - `_mapRoutineDataToEntity(RoutineData, List<WorkoutExercise>) → WorkoutRoutine`
   - `_mapExerciseDataToEntity(ExerciseData, List<WorkoutSet>) → WorkoutExercise`
   - `_mapSetDataToEntity(SetData) → WorkoutSet`
   - `_mapSessionDataToEntity(SessionData) → WorkoutSession`
   - `_mapSetLogDataToEntity(SetLogData) → SetLog`
   
   **Design Pattern**:
   - Private visibility (implementation detail)
   - Stateless functions (pure transformations)
   - Explicit parameters (no hidden dependencies)
   - Type-safe (compile errors on schema changes)

3. **Companion Object Pattern** (Inserts/Updates):
   ```dart
   ExercisesCompanion.insert(
     id: exercise.id,
     routineId: routine.id,
     name: exercise.name,
     notes: Value(exercise.notes),  // Wrap nullable fields
     restTimeSeconds: exercise.restTimeSeconds,
     sortOrder: exercise.sortOrder,
   )
   ```
   
   **Design Feature**:
   - **Type Safety**: Companion enforces required vs optional fields
   - **Value Wrapper**: Explicit handling of nullable database fields
   - **Validation**: Drift validates constraints at compile time
   - **Clarity**: Insert vs update intent explicit in code

**Benefits**:
- Domain layer remains framework-agnostic
- Database changes isolated to repository
- Clear transformation points for debugging
- Easy to add computed fields or validation
- Type system prevents mapping errors

### Error Handling Strategy

**Pattern**: Convert database exceptions to domain failures

**Implementation**:
```dart
try {
  // Drift operation
  return Either<Failure, T>.right(result);
} catch (e) {
  return Either<Failure, T>.left(DatabaseFailure(e.toString()));
}
```

**Design Guarantees**:
- Repository never throws exceptions
- All errors converted to Either<Failure, T>
- Presentation layer handles failures uniformly
- Database details hidden from domain

### Performance Characteristics

**Query Optimization**:
- Indexed foreign keys for fast joins
- orderBy clauses for sorted results
- where clauses for filtered queries
- Single transaction for atomic operations

**Memory Management**:
- Stream-based loading prevents full dataset in memory
- Lazy evaluation of nested entities
- Drift's connection pooling
- Automatic statement caching

**Scalability**:
- Suitable for 1000+ routines without pagination
- N+1 query pattern acceptable for <100 exercises per routine
- Transaction overhead negligible for <500 sets per save
- Watch streams scale with subscriber count

## Dependency Injection

**Technology**: Get_It (Service Locator pattern)

**Implementation**: `lib/core/di/injection_container.dart`

**Structure**:
```dart
final serviceLocator = GetIt.instance;

Future<void> initialize() async {
  await _initializeCore();
  await _initializeFeatures();
}
```

**Rationale**:
- Loose coupling between layers
- Easy mocking for unit tests
- Centralized dependency configuration
- Supports lazy and eager initialization

**Pattern**:
- Database registered as lazy singleton
- Repositories registered as singletons
- Use cases registered as factories (stateless)
- BLoCs/Cubits registered as factories (stateful)

**Phase 3 Registrations**:
```dart
// Database (single instance)
serviceLocator.registerLazySingleton<AppDatabase>(() => AppDatabase());

// Repository (single instance, depends on database)
serviceLocator.registerLazySingleton<WorkoutRepository>(
  () => WorkoutRepositoryImpl(serviceLocator()),
);

// Use cases (new instance per call)
serviceLocator.registerFactory(() => WatchRoutinesUseCase(serviceLocator()));
serviceLocator.registerFactory(() => SaveRoutineUseCase(serviceLocator()));
// ... 7 more use cases
```

## Testing Strategy

### Unit Tests
- Domain layer: Use cases, entities
- Data layer: Repository implementations, models
- Mocking with Mockito

### Widget Tests
- Presentation layer widgets
- BLoC state transitions
- UI interactions

### Integration Tests
- End-to-end user flows
- Database operations
- Navigation

## Code Quality Standards

1. **No Comments**: Code must be self-documenting
2. **Naming**: Highly descriptive names over brevity
3. **Function Length**: Maximum 20 lines per function
4. **Class Responsibility**: Single Responsibility Principle enforced
5. **Immutability**: Using Freezed for domain entities and data models to ensure thread-safety and predictable state transitions
6. **Test Coverage**: Minimum 80% for domain and data layers

## Future Considerations

- **Navigation**: Named routes with Go Router
- **Offline Sync**: Event sourcing for workout history
- **CI/CD**: GitHub Actions for automated testing and deployment
- **Analytics**: Privacy-first telemetry with local-only aggregation

## Resources

- [Clean Architecture - Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Architecture Samples](https://github.com/brianegan/flutter_architecture_samples)
- [FlexColorScheme Documentation](https://docs.flexcolorscheme.com/)