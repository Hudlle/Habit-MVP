import 'package:flutter/material.dart';

import 'default_data.dart';
import 'default_widgets.dart';

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
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(dataSubmitPagesPadding[0], dataSubmitPagesPadding[1], dataSubmitPagesPadding[2], dataSubmitPagesPadding[3]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              logInDisplay,
              const SizedBox(height: 10),
              logInTitle,
              const SizedBox(height: 30),
              const AccountDataTextField(isPassword: false, label: usernameEmailT),
              const AccountDataTextField(isPassword: true, label: passwordT),
              const DataSubmitEB(
                origin: logInRoute,
                route: homeRoute,
                label: logInSubmitT,
              ),
              const SizedBox(height: 30,),
              Center(child: chooseOptionBodyText),
              const SizedBox(height: 30,),
              const DataSubmitOB(
                origin: logInRoute,
                route: homeRoute,
                label: logInGoogleT,
              ),
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
