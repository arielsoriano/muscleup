import 'package:flutter/material.dart';

/// Enum to define different types of snackbar messages
enum SnackBarType {
  success,
  error,
  info,
}

extension BuildContextSnackBarExtension on BuildContext {
  static const EdgeInsets _defaultSnackBarMargin = EdgeInsets.only(
    bottom: 100,
    left: 20,
    right: 20,
  );

  /// Unified snackbar method that respects the app theme and selected skin
  /// 
  /// Uses the actual theme colors (primary, error) instead of hardcoded values,
  /// ensuring the snackbar automatically adapts to the selected app skin
  void showAppSnackBar({
    required String message,
    SnackBarType type = SnackBarType.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    final colorScheme = Theme.of(this).colorScheme;

    // Use theme colors that respect the selected app skin
    final (backgroundColor, textColor) = switch (type) {
      SnackBarType.success => (
        colorScheme.primary,
        colorScheme.onPrimary,
      ),
      SnackBarType.error => (
        colorScheme.errorContainer,
        colorScheme.onErrorContainer,
      ),
      SnackBarType.info => (
        colorScheme.primary,
        colorScheme.onPrimary,
      ),
    };

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: _defaultSnackBarMargin,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: duration,
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
