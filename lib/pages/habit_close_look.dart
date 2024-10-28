import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_mvp/daystreak_provider.dart';

import 'package:habit_mvp/default_data.dart';
import 'package:habit_mvp/default_widgets.dart';
import 'package:habit_mvp/model.dart';
import 'package:habit_mvp/main.dart';

class HabitCloseLook extends StatefulWidget {
  HabitCloseLook({
    super.key,
    required this.habit,
  });

  Habit habit;

  @override
  State<HabitCloseLook> createState() => _HabitCloseLookState();
}

class _HabitCloseLookState extends State<HabitCloseLook> {
    
  @override
  void initState() {
    db.updateHabitsStatus();
    db.updateDayStreakCounter();
    log("INITIATED CLOSE LOOK");
    super.initState();
  }

  void toggleCheckButton() {
    Habit newHabit = db.updateHabit(widget.habit);
    setState(() {
      widget.habit = newHabit;
    });
  }

  void onEdit() {
    Navigator.pushNamed(
      context,
      arguments: widget.habit,
      habitEditRoute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.fromLTRB(defaultPagePadding[0], defaultPagePadding[1], defaultPagePadding[2], defaultPagePadding[3]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: widget.habit.name,
                textType: TextType.headline,
                specialColor: widget.habit.checked ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "${widget.habit.streak.toString()} 🔥",
                  style: GoogleFonts.notoSerif(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              LargeSpacer(),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: AppLocalizations.of(context)!.yourGoal,
                        textType: TextType.title,
                      ),
                      SmallSpacer(),
                      SizedBox( 
                        width: 225,
                        child: CustomText(
                          text: widget.habit.description,
                          textType: TextType.body,
                          softWrapToggle: true,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        child: Center(
                          child: Transform.scale(
                            scale: 0.925,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => onEdit(),
                              )
                            ),
                          )
                        ),
                      ),
                      SizedBox(width: 15,),
                      Material(
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
                                widget.habit.checked ? Icons.undo : Icons.check,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              onPressed:() {
                                toggleCheckButton();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(child: Container()),
              CustomText(
                text: AppLocalizations.of(context)!.dangerZone,
                textType: TextType.title,
              ),
              SmallSpacer(),
              GestureDetector(
                onTap: () {
                  db.removeHabit(widget.habit);
                  Navigator.pop(context);
                },
                child: Card.outlined(
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface),
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.delete),
                        title: Text(AppLocalizations.of(context)!.deleteHabit),
                      )
                    ],
                  )
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}