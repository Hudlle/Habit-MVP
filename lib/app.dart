import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        "/home" : (BuildContext context) => const HomePage(), // TODO: Think about renaming HomePage widget to just "Home" for better referencing, like in "SignUp" instead of "SignUpPage"
        "/sign_up" : (BuildContext context) => const SignUp(),
      },
      theme: ThemeData(
        useMaterial3: true,

        //* Default colors and brightness
        colorScheme: const ColorScheme.light(),
        // TODO: Change primary text color

        //* Default text styles
        textTheme: TextTheme(
          displayMedium: GoogleFonts.abrilFatface(),
        ),
      ),
    );
  }
}