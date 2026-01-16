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