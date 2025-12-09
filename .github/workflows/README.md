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
   - Sets up Flutter SDK
   - Sets up Java JDK
   - Sets up Android SDK
   - Generates `local.properties` before CodeQL analysis

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

