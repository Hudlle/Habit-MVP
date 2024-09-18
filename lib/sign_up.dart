import 'package:flutter/material.dart';
import 'dart:developer';

import 'colors_texts.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var signUpDisplay = Text(
      signUpDisplayT,
      semanticsLabel: signUpDisplayT,
      style: Theme.of(context).textTheme.displayMedium,
    );

    var signUpTitle = Text(
      signUpTitleT,
      semanticsLabel: signUpTitleT,
      style: Theme.of(context).textTheme.titleMedium,
    );

    var chooseOptionBodyText = Text(
      chooseOptionBodyT,
      semanticsLabel: chooseOptionBodyT,
      style: Theme.of(context).textTheme.bodyMedium,
    );

    var signUpToLogInBodyText1 = Text(
      signUpToLogInT1,
      semanticsLabel: signUpToLogInT1,
      style: Theme.of(context).textTheme.bodyMedium,
    );

    var signUpToLogInBodyText2 = Text(
      signUpToLogInT2,
      semanticsLabel: signUpToLogInT2,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: primary,
      ),
    );

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              signUpDisplay,
              const SizedBox(height: 10),
              signUpTitle,
              const SizedBox(height: 30),
              const SignUpTextField(isPassword: false, label: usernameT),
              const SignUpTextField(isPassword: false, label: emailT),
              const SignUpTextField(isPassword: true, label: passwordT),
              const SignUpTextField(isPassword: true, label: repeatPasswordT),
              const SignUpSubmitEB(label: signUpSubmitT),
              const SizedBox(height: 30,),
              Center(child: chooseOptionBodyText),
              const SizedBox(height: 30,),
              const SignUpGoogleOB(label: signUpGoogleT),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      signUpToLogInBodyText1,
                      signUpToLogInBodyText2
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}

class SignUpGoogleOB extends StatelessWidget {
  const SignUpGoogleOB({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: submitButtonHeight,
            child: OutlinedButton(
              onPressed:() {log(label);},
              child: Text(label)
            ),
          ),
        ),
      ],
    );
  }
}

class SignUpSubmitEB extends StatelessWidget {
  const SignUpSubmitEB({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: submitButtonHeight,
            child: ElevatedButton(
              onPressed: () {log(label);},
              child: Text(label)
            ),
          ),
        ),
      ],
    );
  }
}

class SignUpTextField extends StatelessWidget {
  const SignUpTextField({
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