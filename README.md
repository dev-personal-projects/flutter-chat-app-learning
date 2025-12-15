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
- iOS Simulator (for macOS) or Android Emulator
- Git

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

## 📚 Learning Resources

This project is built alongside:

- **Mitch Koko** - YouTube tutorials and mobile development guidance
- Flutter official documentation
- Community best practices

> 📖 **For a complete list of resources, see [docs/RESOURCES.md](docs/RESOURCES.md)**

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── constant/                 # Design system constants
│   ├── app_colors.dart       # Color palette (light/dark mode)
│   └── app_typography.dart   # Typography system
├── utils/                    # Utility functions
│   ├── theme_config.dart     # Theme configuration (light/dark)
│   ├── theme_provider.dart   # Theme state management
│   └── theme_helper.dart     # Theme helper utilities
├── pages/                    # App screens
│   ├── splash_page.dart      # WhatsApp-style splash screen
│   ├── home_page.dart        # Main home screen
│   ├── chat_page.dart        # Chat screen (placeholder)
│   └── settings_page.dart    # Settings screen
├── components/               # Reusable UI components
│   └── whatsapp_logo.dart   # Theme-aware WhatsApp logo
└── services/                 # Business logic & services
    └── chat/                 # Chat services
        └── chat_service.dart # Chat service (stub for future)
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

### Phase 2: Authentication (Refactored)

- [x] Removed old Firebase authentication
- [x] Cleaned codebase for new auth implementation
- [ ] WhatsApp-style phone number authentication (planned)
- [ ] OTP verification flow (planned)
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
- **Backend**: To be determined (Firebase removed)
- **Authentication**: To be implemented (WhatsApp-style)
- **Database**: To be determined
- **Storage**: To be determined

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
HomePage
  - Direct access (no authentication)
  - Ready for new auth implementation
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
- ✅ Removed all Firebase dependencies
- ✅ Removed old authentication flow
- ✅ Improved component structure
- ✅ Clean project organization

**Android Configuration:**

- ✅ App name configured ("WhatsApp Clone")
- ✅ App icon generation setup
- ✅ Clean Android build configuration

### 🚧 In Progress

- New authentication flow (WhatsApp-style)
- Chat functionality
- Backend integration

### 📋 Next Steps

- Implement WhatsApp-style phone number authentication
- Add OTP verification flow
- Implement chat list screen
- Add real-time messaging
- User profile management
- Backend integration (to be determined)
