import 'package:flutter/material.dart';

import '../default_data.dart';
import '../default_widgets.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(defaultPagePadding[0], defaultPagePadding[1], defaultPagePadding[2], defaultPagePadding[3]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: logInHeadlineT,
                textType: TextType.headline
              ),
              const SmallSpacer(),
              CustomText(
                text: logInTitleT,
                textType: TextType.title
              ),
              const LargeSpacer(),
              const ControlledTextField(isPassword: false, label: usernameEmailT, initValue: ""),
              const SmallSpacer(),
              const ControlledTextField(isPassword: true, label: passwordT, initValue: ""),
              const SmallSpacer(),
              const DataSubmitEB(
                origin: logInRoute,
                route: homeRoute,
                label: logInSubmitT,
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
