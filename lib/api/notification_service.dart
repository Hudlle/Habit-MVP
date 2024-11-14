import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_mvp/app.dart';
import 'package:habit_mvp/default_data.dart';

class NotificationService {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = 
    FlutterLocalNotificationsPlugin();

  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      criticalAlert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      provisional: false,
      sound: true,
    );

    final token = await _firebaseMessaging.getToken();
    log("fcm token: $token");
  }

  static Future localNotificationsInit() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid = 
        AndroidInitializationSettings("@mipmap/notification_icon");

      const DarwinInitializationSettings initializationSettingsDarwin = 
        DarwinInitializationSettings();

      const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );

      final androidPlugin = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      if (androidPlugin != null) {
        await androidPlugin.requestNotificationsPermission();
      }

      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap,
      );
    } catch (e, stackTrace) {
      log("Error initializing local notifications: $e");
      log(stackTrace.toString());
    }
  }

  // Foreground state
  static void onNotificationTap(NotificationResponse response) {
    //TODO: need to implement habit routing with notification data payload after implementation of firestore user documents and notification entity
    navigatorKey.currentState!.pushNamed(settingsRoute);
  }

  static void receiveForegroundNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      String payloadData = jsonEncode(message.data);
      log("Foreground notification received");

      if (message.notification != null) {
        showNotification(
          title: notification.title!,
          body: notification.body!,
          payload: payloadData
        );
      }
    });
  }

  static Future showNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        "your channel id", 
        "your channel name",
        channelDescription: "your channel description",
        importance: Importance.max,
        priority: Priority.high,
        ticker: "ticker",
      );
    const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
    
    await _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails, payload: payload);
  }

  // Background state
  static void onBackgroundNotificationTap() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        log("Tapped background notification");
        //TODO: need to implement habit routing with notification data payload after implementation of firestore user documents and notification entity
        navigatorKey.currentState!.pushNamed(settingsRoute);
      }
    });
  }

  // Terminated state
  static Future receiveTerminatedNotification() async {
    final RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      log("Terminated notification received");
      Future.delayed(Duration(seconds: 1), () {
        //TODO: need to implement habit routing with notification data payload after implementation of firestore user documents and notification entity
        navigatorKey.currentState!.pushNamed(settingsRoute);
      });
    }
  }
}
