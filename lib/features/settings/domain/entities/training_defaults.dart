class TrainingDefaults {
  const TrainingDefaults({
    required this.defaultRestSeconds,
    required this.defaultRepetitions,
    required this.defaultWeight,
    required this.updatedAt,
  });

  factory TrainingDefaults.fallback() {
    return TrainingDefaults(
      defaultRestSeconds: defaultRestSecondsFallback,
      defaultRepetitions: defaultRepetitionsFallback,
      defaultWeight: defaultWeightFallback,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  static const int defaultRestSecondsFallback = 120;
  static const int defaultRepetitionsFallback = 12;
  static const double? defaultWeightFallback = null;

  final int? defaultRestSeconds;
  final int? defaultRepetitions;
  final double? defaultWeight;
  final DateTime updatedAt;

  TrainingDefaults copyWith({
    int? defaultRestSeconds,
    int? defaultRepetitions,
    double? defaultWeight,
    DateTime? updatedAt,
    bool clearDefaultRestSeconds = false,
    bool clearDefaultRepetitions = false,
    bool clearDefaultWeight = false,
  }) {
    return TrainingDefaults(
      defaultRestSeconds: clearDefaultRestSeconds
          ? null
          : (defaultRestSeconds ?? this.defaultRestSeconds),
      defaultRepetitions: clearDefaultRepetitions
          ? null
          : (defaultRepetitions ?? this.defaultRepetitions),
      defaultWeight:
          clearDefaultWeight ? null : (defaultWeight ?? this.defaultWeight),
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
