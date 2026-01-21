import 'package:flutter/material.dart';

extension BuildContextSnackBarExtension on BuildContext {
  void showAppSnackBar(String message, {bool isError = false}) {
    final colorScheme = Theme.of(this).colorScheme;

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: isError
                ? colorScheme.onErrorContainer
                : colorScheme.onSecondaryContainer,
          ),
        ),
        backgroundColor: isError
            ? colorScheme.errorContainer
            : colorScheme.secondaryContainer,
      ),
    );
  }
}

extension DoubleFormattingExtension on double {
  String formatClean() {
    if (this == toInt()) {
      return toInt().toString();
    }
    return toString();
  }
}
