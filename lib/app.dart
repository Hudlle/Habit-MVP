import 'package:flutter/material.dart';

import 'home.dart';

class HabitApp extends StatelessWidget {
  const HabitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Habit",
      initialRoute: "/home",
      routes: {
        "/home" : (BuildContext context) => const HomePage(),
      },
    );
  }
}