import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = 
    FlutterLocalNotificationsPlugin();

  // request notification permission
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

    // get device fcm token
    final token = await _firebaseMessaging.getToken();
    log("fcm token: $token");
  }

  // init local notifications
  static Future localNotificationsInit() async {
    try {
      // android init settings; icon = notification icon
      const AndroidInitializationSettings initializationSettingsAndroid = 
        AndroidInitializationSettings("@mipmap/notification_icon");

      // ios init settings
      const DarwinInitializationSettings initializationSettingsDarwin = 
        DarwinInitializationSettings();

      // all init settings
      const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );

      // request notification permissions for android 13 or above
      final androidPlugin = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      if (androidPlugin != null) {
        await androidPlugin.requestNotificationsPermission();
      }

      // Initialize with notification settings and handle potential tap actions
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

  // on tap local notification in foreground
  static void onNotificationTap(NotificationResponse notificationResponse) {
    log("Notification tapped: ${notificationResponse.payload}");
  }
}
