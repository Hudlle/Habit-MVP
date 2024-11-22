import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  static final firestore = FirebaseFirestore.instance;

  static final usersRef = firestore.collection("users");
  static final notificationsRef = firestore.collection("notifications");

  // User signup
  static Future saveUserEmailSignup (String username, String email) async {
    User? user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> data = {
      "username" : username,
      "email" : email,
      "flames" : 0,
    };
    try {
      await usersRef.doc(user!.uid).set(data);
      log("Username and email saved to uid: ${user.uid}");
    } catch (e) {
      log("E: Unable to save username and email. Error log: $e");
    }
  }
  
  // FCM token
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
      "checked" : false,
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

  static Future habitToggleCheck (String hid) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      DocumentReference habitRef =  usersRef.doc(user!.uid).collection("habits").doc(hid);
      Map<String, dynamic> habitData = await habitRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          return data;
        }
      );

      bool checkedStatus = habitData["checked"];
      int streakCount = habitData["streak"];

      if (!checkedStatus) {
        streakCount ++;
        await habitRef.update({"checked" : !checkedStatus, "streak" : streakCount});
        log("Updated ++");
      } else {
        streakCount --;
        await habitRef.update({"checked" : !checkedStatus, "streak" : streakCount});
        log("Updated --");
      }
      log("Habit hid: $hid checked status updated to ${!checkedStatus}");
    } catch (e) {
      log("E: Unable to update checked status of hid: $hid. Error log: $e");
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
  static Future saveNewNotification(String hid, habitData, String notificationTime) async {
    User? user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> data = {
      "uid" : user!.uid,
      "hid" : hid,
      "title" : habitData["name"],
      "body" : habitData["description"],
      "notification_time" : notificationTime,
      "timestamp" : FieldValue.serverTimestamp()
    };
    try {
      DocumentReference notificationRef = await notificationsRef.add(data);
      await usersRef.doc(user.uid).collection("habits").doc(hid).update({
        "notifications" : FieldValue.arrayUnion([notificationRef.id])
      });
      log("Notification saved to nid: ${notificationRef.id} and updated to hid: $hid");
      return notificationRef.id;
    } catch (e) {
      log("Unable to save notification. Error log: $e");
    }
  }

  static Future deleteNotification(String hid, String nid) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await usersRef.doc(user!.uid).collection("habits").doc(hid).update({
        "notifications" : FieldValue.arrayRemove([nid])
      });
      await notificationsRef.doc(nid).delete();
      log("Notification with nid: $nid deleted and hid: $hid updated");
    } catch (e) {
      log("Unable to delete notification with nid: $nid. Error log: $e");
    }
  }

  static Stream<int> getUserFlames() {
    User? user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .snapshots()
      .map((snapshot) {
        final data = snapshot.data();
        return data?['flames'] ?? 0; 
      });
  }
}
