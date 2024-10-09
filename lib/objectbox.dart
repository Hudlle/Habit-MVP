import 'package:rxdart/rxdart.dart';

import 'model.dart';
import 'objectbox.g.dart';
import 'dart:developer';

class ObjectBox {
  late final Store store;

  late final Box<Habit> habitBox;

  ObjectBox._create(this.store) {
    habitBox = Box<Habit>(store);
  }

  static Future<ObjectBox> create() async {
    return ObjectBox._create(await openStore());
  }

  void addHabit(String habitName, habitDescription) {
    Habit newHabit = Habit(habitName, habitDescription);
    habitBox.put(newHabit);
    
    log("Added Habit ${newHabit.name}");
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
}