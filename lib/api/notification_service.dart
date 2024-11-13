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

  static void onNotificationTap(NotificationResponse notificationResponse) {
    log("Notification tapped: ${notificationResponse.payload}");
  }

  // Background state
  static Future firebaseBackgroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      log("Some notification received in background ...");
    }
  }

  static void onOpenedBackgroundMessage() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        log("Tapped background notification");
        //TODO: need to implement habit routing with notification data payload after implementation of firestore user documents and notification entity
        navigatorKey.currentState!.pushNamed(settingsRoute);
      }
    });
  }
}
