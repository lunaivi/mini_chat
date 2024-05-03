import 'package:chat_minits/themes/dark_mode.dart';
import 'package:chat_minits/themes/light_mode.dart';
import 'package:flutter/material.dart';

// Funcion para cambiar el theme de ligh a dark
class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toogleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
