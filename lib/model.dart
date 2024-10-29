import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'dart:developer';

@Entity()
class UserSettings {
  @Id()
  int id;

  bool isDarkMode;
  String localeCode;

  UserSettings(
    this.localeCode,
  {
    this.id = 0,
    this.isDarkMode = true,
  });

  ThemeMode getThemeMode() {
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Locale get locale => Locale(localeCode);

  void changeLocale(Locale newLocale) {
    localeCode = newLocale.languageCode;
  }
}

@Entity()
class Habit{
  @Id()
  int id;

  //* Variables
  String name;
  String description;
  int streak;
  bool checked;
  DateTime lastChecked;

  Habit(
    this.name,
    this.description,
    this.lastChecked,
    {
      this.id = 0,
      this.streak = 0,
      this.checked = false,
    });

  //* Relation
  //TODO Add relation to flames counter

  //* Functions
  bool toggleCheck() {
    checked = !checked;

    if (checked) {
      streak ++;
    } else {
      streak --;
    }

    lastChecked = DateTime.now();
    return checked;
  }

  void editName(String newName) {
    name = newName;
  }

  void editDescription(String newDescription) {
    description = newDescription;
  }

  void checkDailyReset() {
    DateTime now = DateTime.now();
    bool isSameDay = _isSameTestDay(lastChecked);

    if (!isSameDay && !checked) { // Wenn es ein anderer Tag ist und es unchecked ist, setzte streak auf 0 zurück
      streak = 0;
      log("Zurückgesetzt: $name");
    } 
    if (!isSameDay) { // Wenn es NUR ein anderer Tag ist, setzte checked = false
      checked = false;
    }

    lastChecked = now;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  bool _isSameTestDay(DateTime lastChecked) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(lastChecked);

    return difference.inSeconds < 5;
  }
}
