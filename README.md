# Muscleup

A minimalist, privacy-focused workout tracking application built with Flutter. Open source, ad-free, and designed for lifters who value simplicity and data ownership.

## Features

- **Minimalist UI**: Clean, distraction-free interface focused on tracking workouts efficiently
- **Multi-language Support**: Native internationalization with English and Spanish (EN/ES)
- **Dark/Light Mode**: Adaptive theming with custom color schemes optimized for readability
- **Offline-First**: Local-first architecture ensuring your data remains private and accessible

## Tech Stack

| Category | Technology | Purpose |
|----------|-----------|----------|
| **Framework** | Flutter | Cross-platform mobile development |
| **State Management** | BLoC/Cubit | Predictable state management with separation of concerns |
| **Dependency Injection** | Get_It | Service locator pattern for loose coupling |
| **Theming** | FlexColorScheme | Professional, consistent color schemes |
| **Database** | Drift | Type-safe SQL with reactive queries |
| **Localization** | Native Flutter Localization (ARB) with Custom Context Extensions | Type-safe i18n with ergonomic BuildContext access |
| **Data Modeling** | Freezed | Type-safe data modeling and immutability |

## Project Status

### Phase 1: Foundations & Configuration ✅

- Clean Architecture structure established
- Dependency injection configured
- Theme system with dark/light modes implemented
- Internationalization infrastructure (EN/ES)
- Error handling patterns defined
- Core utilities and constants

### Phase 2: Domain Layer ✅

- Immutable entities with Freezed (WorkoutRoutine, WorkoutExercise, WorkoutSet, WorkoutSession, SetLog)
- WorkoutUnit enum for type-safe unit handling (kilograms, pounds, repetitions, seconds, etc.)
- Flexible unit design supporting weight training, cardio, and bodyweight exercises
- Repository contract with Stream-based reactivity for routines and sessions
- Nine use cases implementing complete workout lifecycle (planning, execution, tracking)
- Complete SOLID compliance with Dependency Inversion
- Session/Log architecture for progress tracking without modifying templates

### Phase 3: Data Layer (Persistence) ✅

- Drift database with 5 relational tables (Routines, Exercises, Sets, Sessions, SetLogs)
- Foreign key cascades ensuring referential integrity
- Type-safe enum mapping (WorkoutUnit as intEnum)
- Transaction-based saving strategy for atomicity
- Reactive SQL queries with Drift's watch() for automatic UI updates
- WorkoutRepositoryImpl with bidirectional data mapping
- Complete error handling with Either<Failure, T> pattern
- Nested data fetching with proper sortOrder enforcement

### Phase 4: Presentation Layer (UI Logic) ✅

- Reactive UI with WorkoutCubit managing routine list state
- Freezed state classes with pattern matching (initial, loading, success, error)
- Type-safe navigation with GoRouter and parameterized routes
- Custom Material 3 transitions with fade animations
- BlocProvider/BlocBuilder pattern isolating UI from business logic
- Automatic UI updates via Stream subscription to domain use cases
- Error recovery with retry functionality
- Full Material 3 component integration (Card, ListTile, FilledButton)
- Localized UI with empty states and error messages
- Memory-safe Stream management with proper disposal

## Getting Started

### Prerequisites

- Flutter SDK 3.0+
- Dart 3.0+

### Installation

```bash
git clone https://github.com/yourusername/muscleup.git
cd muscleup
flutter pub get
flutter run
```

### Code Quality

```bash
flutter analyze
flutter test
```

## Architecture

Muscleup follows Clean Architecture principles with MVVM presentation pattern. See [ARCHITECTURE.md](ARCHITECTURE.md) for detailed documentation.

## Contributing

This project follows strict code quality standards:

- No comments (self-documenting code only)
- Comprehensive naming conventions
- Test coverage required for all features
- Clean Architecture boundaries enforced

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

GPL v3 - See [LICENSE](LICENSE) for details.

## Acknowledgments

Built with privacy and simplicity in mind. No analytics, no ads, no compromises.