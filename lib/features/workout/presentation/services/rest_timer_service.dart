import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class RestTimerService extends ChangeNotifier {
  int? _remainingSeconds;
  int? _totalSeconds;
  Timer? _timer;

  int? get remainingSeconds => _remainingSeconds;
  int? get totalSeconds => _totalSeconds;
  bool get isActive => _remainingSeconds != null;

  double get progress {
    if (_totalSeconds == null || _totalSeconds == 0) return 0.0;
    return (_totalSeconds! - (_remainingSeconds ?? 0)) / _totalSeconds!;
  }

  void start(int seconds) {
    _timer?.cancel();
    _remainingSeconds = seconds;
    _totalSeconds = seconds;
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  void addSeconds(int extra) {
    if (_remainingSeconds != null && _totalSeconds != null) {
      _remainingSeconds = _remainingSeconds! + extra;
      _totalSeconds = _totalSeconds! + extra;
      notifyListeners();
    }
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _remainingSeconds = null;
    _totalSeconds = null;
    notifyListeners();
  }

  void _tick(Timer timer) {
    if (_remainingSeconds != null && _remainingSeconds! > 0) {
      _remainingSeconds = _remainingSeconds! - 1;
      if (_remainingSeconds == 0) {
        stop();
        HapticFeedback.vibrate();
      } else {
        notifyListeners();
      }
    } else {
      stop();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
