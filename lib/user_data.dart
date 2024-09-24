// Account
const String usernameD = "Paul";
const String emailD = "faustmann.paul@gmail.com";

// Habits
const int daystreak = 42;

class Habit {
  String name;
  String description;
  int streak;
  bool checked;

  Habit({
    required this.name,
    required this.description,
    required this.streak,
    required this.checked,
  });
}

List<Habit> userHabits = [
  Habit(
    name: "Lesen",
    description: "6 Seiten pro Tag",
    streak: 42,
    checked: true,
  ),
  Habit(
    name: "Tschechisch",
    description: "5 Lektionen pro Tag",
    streak: 36,
    checked: false,
  ),
  Habit(
    name: "Schreiben",
    description: "350 Wörter pro Tag",
    streak: 37,
    checked: false,
  ),
  Habit(
    name: "Liegestütz",
    description: "12 pro Tag",
    streak: 42,
    checked: true,
  ),
  Habit(
    name: "Joggen",
    description: "1 Runde pro Tag",
    streak: 18,
    checked: true,
  ),
  Habit(
    name: "Programmieren",
    description: "10 Minuten pro Tag",
    streak: 23,
    checked: true,
  ),
];