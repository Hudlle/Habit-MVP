import 'package:flutter/material.dart';

import '../default_data.dart';
import '../default_widgets.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
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
              CustomText(
                text: signUpHeadlineT,
                textType: TextType.headline,
              ),
              const SmallSpacer(),
              CustomText(
                text: signUpTitleT,
                textType: TextType.title,
              ),
              const LargeSpacer(),
              const ControlledTextField(isPassword: false, label: usernameT, initValue: ""),
              const SmallSpacer(),
              const ControlledTextField(isPassword: false, label: emailT, initValue: ""),
              const SmallSpacer(),
              const ControlledTextField(isPassword: true, label: passwordT, initValue: ""),
              const SmallSpacer(),
              const ControlledTextField(isPassword: true, label: repeatPasswordT, initValue: ""),
              const SmallSpacer(),
              const DataSubmitEB(
                origin: signUpRoute,
                route: homeRoute,
                label: signUpSubmitT,
              ),
              const SizedBox(height: largeSpacing,),
              Center(
                child: CustomText(
                  text: chooseOptionBodyT,
                  textType: TextType.body,
                )
              ),
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