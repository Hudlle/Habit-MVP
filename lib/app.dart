import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'default_data.dart';
import 'home.dart';
import 'sign_up.dart';
import 'log_in.dart';

class HabitApp extends StatelessWidget {
  const HabitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Habit",
      initialRoute: "/log_in",
      routes: {
        "/home" : (BuildContext context) => const Home(), 
        "/sign_up" : (BuildContext context) => const SignUp(),
        "/log_in" : (BuildContext context) => const LogIn(),
      },
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: const ColorScheme.light(), // TODO: Change primary text color,
        
        textTheme: TextTheme(
          displayMedium: GoogleFonts.abrilFatface(),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: textFieldFocus)
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
      ),
    );
  }
}