import 'package:flutter/material.dart';
import 'dart:developer';

import 'default_data.dart';

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

// Elevated Button for submitting user input
class DataSubmitEB extends StatelessWidget {
  const DataSubmitEB({
    super.key,
    required this.origin,
    required this.route,
    required this.label,
  });

  final String origin;
  final String route;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: submitButtonHeight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, homeRoute);
                log(label);
              },
              child: Text(label)
            ),
          ),
        ),
      ],
    );
  }
}

// Outlined Button for submitting user input
class DataSubmitOB extends StatelessWidget {
  const DataSubmitOB({
    super.key,
    required this.origin,
    required this.route,
    required this.label,
  });

  final String origin;
  final String route;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: submitButtonHeight,
            child: OutlinedButton(
              onPressed:() {
                Navigator.pushReplacementNamed(context, homeRoute);
                log(label);
              },
              child: Text(label)
            ),
          ),
        ),
      ],
    );
  }
}

// Text fields used for first user input for account creation on sign up or log in page,
// later possibly used more broadly
class AccountDataTextField extends StatelessWidget {
  const AccountDataTextField({
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
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: textFieldFocus),
            ),
            labelText: label,
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}