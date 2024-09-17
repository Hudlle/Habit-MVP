import 'package:flutter/material.dart';
import 'dart:developer';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  final String welcomeDisplayT = "Hi 🖖";
  final String welcomeTitleT = "Erstelle ein Konto, dann legen wir los!";
  final String signUpSubmitT = "Ran an den Speck!";

  @override
  Widget build(BuildContext context) {
    var welcomeDisplay = Text(
      welcomeDisplayT,
      semanticsLabel: welcomeDisplayT,
      style: Theme.of(context).textTheme.displayMedium,
    );

    var welcomeTitle = Text(
      welcomeTitleT,
      semanticsLabel: welcomeTitleT,
      style: Theme.of(context).textTheme.titleMedium,
    );

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              welcomeDisplay,
              const SizedBox(height: 10),
              welcomeTitle,
              const SizedBox(height: 30),
              const WelcomeTextField(isPassword: false, label: "Nutzername"),
              const WelcomeTextField(isPassword: false, label: "Email"),
              const WelcomeTextField(isPassword: true, label: "Passwort"),
              const WelcomeTextField(isPassword: true, label: "Passwort wiederholen"),
              ElevatedButton(
                onPressed: () {},
                child: Text(signUpSubmitT)
              )
            ],
          )
        ),
      ),
    );
  }
}

class WelcomeTextField extends StatelessWidget {
  const WelcomeTextField({
    super.key,
    required this.isPassword,
    required this.label,
  });

  final bool isPassword;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}