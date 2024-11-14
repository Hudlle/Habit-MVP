import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_mvp/api/authentication_service.dart';
import 'package:habit_mvp/app.dart';
import 'package:habit_mvp/flames_provider.dart';

import 'package:habit_mvp/main.dart';
import 'package:habit_mvp/model.dart';
import 'package:habit_mvp/default_data.dart';
import 'package:habit_mvp/default_widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    ob.refreshHabitsStatus();
    log("INITIATED HOME");
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     Navigator.pushNamedAndRemoveUntil(
  //       context, 
  //       homeRoute,
  //       (Route<dynamic> route) => false,
  //     );
  //     log("REFRESHING");
  //   }
  // }
    
  @override
  Widget build(BuildContext context) {

    String getHomeWelcome() {
      final hour = DateTime.now().hour;

      if (hour >= 5 && hour < 12) {
        return  "${AuthService.getUsername()}, ${AppLocalizations.of(context)!.homeWelcomeMorning}";
      } else if (hour >= 12 && hour < 18) {
        return "${AuthService.getUsername()}, ${AppLocalizations.of(context)!.homeWelcomeAfternoon}";
      } else if (hour >= 18 && hour < 22) {
        return "${AuthService.getUsername()}, ${AppLocalizations.of(context)!.homeWelcomeEvening}";
      } else {
        return  "${AuthService.getUsername()}, ${AppLocalizations.of(context)!.homeWelcomeNight}";
      }
    }

    return Scaffold(
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
                      Consumer<FlamesProvider>(
                        builder: (context, flamesProvider, child) {
                          return Text(
                            "   ${flamesProvider.flames} 🔥", 
                            style: GoogleFonts.notoSerif(
                              textStyle: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: "",
                        textType: TextType.title,
                      ),
                    ],
                  ),
                ),
                const LargeSpacer(),
                Expanded(
                  child: StreamBuilder<List<Habit>>(
                    stream: ob.getSortedHabits(),
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
                                  navigatorKey.currentState!.pushNamed(
                                    habitCloseLookRoute,
                                    arguments: snapshot.data![index]
                                  );
                                },
                                child: HabitCard(
                                  key: ValueKey(snapshot.data?[index].id),
                                  habit: snapshot.data![index],
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

  @override
  void initState() {
    super.initState();
  }

  void handleCheck(BuildContext context) {
    Provider.of<FlamesProvider>(context, listen: false).updateHabitAndFlames(widget.habit);
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
      color: widget.habit.checked ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onPrimary,
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
                    specialColor: widget.habit.checked ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  CustomText(
                    text: getShortDescription(widget.habit.description),
                    textType: TextType.body,
                    softWrapToggle: true,
                    specialColor: widget.habit.checked ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${widget.habit.streak} 🔥",
                    style: TextStyle(
                      fontSize: 20,
                      color: widget.habit.checked ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Visibility(
                    visible: !widget.habit.checked,
                    child: FilledButton(
                      onPressed:() {
                        handleCheck(context);
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
