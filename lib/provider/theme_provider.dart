import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  static const String _themeKey = 'isDarkMode';

  ThemeProvider() {
    _loadThemePreference();
  }

  ThemeData get themeData => _isDarkMode ? ThemeData.dark() : ThemeData.light();

  void _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    // Default to false (light mode) if no value is found
    _isDarkMode = prefs.getBool(_themeKey) ?? false;
    notifyListeners(); // Notify listeners once the initial state is loaded
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    // Save the new state
    await prefs.setBool(_themeKey, _isDarkMode);
    notifyListeners();
  }

  bool get isDarkMode => _isDarkMode;
}
