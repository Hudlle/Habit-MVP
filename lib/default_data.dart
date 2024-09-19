import 'package:flutter/material.dart';

//* Colors
const Color primary = Color(0xff1DD1A1);
const Color onPrimary = Color(0xffffffff);
const Color textFieldFocus = Colors.black;

//* Texts
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

//* Data and Routes
// Data
const double submitButtonHeight = 56;

// Routes
const String homeRoute = "/home";
const String signUpRoute = "/sign_up";
const String logInRoute = "/log_in";

//* Outsourced Widgets
// Routing text used on log in and sign up screen to navigate between each other
class SignUpToLogInRoutingText extends StatelessWidget {
  const SignUpToLogInRoutingText({
    super.key,
    required this.route,
    required this.label1,
    required this.label2,
  });

  final String route;
  final String label1;
  final String label2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: "$label1\n",
            ),
            TextSpan(
              text: label2,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
