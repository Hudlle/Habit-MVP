import 'package:flutter/material.dart';

import '../default_data.dart';
import '../default_widgets.dart';

class PasswordSettings extends StatelessWidget {
  const PasswordSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var passwordSettingsDisplay = Text(
      passwordSettingsDisplayT,
      semanticsLabel: passwordSettingsDisplayT,
      style: Theme.of(context).textTheme.displayMedium,
    );

    var newPasswordTitle = Text(
      createNewPasswordT,
      semanticsLabel: createNewPasswordT,
      style: Theme.of(context).textTheme.titleMedium
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
              passwordSettingsDisplay,
              const LargeSpacer(),
              newPasswordTitle,
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
                route: "",
              )    
            ],
          ),
        ),
      ),
    );
  }
}