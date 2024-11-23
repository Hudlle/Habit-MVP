import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';
import 'model.dart';
import 'objectbox.g.dart';
import 'dart:developer';

class ObjectBox {
  //* Store
  late final Store store;

  // late final Box<Habit> habitBox;
  // late final Box<Noti> notificationBox;
  // late final Box<Flames> flamesBox;
  late final Box<UserSettings> userSettingsBox;

  ObjectBox._create(this.store) {
    // habitBox = Box<Habit>(store);
    // notificationBox = Box<Noti>(store);
    // flamesBox = Box<Flames>(store);
    userSettingsBox = Box<UserSettings>(store);

    // // Initialize flames 
    // if (flamesBox.isEmpty()) {
    //   flamesBox.put(Flames());
    //   log("Initialized: Flames");
    // }

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

  //* User Settings
  UserSettings getUserSettings() {
    List<UserSettings> allUserSettings = userSettingsBox.getAll();
    return allUserSettings.first;
  }

  void clearUserSettings() {
    userSettingsBox.removeAll();
    log("User Settings cleared\nCount: ${userSettingsBox.getAll().length}");
  }

  // //* Habits
  // void addHabit(String habitName, String habitDescription) async {
  //   DateTime initalDateTime = DateTime.now();
  //   String hid = await FirestoreService.saveNewHabit(habitName, habitDescription);
  //   Habit newHabit = Habit(hid, habitName, habitDescription, initalDateTime);
  //   Flames flames = getFlames();
  //   flames.habits.add(newHabit);
  //   flamesBox.put(flames);

  //   log("Added Habit: ${newHabit.name}");
  // }

  // void updateHabit(Habit habit) {
  //   habit.toggleCheck();
  //   habitBox.put(habit);
    
  //   log("Updated: ${habit.name} auf ${habit.checked}");
  // }

  // Habit updateHabitAndFlames(Habit habit) {
  //   updateHabit(habit);
  //   updateFlames(habit.checked);
  //   return habit;
  // }

  // void refreshHabitsStatus() {
  //   final habits = habitBox.getAll();
  //   for (var habit in habits) {
  //     habit.checkDailyReset();
  //     habitBox.put(habit);
  //     log("Updated: ${habit.name} auf ${habit.checked}");
  //   }
  // }

  // Stream<List<Habit>> getSortedHabits() {
  //   final Stream<List<Habit>> notCheckedHabits = habitBox
  //     .query(Habit_.checked.equals(false))
  //     .order(Habit_.name)
  //     .watch(triggerImmediately: true)
  //     .map((query) => query.find());
    
  //   final Stream<List<Habit>> checkedHabits = habitBox
  //     .query(Habit_.checked.equals(true))
  //     .order(Habit_.name)
  //     .watch(triggerImmediately: true)
  //     .map((query) => query.find());

  //   return Rx.combineLatest2(
  //     notCheckedHabits,
  //     checkedHabits,
  //     (notCheckedHabits, checkedHabits) {
  //       return [...notCheckedHabits,...checkedHabits];
  //     }
  //   );
  // }

  // void removeHabit(Habit habit) {
  //   FirestoreService.deleteHabit(habit.hid);
  //   habitBox.remove(habit.id);
  //   log("Removed Habit: ${habit.name}");
  // }

  // void removeAllHabits() {
  //   habitBox.removeAll();
  //   log("Removed all Habits");
  // }

  // //* Notfications
  // // void addNotification(Habit habit, TimeOfDay timeOfDay) async {
  // //   String notificationTime = _formatTimeOfDayToString(timeOfDay);

  // //   String nid = await FirestoreService.saveNewNotification(habit, notificationTime);
  // //   Noti newNotification = Noti(nid, notificationTime);

  // //   habit.notifications.add(newNotification);
  // //   habitBox.put(habit);

  // //   log("Added notification: ${newNotification.notificationTime}");
  // // }

  // String _formatTimeOfDayToString(TimeOfDay timeOfDay) {
  //   final now = DateTime.now();
  //   final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  //   String formatted = DateFormat("HH:mm").format(dateTime);
  //   return formatted;
  // }

  // Stream<List<Noti>> getHabitNotifications(Habit habit) {
  //   final Stream<List<Noti>> habitNotifications = notificationBox
  //     .query(Noti_.habit.equals(habit.id))
  //     .watch(triggerImmediately: true)
  //     .map((query) => query.find());

  //   return habitNotifications;
  // }

  // // void removeNotification(Noti notification) {
  // //   FirestoreService.deleteNotification(notification);
  // //   notificationBox.remove(notification.id);
  // //   log("Removed notification: ${notification.notificationTime}");
  // // }

  // //* Flames
  // Flames getFlames() {
  //   List<Flames> allFlames = flamesBox.getAll();
  //   return allFlames.first;
  // }

  // void updateFlames(bool checked) {
  //   Flames flames = getFlames();
  //   flames.updateFlames(checked);
  //   flamesBox.put(flames);
  // }

  // void resetFlames() {
  //   Flames flames = getFlames();
  //   flames.flames = 0;
  //   flamesBox.put(flames);
  //   log("Zurückgesetzt: Flames auf ${flames.flames}");
  // }
}