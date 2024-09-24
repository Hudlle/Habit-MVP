import 'package:flutter/material.dart';

import 'default_data.dart';
import 'default_widgets.dart';

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

    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(defaultPagePadding[0], defaultPagePadding[1], defaultPagePadding[2], defaultPagePadding[3]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              signUpDisplay,
              const SizedBox(height: smallSpacing),
              signUpTitle,
              const SizedBox(height: largeSpacing),
              const ControlledTextField(isPassword: false, label: usernameT, initValue: ""),
              const SizedBox(height: smallSpacing),
              const ControlledTextField(isPassword: false, label: emailT, initValue: ""),
              const SizedBox(height: smallSpacing),
              const ControlledTextField(isPassword: true, label: passwordT, initValue: ""),
              const SizedBox(height: smallSpacing),
              const ControlledTextField(isPassword: true, label: repeatPasswordT, initValue: ""),
              const SizedBox(height: smallSpacing),
              const DataSubmitEB(
                origin: signUpRoute,
                route: homeRoute,
                label: signUpSubmitT,
              ),
              const SizedBox(height: largeSpacing,),
              Center(child: chooseOptionBodyText),
              const SizedBox(height: largeSpacing,),
              const DataSubmitOB(
                origin: signUpRoute,
                route: homeRoute,
                label: signUpGoogleT,
              ),
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SignUpToLogInRoutingText(
                        route: logInRoute,
                        label1: signUpToLogInT1, 
                        label2: signUpToLogInT2
                      ),
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