import 'package:flutter/material.dart';

/// App Typography Constants
/// Defines text styles for the application following Material Design 3 guidelines
class AppTypography {
  AppTypography._(); // Private constructor to prevent instantiation

  // ==================== FONT FAMILY ====================
  // Using system default fonts, can be customized with custom fonts later
  static const String fontFamily = 'Roboto'; // Default Material font
  static const String displayFontFamily = 'Roboto';
  static const String bodyFontFamily = 'Roboto';

  // ==================== FONT SIZES ====================
  static const double fontSizeDisplayLarge = 57.0;
  static const double fontSizeDisplayMedium = 45.0;
  static const double fontSizeDisplaySmall = 36.0;
  static const double fontSizeHeadlineLarge = 32.0;
  static const double fontSizeHeadlineMedium = 28.0;
  static const double fontSizeHeadlineSmall = 24.0;
  static const double fontSizeTitleLarge = 22.0;
  static const double fontSizeTitleMedium = 16.0;
  static const double fontSizeTitleSmall = 14.0;
  static const double fontSizeBodyLarge = 16.0;
  static const double fontSizeBodyMedium = 14.0;
  static const double fontSizeBodySmall = 12.0;
  static const double fontSizeLabelLarge = 14.0;
  static const double fontSizeLabelMedium = 12.0;
  static const double fontSizeLabelSmall = 11.0;

  // ==================== FONT WEIGHTS ====================
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;

  // ==================== LINE HEIGHTS ====================
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.75;

  // ==================== DISPLAY TEXT STYLES ====================
  static TextStyle displayLarge({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeDisplayLarge,
        fontWeight: fontWeight ?? fontWeightRegular,
        letterSpacing: -0.25,
        height: lineHeightTight,
        fontFamily: displayFontFamily,
        color: color,
      );

  static TextStyle displayMedium({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeDisplayMedium,
        fontWeight: fontWeight ?? fontWeightRegular,
        letterSpacing: 0,
        height: lineHeightTight,
        fontFamily: displayFontFamily,
        color: color,
      );

  static TextStyle displaySmall({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeDisplaySmall,
        fontWeight: fontWeight ?? fontWeightRegular,
        letterSpacing: 0,
        height: lineHeightTight,
        fontFamily: displayFontFamily,
        color: color,
      );

  // ==================== HEADLINE TEXT STYLES ====================
  static TextStyle headlineLarge({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeHeadlineLarge,
        fontWeight: fontWeight ?? fontWeightSemiBold,
        letterSpacing: 0,
        height: lineHeightTight,
        fontFamily: displayFontFamily,
        color: color,
      );

  static TextStyle headlineMedium({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeHeadlineMedium,
        fontWeight: fontWeight ?? fontWeightSemiBold,
        letterSpacing: 0,
        height: lineHeightTight,
        fontFamily: displayFontFamily,
        color: color,
      );

  static TextStyle headlineSmall({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeHeadlineSmall,
        fontWeight: fontWeight ?? fontWeightSemiBold,
        letterSpacing: 0,
        height: lineHeightTight,
        fontFamily: displayFontFamily,
        color: color,
      );

  // ==================== TITLE TEXT STYLES ====================
  static TextStyle titleLarge({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeTitleLarge,
        fontWeight: fontWeight ?? fontWeightMedium,
        letterSpacing: 0,
        height: lineHeightNormal,
        fontFamily: bodyFontFamily,
        color: color,
      );

  static TextStyle titleMedium({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeTitleMedium,
        fontWeight: fontWeight ?? fontWeightMedium,
        letterSpacing: 0.15,
        height: lineHeightNormal,
        fontFamily: bodyFontFamily,
        color: color,
      );

  static TextStyle titleSmall({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeTitleSmall,
        fontWeight: fontWeight ?? fontWeightMedium,
        letterSpacing: 0.1,
        height: lineHeightNormal,
        fontFamily: bodyFontFamily,
        color: color,
      );

  // ==================== BODY TEXT STYLES ====================
  static TextStyle bodyLarge({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeBodyLarge,
        fontWeight: fontWeight ?? fontWeightRegular,
        letterSpacing: 0.5,
        height: lineHeightNormal,
        fontFamily: bodyFontFamily,
        color: color,
      );

  static TextStyle bodyMedium({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeBodyMedium,
        fontWeight: fontWeight ?? fontWeightRegular,
        letterSpacing: 0.25,
        height: lineHeightNormal,
        fontFamily: bodyFontFamily,
        color: color,
      );

  static TextStyle bodySmall({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeBodySmall,
        fontWeight: fontWeight ?? fontWeightRegular,
        letterSpacing: 0.4,
        height: lineHeightNormal,
        fontFamily: bodyFontFamily,
        color: color,
      );

  // ==================== LABEL TEXT STYLES ====================
  static TextStyle labelLarge({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeLabelLarge,
        fontWeight: fontWeight ?? fontWeightMedium,
        letterSpacing: 0.1,
        height: lineHeightNormal,
        fontFamily: bodyFontFamily,
        color: color,
      );

  static TextStyle labelMedium({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeLabelMedium,
        fontWeight: fontWeight ?? fontWeightMedium,
        letterSpacing: 0.5,
        height: lineHeightNormal,
        fontFamily: bodyFontFamily,
        color: color,
      );

  static TextStyle labelSmall({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSizeLabelSmall,
        fontWeight: fontWeight ?? fontWeightMedium,
        letterSpacing: 0.5,
        height: lineHeightNormal,
        fontFamily: bodyFontFamily,
        color: color,
      );
}
