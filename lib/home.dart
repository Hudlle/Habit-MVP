import 'package:flutter/material.dart';
import 'dart:developer';

import 'default_data.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              log("Settings");
            },
          )
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(pagePadding[0], pagePadding[1], pagePadding[2], pagePadding[3]),
          child: Center(
            child: Column(
              children: [
                FittedBox(
                  child: Text(
                    daystreak.toString(),
                    semanticsLabel: daystreak.toString(),
                    style: const TextStyle(
                      fontSize: 200, //TODO Change to different font family
                    ),
                  ),
                ),
                Text(
                  daystreakT,
                  semanticsLabel: daystreakT,
                  style: Theme.of(context).textTheme.headlineSmall
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: habitCount + 1,
                    itemBuilder: (context, index) {
                      if(index == habitCount) {
                        return Material(
                          child: Center(
                            child: Ink(
                              decoration: ShapeDecoration(
                                color: primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: onPrimary,
                                ),
                                onPressed:() {
                                  log("Neues Habit du Schwein!");
                                },
                              ),
                            ),
                          ),
                        );
                      } else {
                        return HabitCard(index: index);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HabitCard extends StatefulWidget {
  const HabitCard({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habitNames[widget.index],
                  semanticsLabel: habitNames[widget.index],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  habitDescriptions[widget.index],
                  semanticsLabel: habitDescriptions[widget.index],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "🔥${habitStreaks[widget.index]}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                    onPressed:() {
                      log("Habit done");
                    },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fixedSize: const Size(checkButtonSize, checkButtonSize),
                    ),
                    child: const Icon(Icons.check)
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
