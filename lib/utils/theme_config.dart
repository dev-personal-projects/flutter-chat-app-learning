// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:chatapp/constant/app_colors.dart';
import 'package:chatapp/constant/app_typography.dart';

/// Theme Configuration Utility
/// Provides light and dark theme configurations for the app
class ThemeConfig {
  ThemeConfig._(); // Private constructor to prevent instantiation

  /// Light Theme Configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        // Primary colors
        primary: AppColors.primary,
        onPrimary: AppColors.lightOnPrimary,
        primaryContainer: AppColors.lightPrimaryContainer,
        onPrimaryContainer: AppColors.primary300,

        // Secondary colors
        secondary: AppColors.secondary,
        onSecondary: AppColors.lightOnSecondary,
        secondaryContainer: AppColors.lightSecondaryContainer,
        onSecondaryContainer: AppColors.secondaryTeal400,

        // Tertiary colors (using light green as tertiary)
        tertiary: AppColors.secondaryGreen300,
        onTertiary: AppColors.primary300,
        tertiaryContainer: AppColors.secondaryGreen100,
        onTertiaryContainer: AppColors.primary300,

        // Error colors
        error: AppColors.lightError,
        onError: AppColors.lightOnError,
        errorContainer: AppColors.danger50,
        onErrorContainer: AppColors.danger400,

        // Surface colors
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightOnSurface,
        surfaceVariant: AppColors.lightSurfaceVariant,
        onSurfaceVariant: AppColors.neutral700,

        // Background colors
        background: AppColors.lightBackground,
        onBackground: AppColors.lightOnBackground,

        // Outline colors
        outline: AppColors.neutral400,
        outlineVariant: AppColors.neutral200,

        // Shadow
        shadow: AppColors.primary500.withValues(alpha: 0.3),
        scrim: AppColors.primary500.withValues(alpha: 0.5),

        // Inverse colors
        inverseSurface: AppColors.primary300,
        onInverseSurface: AppColors.neutral0,
        inversePrimary: AppColors.secondaryTeal200,
      ),

      // Scaffold theme
      scaffoldBackgroundColor: AppColors.lightBackground,

      // AppBar theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.secondaryTeal300,
        foregroundColor: AppColors.lightOnPrimary,
        titleTextStyle: AppTypography.titleLarge(
          color: AppColors.lightOnPrimary,
          fontWeight: AppTypography.fontWeightSemiBold,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.lightOnPrimary,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.lightSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Input decoration theme (for TextFields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.neutral300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.neutral300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.secondary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightError, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: AppTypography.bodyMedium(
          color: AppColors.neutral500,
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.lightOnSecondary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.labelLarge(
            fontWeight: AppTypography.fontWeightSemiBold,
          ),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.secondary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: AppTypography.labelLarge(
            fontWeight: AppTypography.fontWeightSemiBold,
          ),
        ),
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.primary300,
      ),

      // Text theme
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge(),
        displayMedium: AppTypography.displayMedium(),
        displaySmall: AppTypography.displaySmall(),
        headlineLarge: AppTypography.headlineLarge(),
        headlineMedium: AppTypography.headlineMedium(),
        headlineSmall: AppTypography.headlineSmall(),
        titleLarge: AppTypography.titleLarge(),
        titleMedium: AppTypography.titleMedium(),
        titleSmall: AppTypography.titleSmall(),
        bodyLarge: AppTypography.bodyLarge(),
        bodyMedium: AppTypography.bodyMedium(),
        bodySmall: AppTypography.bodySmall(),
        labelLarge: AppTypography.labelLarge(),
        labelMedium: AppTypography.labelMedium(),
        labelSmall: AppTypography.labelSmall(),
      ),

      // Drawer theme
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
      ),

      // Divider theme
      dividerTheme: const  DividerThemeData(
        color: AppColors.neutral200,
        thickness: 1,
        space: 1,
      ),
    );
  }

  /// Dark Theme Configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        // Primary colors
        primary: AppColors.secondaryTeal200,
        onPrimary: AppColors.darkOnPrimary,
        primaryContainer: AppColors.darkPrimaryContainer,
        onPrimaryContainer: AppColors.neutral0,

        // Secondary colors
        secondary: AppColors.secondaryTeal300,
        onSecondary: AppColors.darkOnSecondary,
        secondaryContainer: AppColors.darkSecondaryContainer,
        onSecondaryContainer: AppColors.secondaryTeal100,

        // Tertiary colors
        tertiary: AppColors.secondaryGreen200,
        onTertiary: AppColors.primary300,
        tertiaryContainer: AppColors.secondaryGreen400,
        onTertiaryContainer: AppColors.neutral0,

        // Error colors
        error: AppColors.darkError,
        onError: AppColors.darkOnError,
        errorContainer: AppColors.danger400,
        onErrorContainer: AppColors.danger100,

        // Surface colors
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkOnSurface,
        surfaceVariant: AppColors.darkSurfaceVariant,
        onSurfaceVariant: AppColors.neutral300,

        // Background colors
        background: AppColors.darkBackground,
        onBackground: AppColors.darkOnBackground,

        // Outline colors
        outline: AppColors.neutral600,
        outlineVariant: AppColors.neutral700,

        // Shadow
        shadow: AppColors.primary500.withValues(alpha: 0.8),
        scrim: AppColors.primary500.withValues(alpha: 0.9),

        // Inverse colors
        inverseSurface: AppColors.neutral100,
        onInverseSurface: AppColors.primary300,
        inversePrimary: AppColors.secondaryTeal300,
      ),

      // Scaffold theme
      scaffoldBackgroundColor: AppColors.darkBackground,

      // AppBar theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primary300,
        foregroundColor: AppColors.darkOnSurface,
        titleTextStyle: AppTypography.titleLarge(
          color: AppColors.darkOnSurface,
          fontWeight: AppTypography.fontWeightSemiBold,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.darkOnSurface,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.darkSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.neutral600),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.neutral600),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.secondaryTeal200, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkError, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: AppTypography.bodyMedium(
          color: AppColors.neutral400,
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.secondaryTeal300,
          foregroundColor: AppColors.darkOnSecondary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.labelLarge(
            fontWeight: AppTypography.fontWeightSemiBold,
          ),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.secondaryTeal200,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: AppTypography.labelLarge(
            fontWeight: AppTypography.fontWeightSemiBold,
          ),
        ),
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.neutral0,
      ),

      // Text theme
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge(color: AppColors.neutral0),
        displayMedium: AppTypography.displayMedium(color: AppColors.neutral0),
        displaySmall: AppTypography.displaySmall(color: AppColors.neutral0),
        headlineLarge: AppTypography.headlineLarge(color: AppColors.neutral0),
        headlineMedium: AppTypography.headlineMedium(color: AppColors.neutral0),
        headlineSmall: AppTypography.headlineSmall(color: AppColors.neutral0),
        titleLarge: AppTypography.titleLarge(color: AppColors.neutral0),
        titleMedium: AppTypography.titleMedium(color: AppColors.neutral0),
        titleSmall: AppTypography.titleSmall(color: AppColors.neutral0),
        bodyLarge: AppTypography.bodyLarge(color: AppColors.neutral0),
        bodyMedium: AppTypography.bodyMedium(color: AppColors.neutral0),
        bodySmall: AppTypography.bodySmall(color: AppColors.neutral0),
        labelLarge: AppTypography.labelLarge(color: AppColors.neutral0),
        labelMedium: AppTypography.labelMedium(color: AppColors.neutral0),
        labelSmall: AppTypography.labelSmall(color: AppColors.neutral0),
      ),

      // Drawer theme
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.darkSurface,
        elevation: 0,
      ),

      // Divider theme
      dividerTheme:const  DividerThemeData(
        color: AppColors.neutral700,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
