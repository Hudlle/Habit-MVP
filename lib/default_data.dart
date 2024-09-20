import 'package:flutter/material.dart';

//* Colors
const Color primary = Color(0xff1DD1A1);
const Color onPrimary = Color(0xffffffff);
const Color textFieldFocus = Colors.black;

//* German texts
// Data
const String usernameT = "Nutzername";
const String emailT = "Email";
const String usernameEmailT = "Nutzername oder Email";
const String passwordT = "Passwort";
const String repeatPasswordT = "Passwort wiederholen";

// Sign Up
const String signUpDisplayT = "Hi 🖖";
const String signUpTitleT = "Erstelle ein Konto, dann legen wir los!";
const String signUpSubmitT = "Ran an den Speck!";
const String chooseOptionBodyT = "Oder";
const String signUpGoogleT = "Mit Google registrieren";
const String signUpToLogInT1 = "Du hast schon ein Konto?";
const String signUpToLogInT2 = "Logg Dich ein.";

// Log In
const String logInDisplayT = "Willkommen zurück ✌️";
const String logInTitleT = "Logg Dich ein, dann machen wir weiter!";
const String logInSubmitT = "Here we go again.";
const String logInGoogleT = "Mit Google einloggen";
const String logInToSignUpT1 = "Du hast noch kein Konto?";
const String logInToSignUpT2 = "Erstelle eins.";

// Home
const String daystreakT = "Tagesstreak";

//* Data and Routes
// Front End Data
const double submitButtonHeight = 56;
const pagePadding = <double>[50, 50, 50, 50];
const double checkButtonSize = 75;

// Back End / User Data
const int daystreak = 42;
const int habitCount = 4;
const habitNames = <String>["Lesen", "Tschechisch", "Schreiben", "Liegestütz"];
const habitDescriptions = <String>["6 Seiten pro Tag", "5 Lektionen pro Tag", "350 Wörter pro Tag", "12 pro Tag"];
const habitStreaks = <int>[36, 37, 42, 42];  

// Routes
const String homeRoute = "/";
const String signUpRoute = "/sign_up";
const String logInRoute = "/log_in";
