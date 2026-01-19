import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

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

  static const Color darkModeMidnightBase = Color(0xFF0A0E27);
  static const Color darkModeDeepBlueBackground = Color(0xFF121829);
  static const Color darkModeSurfaceElevated = Color(0xFF1A2138);
  static const Color darkModeVoltGreenAccent = Color(0xFF39FF14);
  static const Color darkModeVoltGreenAccentVariant = Color(0xFF2ECC11);

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

  static ThemeData lightThemeData = FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: lightModeDeepCharcoalAccent,
      primaryContainer: lightModeCharcoalVariant,
      secondary: lightModeDeepCharcoalAccent,
      secondaryContainer: Color(0xFF5D6D7E),
      tertiary: Color(0xFF3498DB),
      tertiaryContainer: Color(0xFF5DADE2),
      appBarColor: lightModeCharcoalVariant,
      error: Color(0xFFE74C3C),
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
    keyColors: const FlexKeyColors(useSecondary: true, useTertiary: true),
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

  static ThemeData darkThemeData = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: darkModeVoltGreenAccent,
      primaryContainer: darkModeVoltGreenAccentVariant,
      secondary: Color(0xFF00D9FF),
      secondaryContainer: Color(0xFF00B8D4),
      tertiary: Color(0xFFBB86FC),
      tertiaryContainer: Color(0xFF985EFF),
      appBarColor: darkModeVoltGreenAccentVariant,
      error: Color(0xFFCF6679),
    ),
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    darkIsTrueBlack: false,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 25,
      blendOnColors: true,
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
      inputDecoratorUnfocusedBorderIsColored: true,
      cardElevation: cardElevationMedium,
      cardRadius: radiusLarge,
      elevatedButtonElevation: 2.0,
      elevatedButtonSchemeColor: SchemeColor.primary,
      filledButtonSchemeColor: SchemeColor.primary,
      chipRadius: radiusMedium,
      chipBlendColors: true,
      bottomNavigationBarElevation: 8.0,
      navigationBarElevation: 4.0,
      navigationBarHeight: 72.0,
      navigationBarLabelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      appBarCenterTitle: true,
      appBarScrolledUnderElevation: 4.0,
    ),
    keyColors: const FlexKeyColors(useSecondary: true, useTertiary: true),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    fontFamily: GoogleFonts.inter().fontFamily,
  ).copyWith(
    scaffoldBackgroundColor: darkModeMidnightBase,
    colorScheme: FlexThemeData.dark(
      colors: const FlexSchemeColor(
        primary: darkModeVoltGreenAccent,
        primaryContainer: darkModeVoltGreenAccentVariant,
        secondary: Color(0xFF00D9FF),
        secondaryContainer: Color(0xFF00B8D4),
        tertiary: Color(0xFFBB86FC),
        tertiaryContainer: Color(0xFF985EFF),
        appBarColor: darkModeVoltGreenAccentVariant,
        error: Color(0xFFCF6679),
      ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 15,
      darkIsTrueBlack: false,
      useMaterial3: true,
    ).colorScheme.copyWith(
          surface: darkModeDeepBlueBackground,
          surfaceContainerLowest: darkModeMidnightBase,
          surfaceContainerLow: darkModeDeepBlueBackground,
          surfaceContainer: darkModeSurfaceElevated,
          surfaceContainerHigh: const Color(0xFF222B45),
          surfaceContainerHighest: const Color(0xFF2A3552),
        ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );
}
