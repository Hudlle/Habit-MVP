import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_mvp/api/firestore_service.dart';
import 'package:habit_mvp/default_data.dart';
import 'package:habit_mvp/default_widgets.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HabitCloseLookPage extends StatefulWidget {
  HabitCloseLookPage({
    super.key,
    required this.hid,
  });

  String hid;

  @override
  State<HabitCloseLookPage> createState() => _HabitCloseLookPageState();
}

class _HabitCloseLookPageState extends State<HabitCloseLookPage> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  late final Stream _habitStream = FirebaseFirestore.instance
    .collection("users")
    .doc(uid)
    .collection("habits")
    .doc(widget.hid)
    .snapshots();
  late final Stream _notificationsStream = FirebaseFirestore.instance
    .collection("notifications")
    .where("hid", isEqualTo: widget.hid)
    .snapshots();
    
  void createNewNotification(habitData) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial
    );

    if (timeOfDay == null) {
      return;
    }
    String notificationTime = _formatTimeOfDayToString(timeOfDay);
    
    FirestoreService.saveNewNotification(widget.hid, habitData, notificationTime);               
  }

  String _formatTimeOfDayToString(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    String formatted = DateFormat("HH:mm").format(dateTime);
    return formatted;
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _habitStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final habitData = snapshot.data;

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
                    text: habitData["name"],
                    textType: TextType.headline,
                    specialColor: habitData["checked"] ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
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
                      "${habitData["streak"]} 🔥",
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
                              text: habitData["description"],
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
                                    onPressed: () {

                                    },
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
                                    habitData["checked"] ? Icons.undo : Icons.check,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  onPressed:() {
                                    FirestoreService.habitToggleCheck(widget.hid);
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
                  StreamBuilder(
                    stream: _notificationsStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Something went wrong");
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.size,
                        itemBuilder:(context, index) {
                          List notifications = snapshot.data!.docs;

                          return NotificationCard(
                            hid: widget.hid, 
                            nid: notifications[index].id, 
                            notificationTime: notifications[index]["notification_time"],
                          );
                        },
                      );
                    }
                  ),
                  TextButton(
                    onPressed: () => createNewNotification(habitData),
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
                      Navigator.pop(context);
                      FirestoreService.deleteHabit(widget.hid);
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
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.hid,
    required this.nid,
    required this.notificationTime,
    super.key,
  });

  final String hid;
  final String nid;
  final String notificationTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(notificationTime),
        trailing: IconButton(
          onPressed: () {
            FirestoreService.deleteNotification(hid, nid);
          },
          icon: Icon(Icons.close),
        ),
      ),
    );
  }
}