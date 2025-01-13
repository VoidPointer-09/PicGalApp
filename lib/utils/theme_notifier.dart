import 'package:flutter/material.dart';
import 'package:picgalapp/utils/custom_theme.dart';
import 'package:picgalapp/utils/dark_theme.dart';
import 'package:picgalapp/utils/light_theme.dart';


class ThemeNotifier extends ChangeNotifier {
  bool isDarkTheme = true;
  CustomTheme? appTheme;

  ThemeNotifier(this.isDarkTheme) {
    appTheme = isDarkTheme ? DarkTheme() : LightTheme();
  }

  void onThemeChange(bool isDarkTheme) {
    if (this.isDarkTheme != isDarkTheme) {
      this.isDarkTheme = isDarkTheme;
      appTheme = isDarkTheme ? DarkTheme() : LightTheme();
      notifyListeners();
    }
  }
}
