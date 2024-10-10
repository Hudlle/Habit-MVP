import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_mvp/default_widgets.dart';

import '../main.dart';
import '../model.dart';
import '../default_data.dart';
import '../user_data.dart';

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
                const LargeSpacer(),
                Expanded(
                  child: StreamBuilder<List<Habit>>(
                    stream: db.getHabits(),
                    builder: (context, snapshot) {
                      if (snapshot.data?.isNotEmpty ?? false) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.hasData ? snapshot.data!.length + 1 : 1,
                          itemBuilder: (context, index) {
                            if (index == snapshot.data?.length) {
                              return Column(
                                children: [
                                  LargeSpacer(),
                                  AddHabitIB()
                                ],
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    arguments: snapshot.data![index],
                                    habitCloseLookRoute,
                                  );
                                },
                                child: HabitCard(
                                  key: ValueKey(snapshot.data?[index].id),
                                  habit: snapshot.data![index],
                                )
                              );
                            }
                          }
                        );
                      } else {
                        return const AddHabitIB();
                      }
                    }
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
  });

  final Habit habit;

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  late bool checkedStatus;

  @override
  void initState() {
    checkedStatus = widget.habit.checked;
    super.initState();
  }

  void toggleCheckButton() {
    bool newCheckedStatus = widget.habit.toggleCheck();
    db.habitBox.put(widget.habit);

    setState(() {
      checkedStatus = newCheckedStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: checkedStatus ? primary : onPrimary,
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
                    color: checkedStatus ? onPrimary : Colors.black,
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    widget.habit.description,
                    semanticsLabel: widget.habit.description,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: checkedStatus ? onPrimary : Colors.black,
                    ),
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
                      color: checkedStatus ? onPrimary : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                    onPressed:() {
                      toggleCheckButton();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: checkedStatus ? onPrimary : primary,
                      iconColor: checkedStatus ? primary : onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fixedSize: const Size(checkButtonSize, checkButtonSize),
                    ),
                    child: Transform.scale(
                      scale: 1.3,
                      child: Icon(
                        checkedStatus ? Icons.undo : Icons.check,
                      )
                    )
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
              Navigator.pushNamed(context, newHabitNameRoute);
            },
          ),
        ),
      ),
    );
  }
}
