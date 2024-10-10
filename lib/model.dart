import 'package:objectbox/objectbox.dart';

@Entity()
class Habit{
  @Id()
  int id;

  String name;
  String description;
  int streak;
  bool checked;

  Habit(
    this.name,
    this.description,
    {
      this.id = 0,
      this.streak = 0,
      this.checked = false
    }
  );

  bool toggleCheck() {
    checked = !checked;
    if (checked) {
      streak ++;
    } else {
      streak --;
    }
    return checked;
  }
}
