import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_mvp/api/firestore_service.dart';
import 'package:habit_mvp/api/notification_service.dart';

enum AuthFeedback {
  signupSuccessful, 
  signupFailed,
  loginSuccessful,
  loginFailed,
}

class AuthService {

  // create a new account
  static Future<AuthFeedback> createAccountWithEmail(String username, String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      editUsername(username);
      FirestoreService.saveUserEmailSignup(username, email);
      log("Signup successful with new uid: ${FirebaseAuth.instance.currentUser!.uid}");
      return AuthFeedback.signupSuccessful;
    } catch (e) {
      log("E: Signup failed. Error log: $e");
      return AuthFeedback.signupFailed;
    }
  }

  // handle fcm token
  static Future handleFCMToken() async {
    final fcmToken = await NotificationService.fcmToken;

    if (! await isLoggedIn()) {
      log("E: Unable to handle fcm token. User not authenticated.");
      return;
    }

    FirestoreService.saveFCMToken(fcmToken!);

    NotificationService.firebaseMessaging.onTokenRefresh.listen((event) async {
      await FirestoreService.saveFCMToken(fcmToken);
    });
  }

  // get display name
  static String getUsername() {
    return FirebaseAuth.instance.currentUser?.displayName ?? "username";
  }

  // edit display name
  static Future<String> editUsername(String username) async {
    //TODO: Add udpate to firestore
    await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
    return "username edit successful";
  }

  // login
  static Future<AuthFeedback> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return AuthFeedback.loginSuccessful;
    } catch (e) {
      log("E: Login failed. Error log: $e");
      return AuthFeedback.loginFailed;
    }
  }

  // logout 
  static Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // check whether the user is sign in or not
  static Future<bool> isLoggedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }
}