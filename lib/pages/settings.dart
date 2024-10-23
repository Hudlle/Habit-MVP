import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_mvp/ui_util/theme_provider.dart';

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
                text: AppLocalizations.of(context)!.settingsWelcome,
                textType: TextType.headline,
              ),
              const LargeSpacer(),
              SettingsCard(
                icon: Icon(Icons.translate),
                title: AppLocalizations.of(context)!.languageSettings,
                route: "",
              ),
              const SmallSpacer(),
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return SettingsToggle(
                    icon: Icon(Icons.color_lens),
                    title: "Dunkles Design",
                    initialValue: themeProvider.isDarkMode,
                    onToggle: (value) {
                      themeProvider.switchTheme();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
