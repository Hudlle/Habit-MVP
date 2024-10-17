import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model.dart';

import 'default_data.dart';
import 'pages/home.dart';
import 'pages/habit_close_look.dart';
import 'pages/habit_edit.dart';
import 'pages/new_habit_name.dart';
import 'pages/new_habit_detail.dart';
import 'pages/how_to_goal.dart';
import 'pages/settings.dart';

class HabitApp extends StatelessWidget {
  const HabitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Habit",
      debugShowCheckedModeBanner: false,
      initialRoute: homeRoute,
      routes: {
        homeRoute : (BuildContext context) => const Home(),
        habitCloseLookRoute : (BuildContext context) {
          final habit = ModalRoute.of(context)!.settings.arguments as Habit;
          return HabitCloseLook(habit: habit);
        },
        habitEditRoute : (BuildContext context) {
          final habit = ModalRoute.of(context)!.settings.arguments as Habit;
          return HabitEdit(habit: habit);        
        },
        newHabitNameRoute : (BuildContext context) => const NewHabitName(),
        newHabitDetailRoute : (BuildContext context) => const NewHabitDetail(),
        howToGoalRoute : (BuildContext context) => const HowToGoal(),

        settingsRoute: (BuildContext context) => const Settings(),
      },
      theme: ThemeData(
        useMaterial3: true,

        textTheme: GoogleFonts.notoSerifTextTheme(
          Theme.of(context).textTheme,
        ),

        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: focusedBorderOutline)
        ),

        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: onPrimary,
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primary,
          ),
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: onPrimary,
          )
        )
      ),
    );
  }
}