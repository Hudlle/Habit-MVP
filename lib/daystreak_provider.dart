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

  void _updateDayStreak() {
    _dayStreakCounter = db.getDayStreakCounter();
    _dayStreakCounter.update();
    db.dayStreakCounterBox.put(_dayStreakCounter);
  }

  bool updateHabitAndDayStreak(Habit habit) {
    habit.toggleCheck();
    db.habitBox.put(habit);
    _updateDayStreak();
    notifyListeners();
    return habit.checked;
  }

  void updateHabits() {
    db.updateHabitsStatus();
    notifyListeners();
  }
}