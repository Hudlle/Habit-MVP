import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'model.dart';
import 'objectbox.g.dart';
import 'dart:developer';

class ObjectBox {
  //* Store
  late final Store store;

  late final Box<Habit> habitBox;
  late final Box<UserSettings> userSettingsBox;

  ObjectBox._create(this.store) {
    habitBox = Box<Habit>(store);
    userSettingsBox = Box<UserSettings>(store);

    // TODO Initialize flames counter

    // Initialize User Settings
    if (userSettingsBox.isEmpty()) {
      Locale userLocale = Locale(Platform.localeName);
      userSettingsBox.put(UserSettings(userLocale.languageCode));
    }
  }

  static Future<ObjectBox> create() async {
    return ObjectBox._create(await openStore());
  }

  //* Habits
  void addHabit(String habitName, String habitDescription) {
    DateTime initalDateTime = DateTime.now();
    Habit newHabit = Habit(habitName, habitDescription, initalDateTime);
    habitBox.put(newHabit);

    log("Added Habit: ${newHabit.name}");
  }

  Habit updateHabit(Habit habit) {
    habit.toggleCheck();
    habitBox.put(habit);
    
    log("Updated: ${habit.name} auf ${habit.checked}");
    return habit;
  }

  void removeHabit(Habit habit) {
    habitBox.remove(habit.id);
    log("Removed Habit: ${habit.name}");
  }

  Stream<List<Habit>> getSortedHabits() {
    final Stream<List<Habit>> notCheckedHabits = habitBox
      .query(Habit_.checked.equals(false))
      .order(Habit_.name)
      .watch(triggerImmediately: true)
      .map((query) => query.find());
    
    final Stream<List<Habit>> checkedHabits = habitBox
      .query(Habit_.checked.equals(true))
      .order(Habit_.name)
      .watch(triggerImmediately: true)
      .map((query) => query.find());

    return Rx.combineLatest2(
      notCheckedHabits,
      checkedHabits,
      (notCheckedHabits, checkedHabits) {
        return [...notCheckedHabits,...checkedHabits];
      }
    );
  }

  void updateHabitsStatus() {
    final habits = habitBox.getAll();
    for (var habit in habits) {
      habit.checkDailyReset();
      habitBox.put(habit);
      log("Updated: ${habit.name} auf ${habit.checked}");
    }
  }

  //* User Settings
  UserSettings getUserSettings() {
    List<UserSettings> allUserSettings = userSettingsBox.getAll();
    return allUserSettings.first;
  }

  void clearUserSettings() {
    userSettingsBox.removeAll();
    log("User Settings cleared\nCount: ${userSettingsBox.getAll().length}");
  }
}