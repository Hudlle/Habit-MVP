import 'package:flutter/material.dart';

import 'default_data.dart';

class HabitDetails extends StatelessWidget {
  const HabitDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(defaultPagePadding[0], defaultPagePadding[1], defaultPagePadding[2], defaultPagePadding[3]),
          child: const Placeholder(),
        )
      )
    );
  }
}