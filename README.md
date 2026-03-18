# 📈 Stock Swap (Flutter Watchlist App)

A modern Flutter application for managing stock watchlists, built using **Clean Architecture + BLoC**.
Designed for scalability, performance, and fintech-grade development.

---

# 🚀 Features

* 📊 Stock Watchlist Management
* 🔄 Reorder & Save Watchlist
* 🧠 Clean Architecture (Scalable)
* ⚡ BLoC State Management
* 🎨 Modern UI (Material 3)
* 🌐 Ready for API Integration (Real-time stocks)

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

* Handles
