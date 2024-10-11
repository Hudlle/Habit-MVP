import 'package:flutter/material.dart';

//* Colors
const Color primary = Color(0xff1DD1A1);
const Color onPrimary = Color(0xffffffff);
const Color error = Colors.red;
Color? hint = Colors.grey[700];
const Color focusedBorderOutline = Colors.black;
const Color borderOutline = Color(0xff636e72);

//* German texts
// Data
const String usernameT = "Nutzername";
const String emailT = "Email";
const String usernameEmailT = "Nutzername oder Email";
const String passwordT = "Passwort";
const String repeatPasswordT = "Passwort wiederholen";

// Sign Up
const String signUpHeadlineT = "Hi 🖖";
const String signUpTitleT = "Erstelle ein Konto, dann legen wir los!";
const String signUpSubmitT = "Ran an den Speck!";
const String chooseOptionBodyT = "Oder";
const String signUpGoogleT = "Mit Google registrieren";
const String signUpToLogInT1 = "Du hast schon ein Konto?";
const String signUpToLogInT2 = "Logg Dich ein.";

// Log In
const String logInHeadlineT = "Willkommen zurück ✌️";
const String logInTitleT = "Logg Dich ein, dann machen wir weiter!";
const String logInSubmitT = "Here we go again.";
const String logInGoogleT = "Mit Google einloggen";
const String logInToSignUpT1 = "Du hast noch kein Konto?";
const String logInToSignUpT2 = "Erstelle eins.";

// Home
const String daystreakT = "Tagesstreak";

// Habit Close Look
const String yourGoalTitleT = "Dein Ziel";
const String deleteHabitT = "Gewohnheit löschen";

// New Habit Name
const String newHabitNameHeadlineT = "Wie heißt die neue Gewohnheit?";
const String newHabitNameHintT = "z.B. Lesen";
const String newHabitNameEmptyErrorT = "Gib deiner Gewohnheit einen Namen";

// New Habit Detail
const String newHabitDetailHeadlineT = "Definiere Dein Ziel";
const String howToGoalT = "Wie setze ich mir ein gutes Ziel?";
const String newHabitDetailHintT = "z.B. 5 Seiten";
const String newHabitDetailEmptyErrorT = "Beschreibe Dein tägliches Ziel";
const String checkIntervalT = "pro Tag";

// How To Goal
const String howToGoalHeadlineT= howToGoalT;
const String howToGoalPT = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.";

// Settings
const String settingsHeadlineT = "Einstellungen";
const String accountSettingsT = "Konto";
const String notificationSettingsT = "Benachrichtigungen";
const String logOutSettingsT = "Abmelden";
const String saveT = "Speichern";

// Account Settings
const String accountSettingsHeadlineT = "Konto Einstellungen";
const String emailPasswordTitleT = "Email und Passwort";
const String dangerZoneTitleT = "Gefahrenzone";
const String deleteAccountT = "Konto löschen";

// Password Settings
const String passwordSettingsHeadlineT = "Passwort Einstellungen";
const String createNewPasswordT = "Neues Passwort erstellen";
const String newPasswordT = "Neues Passwort";
const String repeatNewPasswordT = "Neues Passwort wiederholen";
const String oldPasswordT = "Altes Passwort";

//* Data and Routes
// Front End Data
const double textFieldHeight = 60;
const double textFieldBorderRadius = 10;
const double cardHeight = 60;
const double cardBorderRadius = 10;
const double submitButtonHeight = 60;
const double submitButtonBorderRadius = 50;
const double checkButtonSize = 75;
const double smallSpacing = 10;
const double largeSpacing = 30;
const defaultPagePadding = <double>[25,25,25,25];
const homePagePadding = <double>[25,25,25,25];

// Routes
const String homeRoute = "/";
const String habitCloseLookRoute = "/habit_close_look";
const String newHabitNameRoute = "/new_habit_name";
const String newHabitDetailRoute = "/new_habit_detail";
const String howToGoalRoute = "/how_to_goal";
const String signUpRoute = "/sign_up";
const String logInRoute = "/log_in";
const String settingsRoute = "/settings";
const String accountSettingsRoute = "/account_settings";
const String passwordSettingsRoute = "/password_settings";
