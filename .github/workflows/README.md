# GitHub Actions Workflows

## CodeQL Workflow

The CodeQL workflow analyzes Java/Kotlin code in the Android portion of the Flutter project.

### Issue Fixed

The workflow was failing because `android/local.properties` was missing. This file is machine-specific and is typically gitignored.

### Solution

1. **Updated `android/settings.gradle.kts`**: Modified to handle missing `local.properties` file gracefully by:
   - Checking if the file exists before reading it
   - Falling back to environment variables (`FLUTTER_SDK`)
   - Using a default path as a last resort

2. **Created proper CodeQL workflow**: The workflow now:
   - Sets up Flutter SDK using `subosito/flutter-action`
   - Sets up Java JDK 17
   - Sets up Android SDK using `android-actions/setup-android`
   - Detects Flutter SDK path automatically
   - Generates `local.properties` with correct paths
   - Fetches Flutter dependencies (`flutter pub get`)
   - Builds Android project manually (replacing autobuild) for CodeQL to trace
   - Performs CodeQL analysis on Java/Kotlin code

### Build Process

The workflow uses **manual build steps** instead of CodeQL's autobuild because:
- Flutter projects have a specific build structure
- Autobuild doesn't work well with Flutter's Gradle setup
- Manual build ensures all dependencies are properly resolved

### Note

For Flutter projects, CodeQL primarily analyzes the Android (Java/Kotlin) and iOS (Swift/Objective-C) native code. The main Dart/Flutter code is not analyzed by CodeQL.

If you want to analyze Dart code, consider:
- Using `dart analyze` in a separate workflow
- Using `flutter analyze` for Flutter-specific analysis
- Using other Dart/Flutter linting tools

## Disabling CodeQL (Optional)

If you prefer not to use CodeQL for this Flutter project, you can:
1. Delete `.github/workflows/codeql.yml`
2. Or disable it in GitHub repository settings under Security → Code scanning

