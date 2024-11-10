// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:habit_mvp/api/authentication_service.dart';
import 'package:habit_mvp/flames_provider.dart';
import 'package:habit_mvp/pages/language_settings.dart';
import 'package:habit_mvp/pages/login_page.dart';
import 'package:habit_mvp/pages/signup_page.dart';
import 'package:provider/provider.dart';
import 'ui_util/color_themes.dart';
import 'ui_util/text_theme.dart';
import 'model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'ui_util/theme_locale_provider.dart';
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => FlamesProvider())
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Consumer<LocaleProvider>(
            builder: (context, localeProvider, child) {
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
                locale: localeProvider.locale,

                //* Routing
                initialRoute: checkUserRoute,
                routes: {
                  loginRoute: (context) => Login(),
                  signupRoute: (context) => Signup(),
                  checkUserRoute: (context) => CheckUser(),
                  
                  homeRoute: (context) => Home(),
                  habitCloseLookRoute: (context) {
                    final habit = ModalRoute.of(context)!.settings.arguments as Habit;
                    return HabitCloseLook(habit: habit);
                  },
                  habitEditRoute: (context) {
                    final habit = ModalRoute.of(context)!.settings.arguments as Habit;
                    return HabitEdit(habit: habit);
                  },
                  newHabitNameRoute: (context) => const NewHabitName(),
                  newHabitDetailRoute: (context) => const NewHabitDetail(),
                  howToGoalRoute: (context) => const HowToGoal(),

                  settingsRoute: (context) => const Settings(),
                  languageSettingsRoute: (context) => const LanguageSettings(),
                },
              );
            }
          );
        },
      ),
    );
  }
}

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    super.initState();
    AuthService.isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, homeRoute);
      } else {
        Navigator.pushReplacementNamed(context, loginRoute);
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}