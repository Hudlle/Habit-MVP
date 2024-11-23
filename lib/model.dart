import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserSettings {
  @Id()
  int id;

  bool isDarkMode;
  String localeCode;

  UserSettings(
    this.localeCode,
  {
    this.id = 0,
    this.isDarkMode = true,
  });

  ThemeMode getThemeMode() {
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Locale get locale => Locale(localeCode);

  void changeLocale(Locale newLocale) {
    localeCode = newLocale.languageCode;
  }
}

// @Entity()
// class Habit{
//   @Index()
//   String hid;

//   int id;
//   String name;
//   String description;
//   int streak;
//   bool checked;
//   DateTime lastChecked;

//   Habit(
//     this.hid,
//     this.name,
//     this.description,
//     this.lastChecked,
//     {
//       this.id = 0,
//       this.streak = 0,
//       this.checked = false,
//     });

//   //* Relation
//   @Backlink("habit")
//   final notifications = ToMany<Noti>();

//   final flames = ToOne<Flames>();

//   //* Functions
//   bool toggleCheck() {
//     checked = !checked;

//     if (checked) {
//       streak ++;
//     } else {
//       streak --;
//     }

//     lastChecked = DateTime.now();
//     return checked;
//   }

//   void editName(String newName) {
//     name = newName;
//   }

//   void editDescription(String newDescription) {
//     description = newDescription;
//   }

//   void checkDailyReset() {
//     DateTime now = DateTime.now();
//     bool isSameDay = _isSameTestDay(lastChecked);

//     if (!isSameDay && !checked) { // Wenn es ein anderer Tag ist und es unchecked ist, setzte streak auf 0 zurück
//       streak = 0;
//       log("Zurückgesetzt: $name");
//     } 
//     if (!isSameDay) { // Wenn es NUR ein anderer Tag ist, setzte checked = false
//       checked = false;
//     }

//     lastChecked = now;
//   }

//   bool _isSameDay(DateTime date1, DateTime date2) {
//     return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
//   }

//   bool _isSameTestDay(DateTime lastChecked) {
//     DateTime now = DateTime.now();
//     Duration difference = now.difference(lastChecked);

//     return difference.inSeconds < 5;
//   }
// }

// @Entity()
// class Noti {
//   @Index()
//   String nid;

//   int id;
//   String notificationTime;

//   Noti(
//     this.nid,
//     this.notificationTime,
//   {
//     this.id = 0,
//   });

//   final habit = ToOne<Habit>();
// }

// @Entity()
// class Flames {
//   @Id()
//   int id;

//   int flames;

//   Flames({
//     this.id = 0,
//     this.flames = 0,
//   });

//   @Backlink("flames")
//   final habits = ToMany<Habit>();

//   void updateFlames(bool checked) {
//     if(checked) {
//       flames ++;
//       log("Flames erhöht auf $flames");
//     } else {
//       flames --;
//       log("Flames verringert auf $flames");
//     }
//   }
// }