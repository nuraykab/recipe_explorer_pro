import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import '../utils/theme/custom_theme/app_colors.dart';
import '../utils/theme/custom_theme/text_theme.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themeBox = "themeBox";
  static const String _themeKey = "isDarkMode";

  bool _isDarkMode = false;
  late Box _box;

  ThemeProvider() {
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? _darkTheme : _lightTheme;
  // 🎨 Light Theme
  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: LightThemeColors.primary,
    scaffoldBackgroundColor: LightThemeColors.background,
    cardColor: LightThemeColors.card,
    textTheme: MyTextTheme.lightTextTheme,
    appBarTheme: AppBarTheme(
      color: LightThemeColors.background,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black54),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: LightThemeColors.button,
    ),
  );

  // 🌙 Dark Theme
  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: DarkThemeColors.primary,
    scaffoldBackgroundColor: DarkThemeColors.background,
    cardColor: DarkThemeColors.card,
    textTheme: MyTextTheme.darkTextTheme,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white),
      color: DarkThemeColors.background,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: DarkThemeColors.button,
    ),
  );
  // 🔄 Load Theme from Hive
  Future<void> _loadTheme() async {
    _box = await Hive.openBox(_themeBox);
    _isDarkMode = _box.get(_themeKey, defaultValue: false);
    notifyListeners();
  }

  // 🌗 Toggle Theme & Save in Hive
  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _box.put(_themeKey, _isDarkMode);
    notifyListeners();
  }
}
