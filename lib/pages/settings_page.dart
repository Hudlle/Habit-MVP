import 'package:flutter/material.dart';
import 'package:habit_mvp/api/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_mvp/ui_util/theme_locale_provider.dart';
import 'package:habit_mvp/main.dart';

import '../default_data.dart';
import '../default_widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
                text: AppLocalizations.of(context)!.settingsWelcome,
                textType: TextType.headline,
              ),
              const LargeSpacer(),
              SettingsCard(
                icon: Icon(Icons.translate),
                title: AppLocalizations.of(context)!.language,
                route: languageSettingsRoute,
              ),
              const SmallSpacer(),
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return SettingsToggle(
                    icon: Icon(Icons.color_lens),
                    title: AppLocalizations.of(context)!.darkMode,
                    initialValue: themeProvider.isDarkMode,
                    onToggle: (value) {
                      themeProvider.switchTheme();
                    },
                  );
                },
              ),
              const SmallSpacer(),
              SettingsCard(
                icon: Icon(Icons.notifications),
                title: AppLocalizations.of(context)!.notifications,
                route: "",
              ),
              const LargeSpacer(),
              CustomText(
                text: "Developer Settings",
                textType: TextType.title,
              ),
              const SmallSpacer(),
              ElevatedButton(
                onPressed:() {
                  ob.clearUserSettings();
                },
                child: Text("Clear User Settings"),
              ),
              ElevatedButton(
                onPressed:() {
                  AuthService.logout();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Logout Successful"))
                  );
                  Navigator.pushNamedAndRemoveUntil(
                    context, 
                    loginRoute,
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
