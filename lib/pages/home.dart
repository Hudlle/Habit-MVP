import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';

import 'package:habit_mvp/main.dart';
import 'package:habit_mvp/model.dart';
import 'package:habit_mvp/default_data.dart';
import 'package:habit_mvp/default_widgets.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int dayStreakCount;

  @override
  void initState() {
    db.updateHabitsStatus();
    DayStreakCounter dayStreakCounter = db.getDayStreakCounter();
    dayStreakCounter.update();
    dayStreakCount = dayStreakCounter.count;
    super.initState();
  }

  void updateDayStreakCount() {
    DayStreakCounter dayStreakCounter = db.getDayStreakCounter();
    setState(() {
      dayStreakCount = dayStreakCounter.count;
    });
  }

  Future<void> _handleRefresh() async {
    db.updateHabitsStatus();
    DayStreakCounter dayStreakCounter = db.getDayStreakCounter();
    dayStreakCounter.update();
    setState(() {
      dayStreakCount = dayStreakCounter.count;
    });
  }
  
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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: EdgeInsets.fromLTRB(defaultPagePadding[0], defaultPagePadding[1], defaultPagePadding[2], defaultPagePadding[3]),
            child: Center(
              child: Column(
                children: [
                  CustomText(
                    text: welcomHeadlineT,
                    textType: TextType.headline,
                    centerAlignToggle: true,
                  ),
                  LargeSpacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          dayStreakCount.toString(),
                          style: GoogleFonts.notoSerif(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          daystreakT,
                          semanticsLabel: daystreakT,
                          style: Theme.of(context).textTheme.titleMedium
                        )
                      ],
                    ),
                  ),
                  const LargeSpacer(),
                  Expanded(
                    child: StreamBuilder<List<Habit>>(
                      stream: db.getHabits(),
                      builder: (context, snapshot) {
                        if (snapshot.data?.isNotEmpty ?? false) {
                          return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
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
                                    onHabitUpdate: updateDayStreakCount,
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
      ),
    );
  }
}

class HabitCard extends StatefulWidget {
  const HabitCard({
    super.key,
    required this.habit,
    required this.onHabitUpdate,
  });

  final Habit habit;
  final VoidCallback onHabitUpdate;

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
    DayStreakCounter dayStreakCounter = db.getDayStreakCounter();
    dayStreakCounter.update();
    db.dayStreakCounterBox.put(dayStreakCounter);

    setState(() {
      checkedStatus = newCheckedStatus;
    });
    widget.onHabitUpdate();
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
            SizedBox(
              width: 175,
              child: Column( 
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: widget.habit.name,
                    textType: TextType.title,
                    softWrapToggle: true,
                    specialColor: checkedStatus ? onPrimary : Colors.black,
                  ),
                  CustomText(
                    text: widget.habit.description,
                    textType: TextType.body,
                    softWrapToggle: true,
                    specialColor: checkedStatus ? onPrimary : Colors.black,
                  ),
                ],
              ),
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
