import 'package:flutter/material.dart';
import 'dart:developer';

import '../default_data.dart';
import '../default_widgets.dart';
import '../user_data.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

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
                text: accountSettingsHeadlineT,
                textType: TextType.headline
              ),
              const LargeSpacer(),
              CustomText(
                text: usernameT,
                textType: TextType.title,
              ),
              const SmallSpacer(),
              const ControlledTextField(
                label: "",
                initValue: usernameD,
                isPassword: false,
              ),
              const LargeSpacer(),
              CustomText(
                text: emailPasswordTitleT,
                textType: TextType.title
              ),
              const SmallSpacer(),
              const ControlledTextField(
                label: "",
                initValue: emailD,
                isPassword: false,
              ),
              const SmallSpacer(),
              const SettingsCard(
                icon: Icon(Icons.password), 
                title: passwordT, 
                route: passwordSettingsRoute
              ),
              const SmallSpacer(),
              const DataSubmitEB(
                origin: accountSettingsRoute, 
                route: homeRoute, 
                label: saveT
              ),
              const LargeSpacer(),
              CustomText(
                text: dangerZoneTitleT,
                textType: TextType.title,
              ),
              const SmallSpacer(),
              GestureDetector(
                onTap: () {
                  log("Konto löschen, aber sofort!");
                },
                child: Card.outlined(
                  shape: OutlineInputBorder(
                    borderSide: const BorderSide(color: borderOutline),
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                  ),
                  child: const Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.delete),
                        title: Text(deleteAccountT),
                      )
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

