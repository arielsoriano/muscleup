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
    switch (this) {
      case AppSkin.volt:
        return const Color(0xFFCCFF00);
      case AppSkin.cyan:
        return const Color(0xFF00D8FF);
      case AppSkin.crimson:
        return const Color(0xFFFF3B5C);
      case AppSkin.royalGold:
        return const Color(0xFFF2C94C);
      case AppSkin.monochrome:
        return const Color(0xFF9EA7B8);
    }
  }

  Color get primaryContainer {
    switch (this) {
      case AppSkin.volt:
        return const Color(0xFFB8E600);
      case AppSkin.cyan:
        return const Color(0xFF6DEBFF);
      case AppSkin.crimson:
        return const Color(0xFFFF8AA0);
      case AppSkin.royalGold:
        return const Color(0xFFF8DB86);
      case AppSkin.monochrome:
        return const Color(0xFFC5CBD6);
    }
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
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkCardBackground = Color(0xFF1E1E1E);
  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color lightCardBackground = Color(0xFFFFFFFF);

  static const double cardElevationLow = 2.0;
  static const double cardElevationMedium = 4.0;
  static const double cardElevationHigh = 8.0;

  static const double buttonBorderRadiusRounded = 16.0;
  static const double inputBorderRadiusRounded = 12.0;

  static ThemeData getTheme({
    required AppSkin skin,
    required bool isDarkMode,
  }) {
    return _buildTheme(skin: skin, isDarkMode: isDarkMode);
  }

  static ThemeData _buildTheme({
    required AppSkin skin,
    required bool isDarkMode,
  }) {
    final accent = skin.primaryColor;
    final accentContainer = skin.primaryContainer;
    final isAccentLight = accent.computeLuminance() > 0.45;
    final onAccent = isAccentLight ? pureBlack : pureWhite;
    final onAccentContainer = accentContainer.computeLuminance() > 0.45
        ? pureBlack
        : pureWhite;
    final brightness = isDarkMode ? Brightness.dark : Brightness.light;
    final surface = isDarkMode ? darkCardBackground : lightCardBackground;
    final scaffold = isDarkMode ? darkBackground : lightBackground;
    final onSurface = isDarkMode ? pureWhite : const Color(0xFF101418);
    final borderColor = isDarkMode
        ? const Color(0xFF333333)
        : const Color(0xFFD0D6E0);

    final baseTextTheme = ThemeData(brightness: brightness).textTheme.apply(
      fontFamily: 'monospace',
    );

    final textTheme = baseTextTheme.copyWith(
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        color: onSurface,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        color: onSurface,
        fontWeight: FontWeight.w700,
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        color: onSurface,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        color: onSurface,
        fontWeight: FontWeight.w800,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        color: onSurface,
        fontWeight: FontWeight.w800,
      ),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(
        color: onSurface,
        fontWeight: FontWeight.w900,
      ),
    );

    final colorScheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: brightness,
    ).copyWith(
      primary: accent,
      onPrimary: onAccent,
      primaryContainer: accentContainer,
      onPrimaryContainer: onAccentContainer,
      secondary: accent,
      onSecondary: onAccent,
      surface: surface,
      onSurface: onSurface,
      error: const Color(0xFFFF5A5A),
      onError: pureBlack,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffold,
      canvasColor: scaffold,
      cardColor: surface,
      appBarTheme: AppBarTheme(
        backgroundColor: scaffold,
        foregroundColor: onSurface,
        centerTitle: true,
        elevation: 0,
      ),
      textTheme: textTheme,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: onAccent,
          textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonBorderRadiusRounded),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: onAccent,
          textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonBorderRadiusRounded),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: onAccent,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: accent,
        linearTrackColor: Color(0xFF2A2A2A),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: cardElevationLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        labelStyle: TextStyle(color: onSurface, fontWeight: FontWeight.w700),
        hintStyle: TextStyle(
          color: onSurface.withValues(alpha: 0.65),
          fontWeight: FontWeight.w600,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputBorderRadiusRounded),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputBorderRadiusRounded),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputBorderRadiusRounded),
          borderSide: BorderSide(color: accent, width: 2),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: accent,
        contentTextStyle: TextStyle(
          color: onAccent,
          fontWeight: FontWeight.w800,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  static ThemeData lightThemeData = _buildTheme(
    skin: AppSkin.volt,
    isDarkMode: false,
  );

  static ThemeData darkThemeData = _buildTheme(
    skin: AppSkin.volt,
    isDarkMode: true,
  );
}
