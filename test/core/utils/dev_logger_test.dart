import 'package:flutter_test/flutter_test.dart';

import 'package:muscleup/core/utils/dev_logger.dart';

void main() {
  setUp(() {
    DevLogger.instance.clear();
  });

  test('keeps the buffer bounded on a long session', () {
    for (var index = 0; index < 1000; index++) {
      appLog('event $index');
    }

    expect(DevLogger.instance.logs.length, lessThanOrEqualTo(300));
  });

  test('drops the oldest lines and keeps the most recent ones', () {
    for (var index = 0; index < 1000; index++) {
      appLog('event $index');
    }

    final logs = DevLogger.instance.logs;

    expect(logs.last, contains('event 999'));
    expect(logs.any((line) => line.contains('event 0')), isFalse);
  });

  test('does not trim while under the cap', () {
    for (var index = 0; index < 10; index++) {
      appLog('event $index');
    }

    expect(DevLogger.instance.logs.length, 10);
    expect(DevLogger.instance.logs.first, contains('event 0'));
  });
}
