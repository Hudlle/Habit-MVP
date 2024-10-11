import 'package:flutter/material.dart';

import '../default_data.dart';
import '../default_widgets.dart';

class PasswordSettings extends StatelessWidget {
  const PasswordSettings({super.key});

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
                text: passwordSettingsHeadlineT,
                textType: TextType.headline,
              ),
              const LargeSpacer(),
              CustomText(
                text: createNewPasswordT,
                textType: TextType.headline,
              ),
              const SmallSpacer(),
              const ControlledTextField(
                label: newPasswordT,
                initValue: "",
                isPassword: true,
              ),
              const SmallSpacer(),
              const ControlledTextField(
                label: repeatNewPasswordT,
                initValue: "",
                isPassword: true,
              ),
              const SmallSpacer(),
              const ControlledTextField(
                label: oldPasswordT,
                initValue: "",
                isPassword: true,
              ),
              const SmallSpacer(),
              const DataSubmitEB(
                label: saveT,
                origin: passwordSettingsRoute,
                route: homeRoute,
              )    
            ],
          ),
        ),
      ),
    );
  }
}