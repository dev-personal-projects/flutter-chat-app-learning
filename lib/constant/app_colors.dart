import 'package:flutter/material.dart';

/// App Color Constants based on Figma Design System
/// Supports both light and dark mode color palettes
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // ==================== PRIMARY PALETTE (Dark Blue-Grey) ====================
  static const Color primary50 = Color(0xFFE9EAEB); // rgb(233, 234, 235)
  static const Color primary75 = Color(0xFFA4A9AD); // rgb(164, 169, 173)
  static const Color primary100 = Color(0xFF7E858A); // rgb(126, 133, 138)
  static const Color primary200 = Color(0xFF465158); // rgb(70, 81, 88)
  static const Color primary300 =
      Color(0xFF202D36); // rgb(32, 45, 54) - Main Primary
  static const Color primary400 = Color(0xFF161F26); // rgb(22, 31, 38)
  static const Color primary500 = Color(0xFF141621); // rgb(20, 27, 33)

  // ==================== SECONDARY PALETTE - TEAL ====================
  static const Color secondaryTeal50 = Color(0xFFE6F7F5); // rgb(230, 247, 245)
  static const Color secondaryTeal75 = Color(0xFF97DFD5); // rgb(151, 223, 213)
  static const Color secondaryTeal100 = Color(0xFF6CD1C4); // rgb(108, 209, 196)
  static const Color secondaryTeal200 = Color(0xFF2DBDAA); // rgb(45, 189, 170)
  static const Color secondaryTeal300 =
      Color(0xFF02B099); // rgb(2, 176, 153) - Main Secondary Teal
  static const Color secondaryTeal400 = Color(0xFF017666); // rgb(1, 123, 107)
  static const Color secondaryTeal500 = Color(0xFF016B5D); // rgb(1, 107, 93)

  // ==================== SECONDARY PALETTE - LIGHT GREEN ====================
  static const Color secondaryGreen50 = Color(0xFFFCFEFB); // rgb(252, 254, 251)
  static const Color secondaryGreen75 = Color(0xFFF4FCEF); // rgb(244, 252, 239)
  static const Color secondaryGreen100 =
      Color(0xFFEFFAE9); // rgb(239, 250, 233)
  static const Color secondaryGreen200 =
      Color(0xFFE9F8DF); // rgb(233, 248, 223)
  static const Color secondaryGreen300 =
      Color(0xFFE4F7D9); // rgb(228, 247, 217) - Main Secondary Green
  static const Color secondaryGreen400 =
      Color(0xFFA0AD98); // rgb(160, 173, 152)
  static const Color secondaryGreen500 =
      Color(0xFF8B9784); // rgb(139, 151, 132)

  // ==================== NEUTRAL PALETTE (Grey Scale) ====================
  static const Color neutral0 = Color(0xFFFFFFFF); // rgb(255, 255, 255) - White
  static const Color neutral10 = Color(0xFFFBFBFB); // rgb(251, 251, 251)
  static const Color neutral20 = Color(0xFFF7F7F8); // rgb(247, 247, 248)
  static const Color neutral30 = Color(0xFFEEF0F1); // rgb(238, 240, 241)
  static const Color neutral40 = Color(0xFFE4E6E8); // rgb(228, 230, 232)
  static const Color neutral50 = Color(0xFFCBD0D2); // rgb(203, 208, 210)
  static const Color neutral60 = Color(0xFFBFC4C8); // rgb(191, 196, 200)
  static const Color neutral70 = Color(0xFFB4BBBF); // rgb(180, 187, 191)
  static const Color neutral80 = Color(0xFFA8AFB4); // rgb(168, 175, 180)
  static const Color neutral90 = Color(0xFF9CA4A9); // rgb(156, 164, 169)
  static const Color neutral100 = Color(0xFF8F989E); // rgb(143, 152, 158)
  static const Color neutral200 = Color(0xFF838494); // rgb(131, 141, 148)
  static const Color neutral300 = Color(0xFF768289); // rgb(118, 130, 137)
  static const Color neutral400 = Color(0xFF6C7880); // rgb(108, 120, 128)
  static const Color neutral500 = Color(0xFF606D75); // rgb(96, 109, 117)
  static const Color neutral600 = Color(0xFF55636C); // rgb(85, 99, 108)
  static const Color neutral700 = Color(0xFF475660); // rgb(71, 86, 96)
  static const Color neutral800 = Color(0xFF3A4B55); // rgb(58, 75, 85)
  static const Color neutral900 =
      Color(0xFF30414C); // rgb(48, 65, 76) - Main Neutral

  // ==================== DANGER PALETTE (Red) ====================
  static const Color danger50 = Color(0xFFFFE6E6); // rgb(255, 230, 230)
  static const Color danger75 = Color(0xFFFD9696); // rgb(253, 150, 150)
  static const Color danger100 = Color(0xFFFD6B6B); // rgb(253, 107, 107)
  static const Color danger200 = Color(0xFFFC2B2B); // rgb(252, 43, 43)
  static const Color danger300 =
      Color(0xFFFB0000); // rgb(251, 0, 0) - Main Danger
  static const Color danger400 = Color(0xFFB00000); // rgb(176, 0, 0)
  static const Color danger500 = Color(0xFF990000); // rgb(153, 0, 0)

  // ==================== SEMANTIC COLORS ====================
  // Primary (main brand color)
  static const Color primary = primary300;

  // Secondary (accent color - using teal as main secondary)
  static const Color secondary = secondaryTeal300;

  // Neutral (main neutral)
  static const Color neutral = neutral900;

  // Danger (error/warning)
  static const Color danger = danger300;

  // ==================== LIGHT MODE COLORS ====================
  static const Color lightBackground = neutral0;
  static const Color lightSurface = neutral10;
  static const Color lightSurfaceVariant = neutral20;
  static const Color lightOnBackground = primary300;
  static const Color lightOnSurface = primary300;
  static const Color lightOnPrimary = neutral0;
  static const Color lightOnSecondary = neutral0;
  static const Color lightError = danger300;
  static const Color lightOnError = neutral0;
  static const Color lightPrimaryContainer = secondaryTeal50;
  static const Color lightSecondaryContainer = secondaryGreen50;

  // ==================== DARK MODE COLORS ====================
  static const Color darkBackground = primary500;
  static const Color darkSurface = primary400;
  static const Color darkSurfaceVariant = primary300;
  static const Color darkOnBackground = neutral0;
  static const Color darkOnSurface = neutral0;
  static const Color darkOnPrimary = neutral0;
  static const Color darkOnSecondary = neutral0;
  static const Color darkError = danger200;
  static const Color darkOnError = neutral0;
  static const Color darkPrimaryContainer = primary200;
  static const Color darkSecondaryContainer = secondaryTeal400;
}
