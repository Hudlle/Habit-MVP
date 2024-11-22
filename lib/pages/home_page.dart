import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_mvp/api/authentication_service.dart';
import 'package:habit_mvp/api/firestore_service.dart';
import 'package:habit_mvp/default_data.dart';
import 'package:habit_mvp/default_widgets.dart';

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
    AuthService.handleFCMToken();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
    
  @override
  Widget build(BuildContext context) {

    String getHomeWelcome() {
      final hour = DateTime.now().hour;

      if (hour >= 5 && hour < 12) {
        return  "Hi ${AuthService.getUsername()}! ${AppLocalizations.of(context)!.homeWelcomeMorning}";
      } else if (hour >= 12 && hour < 18) {
        return "Hi ${AuthService.getUsername()}! ${AppLocalizations.of(context)!.homeWelcomeAfternoon}";
      } else if (hour >= 18 && hour < 22) {
        return "Hi ${AuthService.getUsername()}! ${AppLocalizations.of(context)!.homeWelcomeEvening}";
      } else {
        return  "Hi ${AuthService.getUsername()}! ${AppLocalizations.of(context)!.homeWelcomeNight}";
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
                  child: StreamBuilder<int>(
                    stream: FirestoreService.getUserFlames(),
                     builder:(context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Text('Fehler: ${snapshot.error}'); 
                        }

                        final flames = snapshot.data ?? 0; // Fallback auf 0
                        return Text(
                          "  $flames 🔥",
                          style: GoogleFonts.notoSerif(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                     },
                  ),
                ),
                const LargeSpacer(),
                HabitFirestoreStream(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class HabitFirestoreStream extends StatefulWidget {
  const HabitFirestoreStream({
    super.key
  });

  @override
  State<HabitFirestoreStream> createState() => _HabitFirestoreStreamState();
}

class _HabitFirestoreStreamState extends State<HabitFirestoreStream> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  late final Stream<QuerySnapshot> _habitsStream = FirebaseFirestore.instance.collection("users").doc(uid).collection("habits").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _habitsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          //TODO: feat: add user friendly error message to l10n
          return const Text("Something went wrong");
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.hasData ? snapshot.data!.size + 1 : 1,
          itemBuilder: (context, index) {
            List habits = snapshot.data!.docs;

            if (index == habits.length) {
              return Column(children: [LargeSpacer(), AddHabitIB()],);
            } else {
              LocalHabit habit = LocalHabit(
                hid: habits[index].id,
                name: habits[index]["name"],
                description: habits[index]["description"],
                streak: habits[index]["streak"],
                checked: habits[index]["checked"],
                notifications: habits[index]["notifications"],
              );
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, habitCloseLookRoute, arguments: habit.hid);
                },
                child: HabitCard(habit: habit)
              );
            }
          }
        );
      }
    );
  }
}

class HabitCard extends StatefulWidget {
  const HabitCard({
    super.key,
    required this.habit,
  });

  final LocalHabit habit;

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {

  @override
  void initState() {
    super.initState();
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
                        FirestoreService.habitToggleCheck(widget.habit.hid);
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
