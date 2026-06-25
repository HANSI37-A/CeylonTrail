
# CeylonTrail — Sri Lanka

**SENG 31323 - Mobile Computing Technology** **University of Kelaniya — Faculty of Science**

---

## 👨‍💻 Developer Information
- **Name:** Hansi Tharaki
- **Student ID:** SE/2022/004
- **Track:** Track B — Local Tour & Travel Guide

---

## 📱 Framework & Technology
- **Framework:** Flutter (Dart)
- **Target Platform:** Android
- **Min SDK:** Android 8.0 (API 26)
- **State Management:** Provider

---

## 📦 Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  sqflite: ^2.3.3+1
  shared_preferences: ^2.2.3
  geolocator: ^12.0.0
  url_launcher: ^6.3.0
  image_picker: ^1.1.2
  path: ^1.9.0

```

---

## 🚀 Build & Run Steps

### Prerequisites

* Flutter SDK installed and configured globally
* Android Studio installed (for Android SDK tools configuration)
* USB Debugging enabled on your target Android hardware device

### Steps

1. Clone or extract the project folder contents.
2. Open your terminal window directly inside the project root workspace directory.
3. Fetch the system package dependencies configurations:
```bash
flutter pub get

```


4. Connect your Android testing device via a USB data utility cable.
5. Verify your active connected platform target device is detected:
```bash
flutter devices

```


6. Run the application package configurations directly onto the screen:
```bash
flutter run

```



---

## ✨ Features Implemented

### 🧭 Core Features (Track B)

* ✅ **Category Grid Listings:** Interactive display grids filtering locations cleanly by *Hotels*, *Nature*, and *Historical*.
* ✅ **Detailed Pages:** Dedicated layout dashboards mapping out explicit profile statistics and overviews for individual destination points.
* ✅ **Favorites Bookmarking System:** Fully interactive local bookkeeping repository backed entirely by a **SQLite** database setup.

### 🗺️ Advanced Features

* ✅ **GPS Distance Tracking:** Dynamic mathematical spatial calculations using active `geolocator` variables to present real-time variances to users in Kilometers (Km).
* ✅ **External Maps Deep-Linking:** Smooth routing handshakes passing coordinate intents straight into native Google Maps layers via specific launcher interfaces.

## 🗄️ Data Persistence

* **SQLite** — Local operational architecture records handling user accounts parameters, active favorites profiles, and custom user ratings data.
* **SharedPreferences** — Storage layer keeping key-value app configurations and global user profile image system file paths.

## 🔧 Device Features Used

* **GPS / Geolocator** — Hardware coordinate telemetry tracking used to compute live relative distances.
* **URL Launcher** — Target intent handler mapping coordinate pointers directly onto Google Maps routes.
* **Image Picker** — Local platform integration loading image assets directly out of the device gallery.

---

## 📁 Project Structure

```text
lib/
├── data/           # Sample mock attractions dataset configurations
├── models/         # Structure blueprints (Core Attraction object schemas)
├── providers/      # Architecture layer coordinating app states (Provider)
├── screens/        # All independent UI views (Home, Detail, Favorites panels)
├── services/       # Functional helpers, local database engines, and app configuration utilities
└── widgets/        # Modular components and reusable UI card components

```
