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
   @freezed
   class WorkoutSet with _$WorkoutSet {
     const factory WorkoutSet({
       required String id,
       required int sortOrder,
       double? targetValue1,
       double? targetValue2,
       String? unit1,
       String? unit2,
     }) = _WorkoutSet;
   }
   ```
   
   **Design Philosophy**:
   - **Universal Flexibility**: Single entity supports multiple workout types
   - **Weight Training**: `targetValue1=weight, unit1='kg', targetValue2=reps, unit2='reps'`
   - **Cardio (Time)**: `targetValue1=duration, unit1='seconds'`
   - **Cardio (Distance)**: `targetValue1=distance, unit1='km', targetValue2=time, unit2='seconds'`
   - **Bodyweight**: `targetValue1=reps, unit1='reps'`
   - **Scalability**: No schema changes needed for new workout types
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
   ```
   
   **Design Extension**:
   - Mirrors UseCase pattern for consistency
   - Enables reactive data flows through architecture layers
   - Stream management encapsulated at domain boundary
   - BLoCs consume streams without knowing data source

**Implemented Use Cases**:

| Use Case | Type | Purpose | Parameters |
|----------|------|---------|------------|
| **WatchRoutinesUseCase** | Stream | Real-time routine list updates | None |
| **GetRoutineByIdUseCase** | Future | Single routine retrieval | id: String |
| **SaveRoutineUseCase** | Future | Create or update routine | routine: WorkoutRoutine |
| **DeleteRoutineUseCase** | Future | Remove routine | id: String |
| **UpdateRoutineOrderUseCase** | Future | Persist drag-and-drop changes | routines: List<WorkoutRoutine> |

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
- Repositories registered as singletons
- Use cases registered as factories (stateless)
- BLoCs/Cubits registered as factories (stateful)

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