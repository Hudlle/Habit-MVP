import 'package:objectbox/objectbox.dart';

@Entity()
class Habit{
  @Id()
  int id;

  String name;
  String description;
  int streak;
  bool checked;
  bool canBeChecked;
  DateTime lastChecked;

  Habit(
    this.name,
    this.description,
    this.lastChecked,
    {
      this.id = 0,
      this.streak = 0,
      this.checked = false,
      this.canBeChecked = true,
    }
  );

  void checkDailyReset() {
    DateTime now = DateTime.now();

    if (!_isSameTestDay(lastChecked)) {
      if(checked) {
        checked = false;
      }
      lastChecked = now;
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  bool _isSameTestDay(DateTime lastChecked) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(lastChecked);

    return difference.inSeconds < 2;
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
}
