import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/utils/theme_provider.dart';

/// Helper class for easy theme access throughout the app
class ThemeHelper {
  ThemeHelper._(); // Private constructor to prevent instantiation

  /// Get ThemeProvider from context
  static ThemeProvider of(BuildContext context) {
    return Provider.of<ThemeProvider>(context, listen: false);
  }

  /// Get ThemeProvider from context (listening to changes)
  static ThemeProvider watch(BuildContext context) {
    return Provider.of<ThemeProvider>(context);
  }

  /// Toggle theme mode
  static Future<void> toggleTheme(BuildContext context) async {
    await of(context).toggleTheme();
  }

  /// Set theme mode
  static Future<void> setThemeMode(BuildContext context, ThemeMode mode) async {
    await of(context).setThemeMode(mode);
  }

  /// Check if dark mode is active
  static bool isDarkMode(BuildContext context) {
    return watch(context).isDarkMode;
  }
}
