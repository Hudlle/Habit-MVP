import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:habit_mvp/default_data.dart';
import 'package:habit_mvp/default_widgets.dart';
import 'package:habit_mvp/flames_provider.dart';
import 'package:habit_mvp/model.dart';
import 'package:habit_mvp/main.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HabitCloseLookPage extends StatefulWidget {
  HabitCloseLookPage({
    super.key,
    required this.habit,
  });

  Habit habit;

  @override
  State<HabitCloseLookPage> createState() => _HabitCloseLookPageState();
}

class _HabitCloseLookPageState extends State<HabitCloseLookPage> {
    
  @override
  void initState() {
    ob.refreshHabitsStatus();
    log("INITIATED CLOSE LOOK");
    super.initState();
  }

  void toggleCheckButton(context) {
    Habit newHabit = Provider.of<FlamesProvider>(context, listen: false).updateHabitAndFlames(widget.habit);
    setState(() {
      widget.habit = newHabit;
    });
  }

  void createNotification(context) async{
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (timeOfDay != null) {
      ob.addNotification(widget.habit, timeOfDay);
    }
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
                                toggleCheckButton(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const LargeSpacer(),
              CustomText(
                text: AppLocalizations.of(context)!.notifications,
                textType: TextType.title,
              ),
              const SmallSpacer(),
              StreamBuilder<List<Noti>>(
                stream: ob.getHabitNotifications(widget.habit),
                builder: (context, snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                    itemBuilder: (context, index) {
                      return NotificationCard(notification: snapshot.data![index]);
                    },
                  );
                }
              ),
              TextButton(
                onPressed: () => createNotification(context),
                child: Row(
                  children: [
                    Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
                    SizedBox(width: smallSpacing),
                    CustomText(
                      text: AppLocalizations.of(context)!.add, 
                      textType: TextType.body,
                      specialColor: Theme.of(context).colorScheme.primary,
                    )
                  ],
                )
              ),
              Expanded(child: Container()),
              CustomText(
                text: AppLocalizations.of(context)!.dangerZone,
                textType: TextType.title,
              ),
              SmallSpacer(),
              GestureDetector(
                onTap: () {
                  ob.removeHabit(widget.habit);
                  Navigator.pop(context);
                },
                child: Card.outlined(
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface),
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text(AppLocalizations.of(context)!.deleteHabit),
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

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
  });

  final Noti notification;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(notification.notificationTime),
        trailing: IconButton(
          onPressed: () {
            ob.removeNotification(notification);
          },
          icon: Icon(Icons.close),
        ),
      ),
    );
  }
}