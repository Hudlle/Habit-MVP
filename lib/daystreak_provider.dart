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

  void updateDayStreak() {
    _dayStreakCounter = db.getDayStreakCounter();
    _dayStreakCounter.update();
    db.dayStreakCounterBox.put(_dayStreakCounter);
    notifyListeners();
  }
}