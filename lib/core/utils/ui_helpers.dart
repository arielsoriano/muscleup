import 'package:flutter/material.dart';

extension BuildContextSnackBarExtension on BuildContext {
  void showAppSnackBar(String message, {bool isError = false}) {
    final colorScheme = Theme.of(this).colorScheme;
    final brightness = Theme.of(this).brightness;

    final successBackgroundColor = brightness == Brightness.dark
        ? Colors.green[800]!
        : Colors.green[100]!;

    final successTextColor = brightness == Brightness.dark
        ? Colors.green[100]!
        : Colors.green[900]!;

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: isError ? colorScheme.onErrorContainer : successTextColor,
          ),
        ),
        backgroundColor:
            isError ? colorScheme.errorContainer : successBackgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
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
