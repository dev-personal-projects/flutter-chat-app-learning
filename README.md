# 💬 Flutter Chat App - Learning Project

> A comprehensive Flutter chat application built while learning mobile development. This project follows along with tutorials and serves as a hands-on learning experience for building real-time chat applications with Flutter.

## 📑 Quick Navigation

- [🚀 Getting Started](#-getting-started)
- [📁 Project Structure](#-project-structure)
- [🗺️ Development Roadmap](#️-development-roadmap)
- [📝 Documentation](#-documentation)
  - [Learning Docs](docs/LEARNING_NOTES.md) | [Challenges](docs/CHALLENGES.md) | [Resources](docs/RESOURCES.md)
  - [Project Setup](.github/REPOSITORY_SETUP.md) | [Best Practices](.github/PROJECT_SUGGESTIONS.md)
- [🎉 Current Progress](#-current-progress)
- [👤 Author](#-author)

## 📋 Repository Description

**`flutter-chat-app-learning`** - A step-by-step Flutter chat application project designed for learning mobile development. This repository documents the entire journey of building a production-ready chat app, including UI/UX design, real-time messaging, authentication, and backend integration.

## 🎯 Project Goals

- Learn Flutter framework fundamentals and best practices
- Build a fully functional chat application
- Understand state management in Flutter
- Implement real-time messaging features
- Learn backend integration (Firebase/Supabase)
- Practice clean architecture and code organization
- Document the learning process for future reference

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.24.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Android SDK with the following components:
  - Android SDK Platform 34 (or latest)
  - Android SDK Build-Tools 34.0.0
  - Android SDK Command-line Tools
  - Android SDK Platform-Tools
- iOS Simulator (for macOS) or Android Emulator
- Git
- Java 17 (for Android builds)

### Android SDK Setup

#### Option 1: Via Android Studio (Recommended)

1. Install [Android Studio](https://developer.android.com/studio)
2. Open Android Studio → Settings → Languages & Frameworks → Android SDK
3. Install the required SDK components listed above
4. Android Studio automatically sets up `ANDROID_HOME`

#### Option 2: Command-Line Installation

```bash
# Create SDK directory
mkdir -p ~/Android/Sdk

# Download command-line tools
cd ~/Android/Sdk
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdline-tools.zip
unzip cmdline-tools.zip
mkdir -p cmdline-tools/latest
mv cmdline-tools/bin cmdline-tools/lib cmdline-tools/NOTICE.txt cmdline-tools/source.properties cmdline-tools/latest/
rm cmdline-tools.zip

# Accept licenses
yes | ~/Android/Sdk/cmdline-tools/latest/bin/sdkmanager --licenses

# Install required components
~/Android/Sdk/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"
```

#### Environment Variables

Add to your shell profile (`~/.bashrc`, `~/.zshrc`, or equivalent):

```bash
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

Then reload: `source ~/.bashrc`

#### Verify Setup

```bash
flutter doctor -v
```

All Android toolchain checks should pass ✓

### Installation

1. Clone the repository:

```bash
git clone https://github.com/dev-personal-projects/flutter-chat-app-learning.git
cd flutter-chat-app-learning
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

### Troubleshooting

#### "SDK location not found" Error

Flutter automatically generates `android/local.properties` with your SDK path. If you get this error:

1. Ensure `ANDROID_HOME` environment variable is set
2. Or run `flutter config --android-sdk /path/to/your/Android/Sdk`
3. Run `flutter clean && flutter pub get`

#### NDK Download Issues

The Android Gradle Plugin may download the NDK automatically. If downloads fail:

```bash
# Manually install NDK (if needed)
cd /tmp
wget https://dl.google.com/android/repository/android-ndk-r27-linux.zip -O ndk.zip
unzip ndk.zip
mv android-ndk-r27 $ANDROID_HOME/ndk/27.0.12077973
rm ndk.zip
```

#### Build Failures

```bash
# Clean build artifacts
flutter clean
cd android && rm -rf .gradle build
cd ..
flutter pub get
flutter run
```

## 📚 Learning Resources

This project is built alongside:

- **Mitch Koko** - YouTube tutorials and mobile development guidance
- Flutter official documentation
- Community best practices

> 📖 **For a complete list of resources, see [docs/RESOURCES.md](docs/RESOURCES.md)**

## 📁 Project Structure

```
lib/
├── main.dart                     # App entry point
├── constant/                     # Design system constants
│   ├── app_colors.dart           # Color palette (light/dark mode)
│   └── app_typography.dart       # Typography system
├── utils/                        # Utility functions
│   ├── theme_config.dart         # Theme configuration (light/dark)
│   ├── theme_provider.dart       # Theme state management
│   └── theme_helper.dart         # Theme helper utilities
├── pages/                        # App screens
│   ├── splash_page.dart          # WhatsApp-style splash screen
│   ├── phone_number_page.dart    # Phone number input for auth
│   ├── otp_verification_page.dart # OTP verification screen
│   ├── home_page.dart            # Main home screen
│   ├── chat_page.dart            # Chat screen (placeholder)
│   └── settings_page.dart        # Settings screen
├── components/                   # Reusable UI components
│   └── whatsapp_logo.dart        # Theme-aware WhatsApp logo
└── services/                     # Business logic & services
    └── chat/                     # Chat services
        └── chat_service.dart     # Chat service (stub for future)

android/
├── app/
│   └── build.gradle.kts          # App-level build configuration
├── build.gradle.kts              # Project-level build configuration
├── settings.gradle.kts           # Gradle settings with Flutter SDK
├── gradle.properties             # Gradle properties
└── local.properties              # Local SDK paths (gitignored)
```

## 🗺️ Development Roadmap

### Phase 1: Foundation ✅

- [x] Project setup
- [x] Basic Flutter structure
- [x] UI/UX design planning
- [x] Complete theming system (light/dark mode)
- [x] Design system constants (colors, typography)
- [x] Splash screen implementation
- [x] WhatsApp-style branding

### Phase 2: Authentication ✅

- [x] Firebase Core & Auth integration
- [x] WhatsApp-style phone number input page
- [x] OTP verification page with auto-focus
- [x] Country picker for phone codes
- [ ] User profile management (planned)

### Phase 3: Core Features

- [x] Splash screen with branding
- [x] Home page structure
- [x] Navigation drawer
- [ ] Chat list screen
- [ ] Individual chat screen
- [ ] Message input & sending
- [ ] Real-time message updates

### Phase 4: Advanced Features

- [ ] Image sharing
- [ ] File attachments
- [ ] Push notifications
- [ ] Online/offline status
- [ ] Message read receipts

### Phase 5: Polish & Optimization

- [ ] Performance optimization
- [x] Code quality improvements (KISS principles)
- [x] Theme system implementation
- [ ] Testing
- [x] Documentation

## 🛠️ Tech Stack

- **Framework**: Flutter 3.24.0+
- **Language**: Dart 3.0.0+
- **State Management**: Provider (theme management)
- **Theming**: Material Design 3 with custom color system
- **Backend**: Firebase
- **Authentication**: Firebase Auth (Phone/OTP)
- **Build Tools**:
  - Gradle 8.14
  - Android Gradle Plugin 8.11.1
  - Kotlin 2.2.20
  - Java 17

## 📝 Documentation

This project includes comprehensive documentation to track the learning journey:

### 📚 Learning Documentation

- **[Learning Notes](docs/LEARNING_NOTES.md)** - Key concepts, insights, and learnings throughout development
- **[Challenges & Solutions](docs/CHALLENGES.md)** - Problems faced during development and how they were resolved
- **[Resources](docs/RESOURCES.md)** - Curated list of helpful tutorials, articles, and community resources

### 🛠️ Project Setup & Guidelines

- **[Project Suggestions](.github/PROJECT_SUGGESTIONS.md)** - Best practices and suggestions for project success
- **[Repository Setup Guide](.github/REPOSITORY_SETUP.md)** - Complete guide for GitHub repository setup and configuration
- **[CodeQL Workflow](.github/workflows/README.md)** - Documentation for security analysis workflow

### 📋 In-Code Documentation

Each major feature includes:

- Code comments explaining the implementation
- Commit messages describing changes
- Progress notes in this README
- Learning insights and challenges faced

## 🤝 Contributing

This is a learning project. Feel free to:

- Open issues for bugs or questions
- Suggest improvements
- Share learning resources
- Fork and experiment

### Setting Up for Development

1. **Fork and clone** the repository
2. **Install prerequisites** (see [Getting Started](#-getting-started))
3. **Set up Android SDK** following the instructions above
4. **Run `flutter doctor`** to verify your setup
5. **Run the app** with `flutter run`

### What Gets Auto-Generated

The following files are **gitignored** and auto-generated locally:

| File | Purpose | Generated By |
|------|---------|--------------|
| `android/local.properties` | SDK paths | Flutter |
| `android/.gradle/` | Gradle cache | Gradle |
| `build/` | Build artifacts | Flutter |
| `.dart_tool/` | Dart tools | Dart |

Flutter automatically detects your Android SDK from `ANDROID_HOME` environment variable or Android Studio installation.

## 📄 License

This project is for educational purposes.

## 👤 Author

**Collins Munene**

- 🌐 GitHub: [@cm-collins](https://github.com/cm-collins)
- 📧 Email: dev-collins@outlook.com
- 🐦 X (Twitter): [@collins63760613](https://twitter.com/collins63760613)
- 💼 LinkedIn: [Collins Munene](https://www.linkedin.com/in/collins-munene-547365299)

**About**: DevOps & SRE Engineer • Software Engineer • Cloud Architect • Mobile Developer

Built as a learning project while following Flutter development tutorials with Mitch Koko.

## 🙏 Acknowledgments

- Mitch Koko for excellent Flutter tutorials
- Flutter community for resources and support
- All contributors to Flutter open-source packages

---

**Status**: 🚧 In Development | **Last Updated**: December 2025

## 🎨 Theme System

The app now features a complete theming system with:

- **Light Mode**: Clean white backgrounds with dark text
- **Dark Mode**: Dark blue-grey backgrounds with light text
- **Automatic Detection**: Follows system theme preference
- **Manual Toggle**: Users can switch themes manually
- **Persistence**: Theme preference is saved and restored

## 🚀 App Flow

```
App Launch
    ↓
SplashPage (2.5 seconds)
  - WhatsApp logo
  - "from FACEBOOK" branding
    ↓
PhoneNumberPage
  - Country picker
  - Phone number input
    ↓
OTPVerificationPage
  - 6-digit OTP input
  - Auto-focus between fields
  - Firebase phone authentication
    ↓
HomePage
  - Main chat interface
  - Navigation drawer
  - Settings access
```

## 🎉 Current Progress

### ✅ Completed Features

**Theming & Design System:**

- ✅ Complete light and dark mode theme system
- ✅ Material Design 3 compliant theming
- ✅ Color palette from Figma design system (Primary, Secondary, Neutral, Danger)
- ✅ Comprehensive typography system
- ✅ Theme persistence with SharedPreferences
- ✅ System theme detection
- ✅ Theme switching functionality

**UI/UX:**

- ✅ WhatsApp-style splash screen with logo and branding
- ✅ Theme-aware WhatsApp logo component
- ✅ Splash screen navigation flow
- ✅ Home page structure
- ✅ Settings page structure
- ✅ Navigation drawer

**Code Quality:**

- ✅ Clean codebase following KISS principles
- ✅ Improved component structure
- ✅ Clean project organization
- ✅ Kotlin DSL for Gradle build scripts

**Android Configuration:**

- ✅ App name configured ("WhatsApp Clone")
- ✅ App icon generation setup
- ✅ Clean Android build configuration
- ✅ Kotlin DSL build scripts (`.gradle.kts`)
- ✅ Java 17 compatibility
- ✅ Android SDK 34 target
- ✅ Gradle 8.14 with Android Gradle Plugin 8.11.1

### 🚧 In Progress

- Chat list screen implementation
- Individual chat screen
- Real-time messaging with Firebase

### 📋 Next Steps

- Complete OTP verification integration
- Implement chat list screen
- Add real-time messaging
- User profile management
- Push notifications
- Message read receipts
