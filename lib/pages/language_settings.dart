import 'package:flutter/material.dart';
import 'package:habit_mvp/default_data.dart';
import 'package:habit_mvp/default_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:habit_mvp/ui_util/theme_locale_provider.dart';
import 'package:habit_mvp/main.dart';
import 'package:habit_mvp/model.dart';

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({super.key});

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  String getLocaleFullName(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return 'English';
    case 'de':
      return 'Deutsch';
    default:
      return locale.languageCode;
    }
  }

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
                text: AppLocalizations.of(context)!.languageSettingsWelcome,
                textType: TextType.headline,
              ),
              const SmallSpacer(),
              CustomText(
                text: AppLocalizations.of(context)!.chooseLanguage,
                textType: TextType.title,
              ),
              const LargeSpacer(),
              Consumer<LocaleProvider>(
                builder: (context, localeProvider, child) {
                  return ListView.builder(
                    itemCount: AppLocalizations.supportedLocales.length,
                    shrinkWrap: true,
                    itemBuilder:(context, index) {
                      Locale indexLocale = AppLocalizations.supportedLocales[index];
                      String language = getLocaleFullName(indexLocale);
                      UserSettings userSettings = db.getUserSettings();
                      bool isActive;
                      if (userSettings.locale == indexLocale) {
                        isActive = true;
                      } else {
                        isActive = false;
                      }
                      return GestureDetector(
                        onTap: () {
                          localeProvider.changeLocale(indexLocale);
                        },
                        child: LanguageCard(
                          language: language,
                          isActive: isActive,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          )
        )
      )
    );
  }
}

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    super.key,
    required this.language,
    required this.isActive,
  });

  final String language;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      color: isActive ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: CustomText(
          text: language,
          textType: TextType.body,
          specialColor: isActive ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary,
        ),
      )
    );
  }
}