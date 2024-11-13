import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habit_mvp/api/notification_service.dart';
import 'package:habit_mvp/firebase_options.dart';
import 'package:provider/provider.dart';
import 'ui_util/theme_locale_provider.dart';
import 'objectbox.dart';
import 'app.dart';

late ObjectBox ob;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ob = await ObjectBox.create();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService.init();
  await NotificationService.localNotificationsInit();
  NotificationService.receiveForegroundNotification();
  NotificationService.onBackgroundNotificationTap();
  NotificationService.receiveTerminatedNotification();

  runApp(
    ChangeNotifierProvider(
      create: ((context) => LocaleProvider()),
      child: const HabitApp()
    )
  );
}