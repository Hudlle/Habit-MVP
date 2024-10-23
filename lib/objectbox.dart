import 'package:rxdart/rxdart.dart';

import 'model.dart';
import 'objectbox.g.dart';
import 'dart:developer';

class ObjectBox {
  //* Store
  late final Store store;

  late final Box<Habit> habitBox;
  late final Box<DayStreakCounter> dayStreakCounterBox;
  late final Box<UserSettings> userSettingsBox;

  ObjectBox._create(this.store) {
    habitBox = Box<Habit>(store);
    dayStreakCounterBox = Box<DayStreakCounter>(store);
    userSettingsBox = Box<UserSettings>(store);

    // Initialize DayStreakCounter
    if (dayStreakCounterBox.isEmpty()) {
      dayStreakCounterBox.put(DayStreakCounter(DateTime.now()));
    }

    // Initialize User Settings
    if (userSettingsBox.isEmpty()) {
     userSettingsBox.put(UserSettings());
    }
  }

  static Future<ObjectBox> create() async {
    return ObjectBox._create(await openStore());
  }

  //* Habits
  void addHabit(String habitName, String habitDescription) {
    DateTime initalDateTime = DateTime.now();
    Habit newHabit = Habit(habitName, habitDescription, initalDateTime);
    DayStreakCounter dayStreakCounter = getDayStreakCounter();

    dayStreakCounter.habits.add(newHabit);
    dayStreakCounterBox.put(dayStreakCounter);
    
    log("Added Habit: ${newHabit.name}");
  }

  Stream<List<Habit>> getHabits() {
    final Stream<List<Habit>> notCheckedHabits = habitBox
      .query(Habit_.checked.equals(false))
      .order(Habit_.name, flags: Order.descending)
      .watch(triggerImmediately: true)
      .map((query) => query.find());
    
    final Stream<List<Habit>> checkedHabits = habitBox
      .query(Habit_.checked.equals(true))
      .order(Habit_.name, flags: Order.descending)
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
    }
  }

  //* Daystreak Counter
  DayStreakCounter getDayStreakCounter() {
    final List<DayStreakCounter> counters = dayStreakCounterBox.getAll();
    return counters.first;
  }

  //* User Settings
  UserSettings getUserSettings() {
    final List<UserSettings> allUserSettings = userSettingsBox.getAll();
    return allUserSettings.first;
  }
}