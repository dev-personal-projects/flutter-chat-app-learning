pluginManagement {
    val flutterSdkPath =
        run {
            val localPropertiesFile = file("local.properties")
            if (localPropertiesFile.exists()) {
                val properties = java.util.Properties()
                localPropertiesFile.inputStream().use { properties.load(it) }
                val flutterSdkPath = properties.getProperty("flutter.sdk")
                require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
                flutterSdkPath
            } else {
                // Fallback: try to get Flutter SDK from environment variable
                val flutterSdkFromEnv = System.getenv("FLUTTER_SDK")
                if (flutterSdkFromEnv != null) {
                    flutterSdkFromEnv
                } else {
                    // Last resort: assume Flutter is in the standard location
                    // This will work in CI if Flutter is installed via the setup-flutter action
                    val homeDir = System.getProperty("user.home")
                    "$homeDir/flutter"
                }
            }
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    // START: FlutterFire Configuration
    id("com.google.gms.google-services") version("4.3.15") apply false
    // END: FlutterFire Configuration
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
}

include(":app")
