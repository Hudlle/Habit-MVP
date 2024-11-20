import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_mvp/model.dart';

class FirestoreService {

  static final firestore = FirebaseFirestore.instance;

  static final usersRef = firestore.collection("users");
  static final notificationsRef = firestore.collection("notifications");

  // user signup
  static Future saveUserEmailSignup (String username, String email) async {
    User? user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> data = {
      "username" : username,
      "email" : email,
    };
    try {
      await usersRef.doc(user!.uid).set(data);
      log("Username and email saved to uid: ${user.uid}");
    } catch (e) {
      log("E: Unable to save username and email. Error log: $e");
    }
  }
  
  // fcm token
  static Future saveFCMToken (String fcmToken) async {
    User? user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> data = {
      "token" : fcmToken,
    };
    try {
      await usersRef.doc(user!.uid).update(data);
      log("FCM Token saved to uid: ${user.uid}");
    } catch (e) {
      log("E: Unable to save fcm token. Error log: $e");
    }
  }

  // Habits
  static Future saveNewHabit (String habitName, String habitDescription) async {
    User? user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> data = {
      "name" : habitName,
      "description" : habitDescription,
      "streak" : 0,
      "notifications" : [],
      "timestamp" : FieldValue.serverTimestamp()
    };
    try {
      DocumentReference habitRef = await usersRef.doc(user!.uid).collection("habits").add(data);
      log("Habit saved to hid: ${habitRef.id}");
      return habitRef.id;
    } catch (e) {
      log("E: Unable to save habit. Error log: $e");
    }
  }

  static Future deleteHabit (String hid) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await usersRef.doc(user!.uid).collection("habits").doc(hid).delete();
      log("Habit with hid: $hid deleted");
    } catch (e) {
      log("E: Unable to delete habit with hid: $hid. Error log: $e");
    }
  }

  // Notifications
  static Future saveNewNotification(Habit habit, String notificationTime) async {
    User? user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> data = {
      "uid" : user!.uid,
      "hid" : habit.hid,
      "title" : habit.name,
      "body" : habit.description,
      "notification_time" : notificationTime,
      "timestamp" : FieldValue.serverTimestamp()
    };
    try {
      DocumentReference notificationRef = await notificationsRef.add(data);
      await usersRef.doc(user.uid).collection("habits").doc(habit.hid).update({
        "notifications" : FieldValue.arrayUnion([notificationRef.id])
      });
      log("Notification saved to nid: ${notificationRef.id} and updated to hid: ${habit.hid}");
      return notificationRef.id;
    } catch (e) {
      log("Unable to save notification. Error log: $e");
    }
  }

  static Future deleteNotification(Noti notification) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      String hid = notification.habit.target!.hid;
      await usersRef.doc(user!.uid).collection("habits").doc(hid).update({
        "notifications" : FieldValue.arrayRemove([notification.nid])
      });
      await notificationsRef.doc(notification.nid).delete();
      log("Notification with nid: ${notification.nid} deleted and hid: $hid updated");
    } catch (e) {
      log("Unable to delete notification with nid: ${notification.nid}. Error log: $e");
    }
  }
}