import 'package:flutter/material.dart';
import 'main.dart';
import 'model.dart';

class FlamesProvider with ChangeNotifier{
  late Flames flamesEntity;
  late int _flamesCount;

  FlamesProvider() {
    _initializeFlames();
  }

  int get flames => _flamesCount;

  void _initializeFlames() {
    flamesEntity = ob.getFlames();
    _flamesCount = flamesEntity.flames;
  }

  Habit updateHabitAndFlames(Habit habit) {
    // DB
    ob.updateHabitAndFlames(habit);
    // UI
    flamesEntity = ob.getFlames();
    _flamesCount = flamesEntity.flames;
    notifyListeners();
    return habit;
  }

  void resetFlames() {
    // DB
    ob.resetFlames();
    // UI
    flamesEntity = ob.getFlames();
    _flamesCount = flamesEntity.flames;
    notifyListeners();
  }
}