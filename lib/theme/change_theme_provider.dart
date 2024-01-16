import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeTheme extends ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == ThemeData.light()) {
      themeData = ThemeData.dark();
    } else {
      themeData = ThemeData.light();
    }
  }
}