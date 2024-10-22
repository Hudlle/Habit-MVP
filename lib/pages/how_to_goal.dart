import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../default_data.dart';
import '../default_widgets.dart';

class HowToGoal extends StatelessWidget {
  const HowToGoal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(defaultPagePadding[0], defaultPagePadding[1], defaultPagePadding[2], defaultPagePadding[3]),
          child: Column(
            children: [
              CustomText(
                text: AppLocalizations.of(context)!.howToGoal,
                textType: TextType.headline,
              ),
              const LargeSpacer(),
              CustomText(
                text: AppLocalizations.of(context)!.howToGoalP,
                textType: TextType.body,
              ),
            ],
          )
        )
      )
    );
  }
}