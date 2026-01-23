import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

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
        return const Color(0xFF00E5FF);
      case AppSkin.crimson:
        return const Color(0xFFFF1744);
      case AppSkin.royalGold:
        return const Color(0xFFFFD700);
      case AppSkin.monochrome:
        return const Color(0xFFFFFFFF);
    }
  }

  Color get primaryContainer {
    switch (this) {
      case AppSkin.volt:
        return const Color(0xFFB8E600);
      case AppSkin.cyan:
        return const Color(0xFF00B8D4);
      case AppSkin.crimson:
        return const Color(0xFFD50000);
      case AppSkin.royalGold:
        return const Color(0xFFFFB300);
      case AppSkin.monochrome:
        return const Color(0xFFE0E0E0);
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

  static const Color darkModeMidnightBase = Color(0xFF000000);
  static const Color darkModeDeepBlueBackground = Color(0xFF0A0A0A);
  static const Color darkModeSurfaceElevated = Color(0xFF161616);
  static const Color darkModeVoltGreenAccent = Color(0xFFDFFF00);
  static const Color darkModeVoltGreenAccentVariant = Color(0xFFC8E600);

  static const Color lightModeSoftWhiteBase = Color(0xFFFAFAFA);
  static const Color lightModeCleanGreyBackground = Color(0xFFF5F5F5);
  static const Color lightModeSurfaceElevated = Color(0xFFFFFFFF);
  static const Color lightModeDeepCharcoalAccent = Color(0xFF2C3E50);
  static const Color lightModeCharcoalVariant = Color(0xFF34495E);

  static const double cardElevationLow = 2.0;
  static const double cardElevationMedium = 4.0;
  static const double cardElevationHigh = 8.0;

  static const double buttonBorderRadiusRounded = 16.0;
  static const double inputBorderRadiusRounded = 12.0;

  static ThemeData getTheme({
    required AppSkin skin,
    required bool isDarkMode,
  }) {
    if (isDarkMode) {
      return _getDarkTheme(skin);
    } else {
      return _getLightTheme(skin);
    }
  }

  static ThemeData _getLightTheme(AppSkin skin) {
    return FlexThemeData.light(
      colors: FlexSchemeColor(
        primary: skin == AppSkin.monochrome
            ? lightModeDeepCharcoalAccent
            : skin.primaryColor,
        primaryContainer: skin == AppSkin.monochrome
            ? lightModeCharcoalVariant
            : skin.primaryContainer,
        secondary: lightModeDeepCharcoalAccent,
        secondaryContainer: const Color(0xFF5D6D7E),
        tertiary: const Color(0xFF3498DB),
        tertiaryContainer: const Color(0xFF5DADE2),
        appBarColor: skin == AppSkin.monochrome
            ? lightModeCharcoalVariant
            : skin.primaryContainer,
        error: const Color(0xFFE74C3C),
      ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 3,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 8,
        blendOnColors: false,
        useMaterial3Typography: true,
        useM2StyleDividerInM3: true,
        defaultRadius: radiusMedium,
        elevatedButtonRadius: buttonBorderRadiusRounded,
        filledButtonRadius: buttonBorderRadiusRounded,
        outlinedButtonRadius: buttonBorderRadiusRounded,
        textButtonRadius: buttonBorderRadiusRounded,
        inputDecoratorRadius: inputBorderRadiusRounded,
        inputDecoratorBorderWidth: 2.0,
        inputDecoratorFocusedBorderWidth: 2.5,
        inputDecoratorUnfocusedBorderIsColored: false,
        cardElevation: cardElevationMedium,
        cardRadius: radiusLarge,
        elevatedButtonElevation: 1.0,
        elevatedButtonSchemeColor: SchemeColor.primary,
        filledButtonSchemeColor: SchemeColor.primary,
        chipRadius: radiusMedium,
        chipBlendColors: true,
        bottomNavigationBarElevation: 4.0,
        navigationBarElevation: 2.0,
        navigationBarHeight: 72.0,
        navigationBarLabelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        appBarCenterTitle: true,
        appBarScrolledUnderElevation: 2.0,
      ),
      keyColors: const FlexKeyColors(
        useKeyColors: false,
        useSecondary: true,
        useTertiary: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
    ).copyWith(
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  static ThemeData _getDarkTheme(AppSkin skin) {
    return FlexThemeData.dark(
      colors: FlexSchemeColor(
        primary: skin.primaryColor,
        primaryContainer: skin.primaryContainer,
        secondary: const Color(0xFF00D9FF),
        secondaryContainer: const Color(0xFF00B8D4),
        tertiary: const Color(0xFFBB86FC),
        tertiaryContainer: const Color(0xFF985EFF),
        appBarColor: skin.primaryContainer,
        error: const Color(0xFFCF6679),
      ),
      surfaceMode: FlexSurfaceMode.level,
      blendLevel: 0,
      darkIsTrueBlack: true,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 0,
        blendOnColors: false,
        useMaterial3Typography: true,
        useM2StyleDividerInM3: true,
        defaultRadius: radiusMedium,
        elevatedButtonRadius: 12.0,
        filledButtonRadius: 12.0,
        outlinedButtonRadius: 12.0,
        textButtonRadius: 12.0,
        inputDecoratorRadius: inputBorderRadiusRounded,
        inputDecoratorBorderWidth: 2.0,
        inputDecoratorFocusedBorderWidth: 2.5,
        inputDecoratorUnfocusedBorderIsColored: false,
        cardElevation: cardElevationMedium,
        cardRadius: 16.0,
        elevatedButtonElevation: 2.0,
        elevatedButtonSchemeColor: SchemeColor.primary,
        filledButtonSchemeColor: SchemeColor.primary,
        chipRadius: radiusMedium,
        chipBlendColors: false,
        bottomNavigationBarElevation: 0.0,
        navigationBarElevation: 0.0,
        navigationBarHeight: 72.0,
        navigationBarLabelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        appBarCenterTitle: true,
        appBarScrolledUnderElevation: 0.0,
      ),
      keyColors: const FlexKeyColors(
        useKeyColors: false,
        useSecondary: true,
        useTertiary: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
    ).copyWith(
      scaffoldBackgroundColor: darkModeMidnightBase,
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  static ThemeData lightThemeData = _getLightTheme(AppSkin.volt);

  static ThemeData darkThemeData = _getDarkTheme(AppSkin.volt);
}
