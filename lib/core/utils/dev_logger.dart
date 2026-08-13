import 'package:flutter/foundation.dart';

class DevLogger {
  static final DevLogger instance = DevLogger._();
  DevLogger._();

  /// Keeps the buffer bounded: plenty of room for a full sign-in flow, while a
  /// long-running session can no longer grow it indefinitely. Oldest lines are
  /// dropped first, so the tail — where a failure just happened — is kept.
  static const int _maxRetainedLogs = 300;

  final List<String> _logs = [];

  List<String> get logs => List.unmodifiable(_logs);

  void log(String message) {
    final timestamp = DateTime.now().toIso8601String().split('T').last.substring(0, 8);
    final formattedMsg = '[$timestamp] $message';
    _logs.add(formattedMsg);

    if (_logs.length > _maxRetainedLogs) {
      _logs.removeRange(0, _logs.length - _maxRetainedLogs);
    }

    debugPrint(formattedMsg);
  }

  void clear() {
    _logs.clear();
  }
}

void appLog(String message) {
  DevLogger.instance.log(message);
}
