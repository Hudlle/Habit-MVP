import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui_util/color_themes.dart';
import 'ui_util/text_theme.dart';
import 'model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'ui_util/theme_provider.dart';
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
    //* Theme Preparations
    TextTheme textTheme = createTextTheme(context, "Noto Serif", "Noto Serif");
    MaterialTheme theme = MaterialTheme(textTheme);

    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: "Habit",

            //* Theme 
            theme: theme.light(),
            darkTheme: theme.dark(),
            themeMode: themeProvider.themeMode,

            //* Internationalization / Language Support
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            locale: Locale("de"), // TODO locale setting hinzufügen

            //* Routing
            initialRoute: homeRoute,
            routes: {
              homeRoute: (BuildContext context) => const Home(),
              habitCloseLookRoute: (BuildContext context) {
                final habit = ModalRoute.of(context)!.settings.arguments as Habit;
                return HabitCloseLook(habit: habit);
              },
              habitEditRoute: (BuildContext context) {
                final habit = ModalRoute.of(context)!.settings.arguments as Habit;
                return HabitEdit(habit: habit);
              },
              newHabitNameRoute: (BuildContext context) => const NewHabitName(),
              newHabitDetailRoute: (BuildContext context) => const NewHabitDetail(),
              howToGoalRoute: (BuildContext context) => const HowToGoal(),

              settingsRoute: (BuildContext context) => const Settings(),
            },
          );
        },
      ),
    );
  }
}