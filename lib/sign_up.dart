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
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(dataSubmitPagesPadding[0], dataSubmitPagesPadding[1], dataSubmitPagesPadding[2], dataSubmitPagesPadding[3]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              signUpDisplay,
              const SizedBox(height: 10),
              signUpTitle,
              const SizedBox(height: 30),
              const AccountDataTextField(isPassword: false, label: usernameT),
              const AccountDataTextField(isPassword: false, label: emailT),
              const AccountDataTextField(isPassword: true, label: passwordT),
              const AccountDataTextField(isPassword: true, label: repeatPasswordT),
              const DataSubmitEB(
                origin: signUpRoute,
                route: homeRoute,
                label: signUpSubmitT,
              ),
              const SizedBox(height: 30,),
              Center(child: chooseOptionBodyText),
              const SizedBox(height: 30,),
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