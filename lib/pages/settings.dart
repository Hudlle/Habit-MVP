import 'package:flutter/material.dart';

import '../default_data.dart';
import '../default_widgets.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(defaultPagePadding[0], defaultPagePadding[1], defaultPagePadding[2], defaultPagePadding[3]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: settingsHeadlineT,
                textType: TextType.headline,
              ),
              const LargeSpacer(),
              const SettingsCard(
                icon: Icon(Icons.person),
                title: accountSettingsT,
                route: accountSettingsRoute,
              ),
              const LargeSpacer(),
              GestureDetector(
                onTap:() {
                  Navigator.pushNamedAndRemoveUntil(
                    context, 
                    logInRoute, 
                    (Route<dynamic> route) => false,
                  );
                },
                child: Card.outlined(
                  shape: OutlineInputBorder(
                    borderSide: const BorderSide(color:borderOutline),
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                  ),
                  child: const Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text(logOutSettingsT),
                      )
                    ],
                  )
                ),
              ),
            ],
          )
        )
      )
    );
  }
}
