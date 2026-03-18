# 📈 Stock Swap (Flutter Watchlist App)

A modern Flutter application for managing stock watchlists, built using **Clean Architecture + BLoC**.
Designed for scalability, performance, and fintech-grade development.

---

# 🚀 Features

*  Stock Watchlist Management
*  Reorder & Save Watchlist
*  Clean Architecture (Scalable)
*  BLoC State Management
*  Modern UI (Material 3)
*  Ready for API Integration (Real-time stocks)

---

# 🏗️ Project Structure

```bash
lib/
├── core/              # Common utilities, themes, constants
│   ├── theme/         # AppTheme, colors, typography
│   ├── utils/         # Helpers, extensions
│
├── data/              # Data layer (API, local storage)
│   ├── models/        # JSON models
│   ├── repositories/  # Repository implementations
│
├── domain/            # Business logic layer
│   ├── models/        # Entities (e.g., Stock)
│   ├── repositories/  # Abstract repository contracts
│
├── presentation/      # UI layer
│   ├── bloc/          # BLoC state management
│   ├── screens/       # UI screens
│   ├── widgets/       # Reusable components
│
├── main.dart          # App entry point
```

---

# 🧠 Architecture Explained

This app follows **Clean Architecture**:

### 1. Presentation Layer

* Handles UI + user interaction
* Uses **BLoC** for state management

### 2. Domain Layer

* Core business logic
* Independent from UI & frameworks

### 3. Data Layer

* Handles API calls / local storage
* Implements domain repositories

👉 This separation makes the app:

* Scalable
* Testable
* Maintainable

---

# 📦 Tech Stack

* Flutter (Latest Stable)
* Dart
* BLoC (State Management)
* Material 3 UI
* Shared Preferences (local storage)

---

# ⚙️ Setup Instructions

## 1. Clone repo

```bash
git clone https://github.com/govindy444/stock_swap.git
cd stock_swap
```

## 2. Install dependencies

```bash
flutter pub get
```

## 3. Run app

```bash
flutter run
```

---

# 📁 Assets Setup

Make sure fonts are available:

```bash
assets/fonts/Inter-Regular.ttf
```

And configured in `pubspec.yaml`:

```yaml
flutter:
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
```

---

# 🔧 Known Issues (if any)

* NDK version mismatch → fix in `build.gradle.kts`
* Missing assets → ensure fonts/images exist
* Strict typing errors → ensure proper model imports

---

# 🚀 Future Improvements

* 📡 Real-time stock API integration
* 📊 Charts & analytics
* 🔐 Authentication (login/signup)
* ☁️ Cloud sync (Firebase/AWS)
* 💸 Trading simulation

---

# 👨‍💻 Author

**Govind Yadav**
Flutter Developer | Fintech Builder

---


This project is open-source and available under the MIT License.
