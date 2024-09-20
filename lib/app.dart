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
      debugShowCheckedModeBanner: false,
      initialRoute: homeRoute,
      routes: {
        homeRoute : (BuildContext context) => const Home(), 
        signUpRoute : (BuildContext context) => const SignUp(),
        logInRoute : (BuildContext context) => const LogIn(),
      },
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: const ColorScheme.light(), 
        
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