import '../main.dart';
import '../model.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  late UserSettings userSettings;
  late ThemeMode _themeMode;
  late bool _isDarkMode;

  ThemeProvider() {
    _initializeTheme();
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _isDarkMode;

  void _initializeTheme() {
    userSettings = db.getUserSettings();
    _themeMode = userSettings.getThemeMode();
    _isDarkMode = userSettings.isDarkMode;
  }
  
  void switchTheme() {
    _isDarkMode = !_isDarkMode;
    userSettings.isDarkMode = _isDarkMode;
    db.userSettingsBox.put(userSettings);
    _themeMode = userSettings.getThemeMode();
    notifyListeners();
  }
}

class LocaleProvider with ChangeNotifier {
   late UserSettings userSettings;
   late Locale _locale;

   LocaleProvider() {
    _initializeLocale();
   }

   Locale get locale => _locale;

   void _initializeLocale() {
    userSettings = db.getUserSettings();
    _locale = userSettings.locale; //TODO hier ist noch nen error
   }

   void changeLocale(Locale newLocale) {
    userSettings = db.getUserSettings();
    userSettings.changeLocale(newLocale);
    db.userSettingsBox.put(userSettings);
    _locale = userSettings.locale;
    notifyListeners();
   }
}