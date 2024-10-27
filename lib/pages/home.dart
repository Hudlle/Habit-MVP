import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:habit_mvp/main.dart';
import 'package:habit_mvp/model.dart';
import 'package:habit_mvp/default_data.dart';
import 'package:habit_mvp/default_widgets.dart';
import 'package:habit_mvp/daystreak_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    db.updateHabitsStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String getHomeWelcome() {
      final hour = DateTime.now().hour;

      if (hour >= 5 && hour < 12) {
        return AppLocalizations.of(context)!.homeWelcomeMorning;
      } else if (hour >= 12 && hour < 18) {
        return AppLocalizations.of(context)!.homeWelcomeAfternoon;
      } else if (hour >= 18 && hour < 22) {
        return AppLocalizations.of(context)!.homeWelcomeEvening;
      } else {
        return AppLocalizations.of(context)!.homeWelcomeNight;
      }
    }

    return ChangeNotifierProvider(
      create: (context) => DayStreakProvider(),
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, settingsRoute);
              },
            )
          ],
        ),
        body: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: EdgeInsets.fromLTRB(defaultPagePadding[0], defaultPagePadding[1], defaultPagePadding[2], defaultPagePadding[3]),
            child: Center(
              child: Column(
                children: [
                  CustomText(
                    text: getHomeWelcome(),
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
                        //* DayStreakCounter Count
                        Consumer<DayStreakProvider>(
                          builder: (context, dayStreakProvider, child) {
                            return Text(
                              dayStreakProvider.dayStreakCount.toString(),
                              style: GoogleFonts.notoSerif(
                                textStyle: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: AppLocalizations.of(context)!.daystreak,
                          textType: TextType.title,
                        ),
                      ],
                    ),
                  ),
                  const LargeSpacer(),
                  Expanded(
                    child: StreamBuilder<List<Habit>>(
                      stream: db.getSortedHabits(),
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
                                  child: Consumer<DayStreakProvider>(
                                    builder: (context, dayStreakProvider, child) {
                                      return HabitCard(
                                        key: ValueKey(snapshot.data?[index].id),
                                        habit: snapshot.data![index],
                                        dayStreakProvider: dayStreakProvider,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          );
                        } else {
                          return const AddHabitIB();
                        }
                      },
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
    required this.dayStreakProvider
  });

  final Habit habit;
  final DayStreakProvider dayStreakProvider;

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

  void handleCheck() {
    bool newCheckedStatus = widget.habit.toggleCheck();
    db.habitBox.put(widget.habit);
    setState(() {
      checkedStatus = newCheckedStatus;
    });
    widget.dayStreakProvider.updateDayStreak();
  }

  @override
  Widget build(BuildContext context) {
    String getShortDescription(String habitDescription) {
      if (habitDescription.length > shortDescriptionLength) {
        String shortDescription = habitDescription.substring(0, shortDescriptionLength);
        return "$shortDescription...";
      }
      return habitDescription;
    }

    return Card(
      color: checkedStatus ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onPrimary,
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(15),
        constraints: BoxConstraints(
          minHeight: minHeightHabitCard,
        ),
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
                    specialColor: checkedStatus ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  CustomText(
                    text: getShortDescription(widget.habit.description),
                    textType: TextType.body,
                    softWrapToggle: true,
                    specialColor: checkedStatus ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSecondaryContainer,
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
                      color: checkedStatus ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Visibility(
                    visible: !checkedStatus,
                    child: FilledButton(
                      onPressed:() {
                        handleCheck();
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        iconColor: Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        fixedSize: const Size(checkButtonSize, checkButtonSize),
                      ),
                      child: Transform.scale(
                        scale: 1.3,
                        child: Icon(Icons.check,)
                      )
                    ),
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
            color: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onPrimary,
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
