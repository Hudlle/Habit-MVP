import 'package:flutter/material.dart';

import 'default_data.dart';
import 'default_widgets.dart';

class NewHabitName extends StatelessWidget {
  const NewHabitName({super.key});

  @override
  Widget build(BuildContext context) {
    var newHabitNameDisplay = Text(
      newHabitNameDisplayT,
      semanticsLabel: newHabitNameDisplayT,
      style: Theme.of(context).textTheme.displayMedium
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
              newHabitNameDisplay,
              const LargeSpacer(),
              const BigTextField(
                emptyErrorT: newHabitNameEmptyErrorT,
                hintT: newHabitNameHintT,
                route: newHabitDetailRoute,
              ),
            ],
          )
        )
      )
    );
  }
}

