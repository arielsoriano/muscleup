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
                : colorScheme.onPrimaryContainer,
          ),
        ),
        backgroundColor: isError
            ? colorScheme.errorContainer
            : colorScheme.primaryContainer,
      ),
    );
  }
}
