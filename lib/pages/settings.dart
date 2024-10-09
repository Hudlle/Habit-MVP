import 'package:flutter/material.dart';

import '../default_data.dart';
import '../default_widgets.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var settingsDisplay = Text(
      settingsDisplayT,
      semanticsLabel: settingsDisplayT,
      style: Theme.of(context).textTheme.displayMedium,
    );

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(defaultPagePadding[0], defaultPagePadding[1], defaultPagePadding[2], defaultPagePadding[3]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              settingsDisplay,
              const LargeSpacer(),
              const SettingsCard(
                icon: Icon(Icons.person),
                title: accountSettingsT,
                route: accountSettingsRoute,
              ),
              const LargeSpacer(),
              GestureDetector(
                onTap:() {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, logInRoute);
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
