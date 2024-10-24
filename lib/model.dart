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
    this.isDarkMode = false,
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
class DayStreakCounter{
  @Id()
  int id;

  //* Variables
  int count;
  bool updated;
  DateTime lastUpdated;

  DayStreakCounter(
    this.lastUpdated,
  {
    this.id = 0,
    this.count = 0,
    this.updated = false,
  });

  //* Relation
  @Backlink("dayStreakCounter")
  final habits = ToMany<Habit>();

  //* Functions
  void logRelatedHabits() {
    log("${habits.length} DayStreakCounter Related Habits:");
    for (var habit in habits) {
      log(habit.name);
    }
  }

  void checkDailyReset() {
    DateTime now = DateTime.now();
    bool isSameDay = _isSameTestDay(lastUpdated);

    if (!isSameDay && !updated) {
      count = 0;
    }
    if (!isSameDay) {
      updated = false;
    }

    lastUpdated = now;
  }

  void update() {
    checkDailyReset();
    int checkedCount = habits.where((habit) => habit.checked).length;
    int totalHabitCount = habits.length;

    log("$checkedCount von $totalHabitCount Habits abgehakt.");

    if (checkedCount == totalHabitCount && updated == false) {
      count ++;
      updated = true;
      log("DayStreakCounter erhöht");
    } else if (checkedCount != totalHabitCount && updated == true) {
      count --;
      updated = false;
      log("DayStreakCounter verringert");
    } else {
      updated = false;
      log("DayStreakCounter gleich geblieben");
    }

    log("Count: $count");
    lastUpdated = DateTime.now();
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  bool _isSameTestDay(DateTime lastUpdated) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(lastUpdated);

    return difference.inSeconds < 5;
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
  final dayStreakCounter = ToOne<DayStreakCounter>();

  //* Functions
  void checkDailyReset() {
    DateTime now = DateTime.now();
    bool isSameDay = _isSameTestDay(lastChecked);

    if (!isSameDay && !checked) {
      streak = 0;
    } 
    if (!isSameDay) {
      checked = false;
    }

    lastChecked = now;
  }

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

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  bool _isSameTestDay(DateTime lastChecked) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(lastChecked);

    return difference.inSeconds < 5;
  }
}
