// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:habit_mvp/api/authentication_service.dart';
import 'package:habit_mvp/default_widgets.dart';
import 'package:habit_mvp/flames_provider.dart';
import 'package:habit_mvp/pages/language_settings_page.dart';
import 'package:habit_mvp/pages/login_page.dart';
import 'package:habit_mvp/pages/signup_page.dart';
import 'package:provider/provider.dart';
import 'ui_util/color_themes.dart';
import 'ui_util/text_theme.dart';
import 'model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'ui_util/theme_locale_provider.dart';
import 'default_data.dart';
import 'pages/home_page.dart';
import 'pages/habit_close_look_page.dart';
import 'pages/habit_edit_page.dart';
import 'pages/new_habit_name_page.dart';
import 'pages/new_habit_detail_page.dart';
import 'pages/how_to_goal_page.dart';
import 'pages/settings_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

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
                navigatorKey: navigatorKey,
                initialRoute: checkUserRoute,
                routes: {
                  loginRoute: (context) => LoginPage(),
                  signupRoute: (context) => SignupPage(),
                  checkUserRoute: (context) => CheckUser(),
                  
                  homeRoute: (context) => HomePage(),
                  habitCloseLookRoute: (context) {
                    final String hid = ModalRoute.of(context)!.settings.arguments as String;
                    return HabitCloseLookPage(hid: hid);
                  },
                  habitEditRoute: (context) {
                    final habit = ModalRoute.of(context)!.settings.arguments as Habit;
                    return HabitEditPage(habit: habit);
                  },
                  newHabitNameRoute: (context) => const NewHabitNamePage(),
                  newHabitDetailRoute: (context) => const NewHabitDetailPage(),
                  howToGoalRoute: (context) => const HowToGoalPage(),

                  settingsRoute: (context) => const SettingsPage(),
                  languageSettingsRoute: (context) => const LanguageSettingsPage(),
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