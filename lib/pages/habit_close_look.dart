import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';

import 'package:habit_mvp/default_data.dart';
import 'package:habit_mvp/default_widgets.dart';
import 'package:habit_mvp/model.dart';
import 'package:habit_mvp/main.dart';

class HabitCloseLook extends StatefulWidget {
  const HabitCloseLook({
    super.key,
    required this.habit
  });

  final Habit habit;

  @override
  State<HabitCloseLook> createState() => _HabitCloseLookState();
}

class _HabitCloseLookState extends State<HabitCloseLook> {
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
  void deleteHabit(BuildContext context, Habit habit) {
    db.habitBox.remove(habit.id);
    log("${habit.name} löschen, aber sofort!");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var habitDisplay = Text(
      widget.habit.name,
      semanticsLabel: widget.habit.name,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
        color: checkedStatus ? primary : Colors.black,
      ),
    );

    var yourGoalTitle = Text(
      yourGoalTitleT,
      semanticsLabel: yourGoalTitleT,
      style: Theme.of(context).textTheme.titleMedium,
    );

    var dangerZoneTitle = Text(
      dangerZoneTitleT,
      semanticsLabel: dangerZoneTitleT,
      style: Theme.of(context).textTheme.titleMedium
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
              FittedBox(
                child: Text(
                  widget.habit.streak.toString(),
                  semanticsLabel: widget.habit.streak.toString(),
                  style: GoogleFonts.notoSerif(
                    textStyle: TextStyle(
                      fontSize: 200,
                      color: checkedStatus ? primary : Colors.black,
                    ),
                  ),
                ),
              ),
              habitDisplay,
              LargeSpacer(),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      yourGoalTitle,
                      SizedBox( 
                        width: 225,
                        child: Text(
                          widget.habit.description,
                          semanticsLabel: widget.habit.description,
                          softWrap: true,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Material(
                    child: Center(
                      child: Ink(
                        decoration: ShapeDecoration(
                          color: primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            checkedStatus ? Icons.undo : Icons.check,
                            color: onPrimary,
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
              Expanded(child: Container()),
              dangerZoneTitle,
              SmallSpacer(),
              GestureDetector(
                onTap: () {
                  deleteHabit(context, widget.habit);
                },
                child: Card.outlined(
                  shape: OutlineInputBorder(
                    borderSide: const BorderSide(color: borderOutline),
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                  ),
                  child: const Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.delete),
                        title: Text(deleteHabitT),
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