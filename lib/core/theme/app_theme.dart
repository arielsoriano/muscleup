import 'package:flutter/material.dart';

enum AppSkin {
  volt,
  cyan,
  crimson,
  royalGold,
  monochrome,
}

extension AppSkinExtension on AppSkin {
  Color get primaryColor {
    return const Color(0xFFCCFF00);
  }

  Color get primaryContainer {
    return const Color(0xFFB8E600);
  }

  String get name {
    switch (this) {
      case AppSkin.volt:
        return 'volt';
      case AppSkin.cyan:
        return 'cyan';
      case AppSkin.crimson:
        return 'crimson';
      case AppSkin.royalGold:
        return 'royalGold';
      case AppSkin.monochrome:
        return 'monochrome';
    }
  }

  static AppSkin fromString(String value) {
    return AppSkin.values.firstWhere(
      (skin) => skin.name == value,
      orElse: () => AppSkin.volt,
    );
  }
}

class AppTheme {
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;

  static const double iconSizeSmall = 20.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;

  static const Color voltAccent = Color(0xFFCCFF00);
  static const Color globalBackground = Color(0xFF121212);
  static const Color pureBlack = Color(0xFF000000);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFF1E1E1E);

  static const double cardElevationLow = 2.0;
  static const double cardElevationMedium = 4.0;
  static const double cardElevationHigh = 8.0;

  static const double buttonBorderRadiusRounded = 16.0;
  static const double inputBorderRadiusRounded = 12.0;

  static ThemeData getTheme({
    required AppSkin skin,
    required bool isDarkMode,
  }) {
    return _getPerformanceTheme();
  }

  static ThemeData _getPerformanceTheme() {
    final baseTextTheme = ThemeData.dark().textTheme.apply(
      fontFamily: 'monospace',
    );

    final textTheme = baseTextTheme.copyWith(
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        color: pureWhite,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        color: pureWhite,
        fontWeight: FontWeight.w700,
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        color: pureWhite,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        color: pureWhite,
        fontWeight: FontWeight.w800,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        color: pureWhite,
        fontWeight: FontWeight.w800,
      ),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(
        color: pureWhite,
        fontWeight: FontWeight.w900,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: voltAccent,
        onPrimary: pureBlack,
        primaryContainer: voltAccent,
        onPrimaryContainer: pureBlack,
        secondary: voltAccent,
        onSecondary: pureBlack,
        secondaryContainer: cardBackground,
        onSecondaryContainer: pureWhite,
        surface: cardBackground,
        onSurface: pureWhite,
        error: Color(0xFFFF5A5A),
        onError: pureBlack,
      ),
      scaffoldBackgroundColor: globalBackground,
      canvasColor: globalBackground,
      cardColor: cardBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: globalBackground,
        foregroundColor: pureWhite,
        centerTitle: true,
        elevation: 0,
      ),
      textTheme: textTheme,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: voltAccent,
          foregroundColor: pureBlack,
          textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonBorderRadiusRounded),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: voltAccent,
          foregroundColor: pureBlack,
          textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonBorderRadiusRounded),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: voltAccent,
        foregroundColor: pureBlack,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: voltAccent,
        linearTrackColor: Color(0xFF2A2A2A),
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: cardElevationLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardBackground,
        labelStyle: const TextStyle(color: pureWhite, fontWeight: FontWeight.w700),
        hintStyle: const TextStyle(color: Color(0xFFBDBDBD), fontWeight: FontWeight.w600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputBorderRadiusRounded),
          borderSide: const BorderSide(color: Color(0xFF333333), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputBorderRadiusRounded),
          borderSide: const BorderSide(color: Color(0xFF333333), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputBorderRadiusRounded),
          borderSide: const BorderSide(color: voltAccent, width: 2),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: voltAccent,
        contentTextStyle: TextStyle(
          color: pureBlack,
          fontWeight: FontWeight.w800,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  static ThemeData lightThemeData = _getPerformanceTheme();

  static ThemeData darkThemeData = _getPerformanceTheme();
}
