import 'package:flutter/material.dart';
import '../../data/models/category_model.dart';
import '../../data/models/recipe_model.dart';
import '../../feature/account/account_screen.dart';
import '../../feature/app_theme/app_theme_screen.dart';
import '../../feature/auth/emailverification.dart';
import '../../feature/auth/login_screen.dart';
import '../../feature/auth/sentemail_screen.dart';
import '../../feature/auth/signup_screen.dart';
import '../../feature/auth/splash_screen.dart';
import '../../feature/categories/categories_screen.dart';
import '../../feature/favorite/favorite_screen.dart';
import '../../feature/home/home_screen.dart';
import '../../feature/my_recipe/add_own_recipe_screen.dart';
import '../../feature/my_recipe/my_recipe_screen.dart';
import '../../feature/profile/edit_profile.dart';
import '../../feature/profile/profile_screen.dart';
import '../../feature/view_recipe/view_recipe_screen.dart';

/// Manages all app routes and navigation.
class AppRoutes {
  AppRoutes._(); // Prevent instantiation

  // Auth routes
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String emailVerification = '/email-verification';
  static const String password = '/password-reset';

  // Main routes
  static const String home = '/home';
  static const String recipes = '/recipes';
  static const String favorites = '/favorites';
  static const String addRecipe = '/add-recipe';
  static const String myRecipe = '/my-recipe';
  static const String category = '/category';

  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  // static const String settings = '/settings';
  static const String themeScreen = '/app-theme-screen';
  static const String account = '/account-screen';

  // Static routes (Screens that don't require arguments)
  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
    emailVerification: (context) => const EmailVerifiScreen(),
    password: (context) => const PasswordResetEmailScreen(),

    home: (context) => const HomeScreen(),

    account: (context) => const AccountScreen(),
    profile: (context) => const ProfileScreen(),
    editProfile: (context) => const EditProfile(),
    addRecipe: (context) => const AddOwnRecipeScreen(),
    myRecipe: (context) => const MyRecipeScreen(),
    favorites: (context) => const FavoriteScreen(),
    themeScreen: (context) => const AppThemeScreen(),
    // settings: (context) => const SettingsScreen(),
  };

  /// Handles routes dynamically, including those that require arguments.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case recipes:
        final recipe = settings.arguments as RecipeModel?;
        if (recipe != null) {
          return _customPageRoute(
            ViewRecipeScreen(recipe: recipe),
          );
        }
        return _errorRoute();

      case category:
        final category = settings.arguments as CategoryModel?;
        if (category != null) {
          return _customPageRoute(
            CategoriesScreen(category: category),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  /// Generates a default error route for invalid navigation attempts.
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(child: Text('Error: Invalid Route or Missing Arguments')),
      ),
    );
  }

  /// Custom page route with smooth transition.
  static PageRouteBuilder _customPageRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0); // Slide from right
        var end = Offset.zero;
        var curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
