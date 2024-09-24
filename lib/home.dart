import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';

import 'default_data.dart';
import 'user_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, settingsRoute);
              log("Settings");
            },
          )
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(homePagePadding[0], homePagePadding[1], homePagePadding[2], homePagePadding[3]),
          child: Center(
            child: Column(
              children: [
                FittedBox(
                  child: Text(
                    daystreak.toString(),
                    semanticsLabel: daystreak.toString(),
                    style: GoogleFonts.notoSerif(
                      textStyle: const TextStyle(
                        fontSize: 200,
                      ),
                    ),
                  ),
                ),
                Text(
                  daystreakT,
                  semanticsLabel: daystreakT,
                  style: GoogleFonts.notoSerif(
                    textStyle: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: userHabits.length + 1,
                    itemBuilder: (context, index) {
                      if(index == userHabits.length) {
                        return const AddHabitIB();
                      } else {
                        final sortedHabits = userHabits.where((habit) => !habit.checked).toList() +
                          userHabits.where((habit) => habit.checked).toList();
                        return HabitCard(
                          habit: sortedHabits[index],
                          handleCheck: (habit) {
                            setState(() {
                              habit.checked = !habit.checked;
                            });
                          },
                        );
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
    required this.habit,
    required this.handleCheck,
  });

  final Habit habit;
  final Function(Habit) handleCheck;

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {

  @override
  Widget build(BuildContext context) {

    return Card(
      color: widget.habit.checked ? primary : onPrimary,
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.habit.name,
                  semanticsLabel: widget.habit.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: widget.habit.checked ? onPrimary : Colors.black,
                  ),
                ),
                Text(
                  widget.habit.description,
                  semanticsLabel: widget.habit.description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: widget.habit.checked ? onPrimary : Colors.black,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "🔥${widget.habit.streak}",
                    style: TextStyle(
                      fontSize: 20,
                      color: widget.habit.checked ? onPrimary : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                    onPressed:() {
                      widget.handleCheck(widget.habit);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: widget.habit.checked ? onPrimary : primary,
                      iconColor: widget.habit.checked ? primary : onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fixedSize: const Size(checkButtonSize, checkButtonSize),
                    ),
                    child: const Icon(Icons.check)
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

class AddHabitIB extends StatelessWidget {
  const AddHabitIB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
  }
}
