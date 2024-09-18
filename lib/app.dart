import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_texts.dart';
import 'home.dart';
import 'sign_up.dart';

class HabitApp extends StatelessWidget {
  const HabitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Habit",
      initialRoute: "/sign_up",
      routes: {
        "/home" : (BuildContext context) => const Home(), 
        "/sign_up" : (BuildContext context) => const SignUp(),
      },
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: const ColorScheme.light(), // TODO: Change primary text color,
        
        textTheme: TextTheme(
          displayMedium: GoogleFonts.abrilFatface(),
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
          )
        )
      ),
    );
  }
}