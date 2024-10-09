import 'package:flutter/material.dart';

import '../default_data.dart';
import '../default_widgets.dart';

class HowToGoal extends StatelessWidget {
  const HowToGoal({super.key});

  @override
  Widget build(BuildContext context) {
    var howToGoalDisplay = Text(
      howToGoalDisplayT,
      semanticsLabel: howToGoalDisplayT,
      style: Theme.of(context).textTheme.displayMedium,
    );

    var howToGoalP = Text(
      howToGoalPT,
      style: Theme.of(context).textTheme.bodyMedium,
    );

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(defaultPagePadding[0], defaultPagePadding[1], defaultPagePadding[2], defaultPagePadding[3]),
          child: Column(
            children: [
              howToGoalDisplay,
              const LargeSpacer(),
              howToGoalP,
            ],
          )
        )
      )
    );
  }
}