# 🍽 Recipe Management App

A Flutter-powered application for discovering, creating, and managing delicious recipes with Firebase integration.

## 🚀 Overview

The Recipe Management App is a feature-rich mobile application that allows users to explore, create, and organize their favorite recipes. It supports Firebase Authentication, real-time Firestore database, and local storage using Hive to offer a seamless user experience.

## 🌟 Key Features

- ✅ **User Authentication** – Firebase email/password login & registration
- ✅ **Recipe Browsing** – Explore recipes with search & category filtering
- ✅ **Recipe Details** – View ingredients, instructions, and user reviews
- ✅ **Favorites & Personal Recipes** – Save and manage your own recipes
- ✅ **User Ratings & Reviews** – Engage with the community through comments and ratings
- ✅ **Offline Support** – Save recipes locally for access without an internet connection
- ✅ **Dark Mode Support** – Switch between light & dark themes
- ✅ **Meal Planner & Shopping List** – Plan meals for the week

## 💂️ Project Structure

```
lib/
│── main.dart
│── data/
│   │── handle/
│   │   │── firebase_exceptionhandler.dart
│   │   │── firebase_options.dart
│   │── models/
│   │   │── category_model.dart
│   │   │── category_model.g.dart
│   │   │── hive_registrar.g.dart
│   │   │── recipe_model.dart
│   │── services/
│── feature/
│   │── notfoundscreen.dart
│   │── account/
│   │── app_theme/
│   │── auth/
│   │── categories/
│   │── favorite/
│   │── home/
│   │── my_recipe/
│   │── profile/
│   │── view_recipe/
│── providers/
│   │── auth_provider.dart
│   │── recipe_provider.dart
│   │── theme_provider.dart
│   │── user_provider.dart
│── utils/
│   │── constants/
│   │── http/
│   │── routes/
│   │── theme/
│   │── validators/
│   │── widget/
```

## ⚙️ Installation & Setup

### 1️⃣ Prerequisites

- Flutter SDK installed ([Download Flutter](https://flutter.dev/docs/get-started/install))
- Firebase Setup for authentication & Firestore database

### 2️⃣ Clone the Repository

```sh
git clone https://github.com/adhilfouzi/recipe_explorer_pro.git
cd recipe_explorer_pro
```

### 3️⃣ Install Dependencies

```sh
flutter pub get
```

### 4️⃣ Firebase Configuration

- Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
- Enable Authentication (Email/Password)
- Enable Cloud Firestore & Storage
- Add `google-services.json` (Android) & `GoogleService-Info.plist` (iOS)

### 5️⃣ Run the App

```sh
flutter run
```

## 🧭 Technologies Used

- **Flutter (Dart)**
- **Firebase Authentication & Firestore**
- **Provider / GetX (State Management)**
- **Hive (Local Storage)**
- **Google Sign-In**
- **Flutter Secure Storage (for authentication tokens)**

## 🛏 App Navigation (Routes & Screens)

| Route Name    | Screen              |
| Route Name    | Screen              |
|---------------|---------------------|
| `/`           | SplashScreen        |
| `/login`      | LoginScreen         |
| `/signup`     | SignupScreen        |
| `/email-verification` | EmailVerifiScreen |
| `/password-reset` | PasswordResetEmailScreen |
| `/home`       | HomeScreen          |
| `/recipes`    | ViewRecipeScreen    |
| `/favorites`  | FavoriteScreen      |
| `/add-recipe` | AddOwnRecipeScreen  |
| `/my-recipe`  | MyRecipeScreen      |
| `/category`   | CategoriesScreen    |
| `/profile`    | ProfileScreen       |
| `/edit-profile` | EditProfile       |
| `/app-theme-screen` | AppThemeScreen |
| `/account-screen` | AccountScreen    |

## 🎨 Screenshots

- Home Screen
- Recipe Detail
- Add Recipe

## 🔥 Future Improvements

- 💡 **Push Notifications** – Notify users about trending recipes
- 💡 **Recipe Sharing** – Share recipes via social media & QR codes
- 💡 **AI-powered Recommendations** – Suggest recipes based on user preferences
- 💡 **Multi-language Support** – Enable recipe descriptions in multiple languages

## 🤝 Contributors

- **Adhil Fouzi**

Open for contributions! Fork the repo & submit pull requests.

## 📝 License

This project is **MIT Licensed** – Feel free to use and modify it.

## 🚀 Get Started Today!

Clone the project, run it, and start managing your favorite recipes effortlessly! 🍽🔥

