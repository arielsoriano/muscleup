import 'package:flutter/foundation.dart';

class DevLogger {
  static final DevLogger instance = DevLogger._();
  DevLogger._();

  final List<String> _logs = [];

  List<String> get logs => List.unmodifiable(_logs);

  void log(String message) {
    final timestamp = DateTime.now().toIso8601String().split('T').last.substring(0, 8);
    final formattedMsg = '[$timestamp] $message';
    _logs.add(formattedMsg);
    debugPrint(formattedMsg);
  }

  void clear() {
    _logs.clear();
  }
}

void appLog(String message) {
  DevLogger.instance.log(message);
}
