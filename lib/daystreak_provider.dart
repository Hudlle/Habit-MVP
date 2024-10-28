import 'package:flutter/material.dart';
import 'main.dart';
import 'model.dart';

class DayStreakProvider with ChangeNotifier {
  late DayStreakCounter _dayStreakCounter;
  
  DayStreakProvider() {
    _initializeDayStreakCounter();
  }

  int get dayStreakCount => _dayStreakCounter.count;

  void _initializeDayStreakCounter() {
    _dayStreakCounter = db.getDayStreakCounter();
  }

//* Doppelt mit objectbox.dart
  // void _updateDayStreak() {
  //   _dayStreakCounter = db.getDayStreakCounter();
  //   _dayStreakCounter.update();
  //   db.dayStreakCounterBox.put(_dayStreakCounter);
  // }

  // void _updateHabit(Habit habit) {
  //   habit.toggleCheck();
  //   db.habitBox.put(habit);
  // }

  // void updateHabitAndDayStreak(Habit habit) {
  //   _updateHabit(habit);
  //   _updateDayStreak();
  //   notifyListeners();
  // }

  // void updateHabitsAndDayStreak() {
  //   db.updateHabitsStatus();
  //   _updateDayStreak();
  //   notifyListeners();
  // }
}