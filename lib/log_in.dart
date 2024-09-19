import 'package:flutter/material.dart';
import 'dart:developer';

import 'default_data.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    var logInDisplay = Text(
      logInDisplayT,
      semanticsLabel: logInDisplayT,
      style: Theme.of(context).textTheme.displayMedium,
    );

    var logInTitle = Text(
      logInTitleT,
      semanticsLabel: logInTitleT,
      style: Theme.of(context).textTheme.titleMedium,
    );

    var chooseOptionBodyText = Text(
      chooseOptionBodyT,
      semanticsLabel: chooseOptionBodyT,
      style: Theme.of(context).textTheme.bodyMedium,
    );

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              logInDisplay,
              const SizedBox(height: 10),
              logInTitle,
              const SizedBox(height: 30),
              const LogInTextField(isPassword: false, label: usernameEmailT),
              const LogInTextField(isPassword: true, label: passwordT),
              const LogInSubmitEB(label: logInSubmitT),
              const SizedBox(height: 30,),
              Center(child: chooseOptionBodyText),
              const SizedBox(height: 30,),
              const LogInGoogleOB(label: logInGoogleT),
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SignUpToLogInRoutingText(
                        route: signUpRoute,
                        label1: logInToSignUpT1,
                        label2: logInToSignUpT2,
                      )
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

class LogInGoogleOB extends StatelessWidget {
  const LogInGoogleOB({
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

class LogInSubmitEB extends StatelessWidget {
  const LogInSubmitEB({
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

class LogInTextField extends StatelessWidget {
  const LogInTextField({
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
              borderSide: BorderSide(color: Colors.black)
            ),
            labelText: label,
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}