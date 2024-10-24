import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui_util/theme_locale_provider.dart';

import 'objectbox.dart';
import 'app.dart';

late ObjectBox db;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  db = await ObjectBox.create();
  db.updateHabitsStatus();

  runApp(
    ChangeNotifierProvider(
      create: ((context) => LocaleProvider()),
      child: const HabitApp()
    )
  );
}