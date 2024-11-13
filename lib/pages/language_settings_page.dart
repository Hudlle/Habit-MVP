import 'package:flutter/material.dart';
import 'package:habit_mvp/default_data.dart';
import 'package:habit_mvp/default_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:habit_mvp/ui_util/theme_locale_provider.dart';

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {

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
                    shrinkWrap: true,
                    itemCount: AppLocalizations.supportedLocales.length,
                    itemBuilder:(context, index) {
                      Locale indexLocale = AppLocalizations.supportedLocales[index];
                      bool isActive;
                      if (localeProvider.locale == indexLocale) {
                        isActive = true;
                      } else {
                        isActive = false;
                      }
              
                      String language = localeProvider.getLocaleFullName(indexLocale);
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