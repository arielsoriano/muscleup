class TrainingDefaults {
  const TrainingDefaults({
    required this.defaultRestSeconds,
    required this.defaultRepetitions,
    required this.defaultWeight,
    required this.updatedAt,
  });

  static const int defaultRestSecondsFallback = 60;
  static const int defaultRepetitionsFallback = 10;
  static const double defaultWeightFallback = 20;

  factory TrainingDefaults.fallback() {
    return TrainingDefaults(
      defaultRestSeconds: defaultRestSecondsFallback,
      defaultRepetitions: defaultRepetitionsFallback,
      defaultWeight: defaultWeightFallback,
      updatedAt: DateTime.now(),
    );
  }

  final int defaultRestSeconds;
  final int defaultRepetitions;
  final double defaultWeight;
  final DateTime updatedAt;

  TrainingDefaults copyWith({
    int? defaultRestSeconds,
    int? defaultRepetitions,
    double? defaultWeight,
    DateTime? updatedAt,
  }) {
    return TrainingDefaults(
      defaultRestSeconds: defaultRestSeconds ?? this.defaultRestSeconds,
      defaultRepetitions: defaultRepetitions ?? this.defaultRepetitions,
      defaultWeight: defaultWeight ?? this.defaultWeight,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
