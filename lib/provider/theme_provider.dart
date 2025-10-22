import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  ThemeData get themeData => _isDarkMode ? ThemeData.dark() : ThemeData.light();

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  bool get isDarkMode => _isDarkMode;
}
