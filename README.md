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
git clone https://github.com/cm-collins/flutter-chat-app-learning.git
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
├── services/                 # Business logic & services
│   └── auth/                 # Authentication services
│       ├── auth_service.dart    # Firebase authentication service
│       ├── auth_gate.dart       # Authentication state gate
│       └── login_or_register.dart # Login/Register toggle page
├── pages/                    # App screens
│   ├── login_page.dart      # User login screen
│   ├── register_page.dart   # User registration screen
│   ├── home_page.dart       # Main home screen
│   └── settings_page.dart   # Settings screen
├── components/               # Reusable UI components
│   ├── my_button.dart       # Custom button widget
│   ├── my_textfield.dart    # Custom text field widget
│   └── my_drawer.dart       # Navigation drawer widget
└── themes/                   # App theming
    └── light_mode.dart       # Light theme configuration
```

## 🗺️ Development Roadmap

### Phase 1: Foundation ✅
- [x] Project setup
- [x] Basic Flutter structure
- [x] UI/UX design planning
- [x] Theme configuration
- [x] Reusable components (Button, TextField)

### Phase 2: Authentication ✅
- [x] Login screen with form validation
- [x] Registration screen with password confirmation
- [x] User authentication (Firebase Auth)
- [x] AuthGate for navigation control
- [x] Sign out functionality
- [ ] User profile management

### Phase 3: Core Features
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
- [ ] Error handling
- [ ] Testing
- [ ] Documentation

## 🛠️ Tech Stack

- **Framework**: Flutter 3.24.0+
- **Language**: Dart 3.0.0+
- **State Management**: StatefulWidget (current), Provider / Riverpod (future)
- **Backend**: Firebase
- **Authentication**: Firebase Auth ✅
- **Database**: Firestore (planned)
- **Storage**: Firebase Storage (planned)

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

## 🎉 Current Progress

### ✅ Completed Features
- **Authentication System**: Complete login and registration flow with Firebase
- **UI Components**: Custom reusable button, text field, and drawer components
- **Theme System**: Light mode theme with responsive design
- **Form Validation**: Input validation and error handling
- **Loading States**: Loading indicators during authentication
- **Navigation**: AuthGate for automatic navigation based on auth state
- **Navigation Drawer**: Side drawer with Home, Settings, and Logout functionality
- **Settings Page**: Basic settings screen structure
- **Project Structure**: Reorganized auth services into `lib/services/auth/` for better organization

### 🚧 In Progress
- Chat functionality
- User profile management

### 📋 Next Steps
- Implement chat list screen
- Add real-time messaging
- User profile page
- Dark mode theme
