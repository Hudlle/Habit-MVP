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
  late final Box<Flames> flamesBox;
  late final Box<UserSettings> userSettingsBox;

  ObjectBox._create(this.store) {
    habitBox = Box<Habit>(store);
    flamesBox = Box<Flames>(store);
    userSettingsBox = Box<UserSettings>(store);

    // Initialize flames 
    if (flamesBox.isEmpty()) {
      flamesBox.put(Flames());
      log("Initialized: Flames");
    }

    // Initialize User Settings
    if (userSettingsBox.isEmpty()) {
      Locale userLocale = Locale(Platform.localeName);
      userSettingsBox.put(UserSettings(userLocale.languageCode));
      log("Initialized: User Settings");
    }
  }

  static Future<ObjectBox> create() async {
    return ObjectBox._create(await openStore());
  }

  //* Habits
  void addHabit(String habitName, String habitDescription) {
    DateTime initalDateTime = DateTime.now();
    Habit newHabit = Habit(habitName, habitDescription, initalDateTime);
    Flames flames = getFlames();
    flames.habits.add(newHabit);
    flamesBox.put(flames);

    log("Added Habit: ${newHabit.name}");
  }

  void updateHabit(Habit habit) {
    habit.toggleCheck();
    habitBox.put(habit);
    
    log("Updated: ${habit.name} auf ${habit.checked}");
  }

  Habit updateHabitAndFlames(Habit habit) {
    updateHabit(habit);
    updateFlames(habit.checked);
    return habit;
  }

  void refreshHabitsStatus() {
    final habits = habitBox.getAll();
    for (var habit in habits) {
      habit.checkDailyReset();
      habitBox.put(habit);
      log("Updated: ${habit.name} auf ${habit.checked}");
    }
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

  void removeHabit(Habit habit) {
    habitBox.remove(habit.id);
    log("Removed Habit: ${habit.name}");
  }

  void removeAllHabits() {
    habitBox.removeAll();
    log("Removed all Habits");
  }

  //* Flames
  Flames getFlames() {
    List<Flames> allFlames = flamesBox.getAll();
    return allFlames.first;
  }

  void updateFlames(bool checked) {
    Flames flames = getFlames();
    flames.updateFlames(checked);
    flamesBox.put(flames);
  }

  void resetFlames() {
    Flames flames = getFlames();
    flames.flames = 0;
    flamesBox.put(flames);
    log("Zurückgesetzt: Flames auf ${flames.flames}");
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