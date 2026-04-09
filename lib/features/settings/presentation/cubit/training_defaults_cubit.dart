import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/entities/cloud_user.dart';
import '../../../auth/domain/repositories/cloud_auth_repository.dart';
import '../../data/training_defaults_repository.dart';
import '../../domain/entities/training_defaults.dart';

class TrainingDefaultsState {
  const TrainingDefaultsState({
    required this.defaults,
    required this.isLoading,
    required this.isSaving,
    required this.errorMessage,
  });

  factory TrainingDefaultsState.initial() {
    return TrainingDefaultsState(
      defaults: TrainingDefaults.fallback(),
      isLoading: true,
      isSaving: false,
      errorMessage: null,
    );
  }

  final TrainingDefaults defaults;
  final bool isLoading;
  final bool isSaving;
  final String? errorMessage;

  TrainingDefaultsState copyWith({
    TrainingDefaults? defaults,
    bool? isLoading,
    bool? isSaving,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TrainingDefaultsState(
      defaults: defaults ?? this.defaults,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class TrainingDefaultsCubit extends Cubit<TrainingDefaultsState> {
  TrainingDefaultsCubit(this._repository, this._cloudAuthRepository)
      : super(TrainingDefaultsState.initial()) {
    _initialize();
  }

  final TrainingDefaultsRepository _repository;
  final CloudAuthRepository _cloudAuthRepository;

  StreamSubscription<CloudUser?>? _authSubscription;
  String? _linkedUid;

  Future<void> _initialize() async {
    final localDefaults = await _repository.getLocalDefaults();
    emit(state.copyWith(defaults: localDefaults, isLoading: false, clearError: true));

    _authSubscription = _cloudAuthRepository.watchAuthState().listen((user) {
      final linked = user != null && !user.isAnonymous;
      _linkedUid = linked ? user.uid : null;
      if (linked) {
        unawaited(_syncWithCloud(user.uid));
      }
    });
  }

  Future<void> updateDefaults({
    int? defaultRestSeconds,
    int? defaultRepetitions,
    double? defaultWeight,
  }) async {
    final updatedDefaults = state.defaults.copyWith(
      defaultRestSeconds: defaultRestSeconds,
      defaultRepetitions: defaultRepetitions,
      defaultWeight: defaultWeight,
      updatedAt: DateTime.now(),
    );

    emit(state.copyWith(isSaving: true, clearError: true));

    try {
      await _repository.saveLocalDefaults(updatedDefaults);
      emit(state.copyWith(defaults: updatedDefaults, isSaving: false));

      final uid = _linkedUid;
      if (uid != null && uid.isNotEmpty) {
        await _repository.pushDefaultsToCloud(uid, updatedDefaults);
      }
    } catch (error) {
      emit(state.copyWith(isSaving: false, errorMessage: error.toString()));
    }
  }

  Future<void> _syncWithCloud(String uid) async {
    try {
      final localDefaults = await _repository.getLocalDefaults();
      final remoteDefaults = await _repository.fetchDefaultsFromCloud(uid);

      if (remoteDefaults == null) {
        await _repository.pushDefaultsToCloud(uid, localDefaults);
        return;
      }

      // After reinstall, local defaults may still be untouched seed values.
      // In that case, prefer cloud values even if local timestamp is newer.
      if (_isFallbackDefaults(localDefaults)) {
        await _repository.saveLocalDefaults(remoteDefaults);
        emit(state.copyWith(defaults: remoteDefaults, clearError: true));
        return;
      }

      if (remoteDefaults.updatedAt.isAfter(localDefaults.updatedAt)) {
        await _repository.saveLocalDefaults(remoteDefaults);
        emit(state.copyWith(defaults: remoteDefaults, clearError: true));
        return;
      }

      if (localDefaults.updatedAt.isAfter(remoteDefaults.updatedAt)) {
        await _repository.pushDefaultsToCloud(uid, localDefaults);
      }
    } catch (_) {
      // Keep local defaults available even if cloud sync fails.
    }
  }

  bool _isFallbackDefaults(TrainingDefaults defaults) {
    return defaults.defaultRestSeconds ==
            TrainingDefaults.defaultRestSecondsFallback &&
        defaults.defaultRepetitions ==
            TrainingDefaults.defaultRepetitionsFallback &&
        defaults.defaultWeight == TrainingDefaults.defaultWeightFallback;
  }

  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    return super.close();
  }
}
