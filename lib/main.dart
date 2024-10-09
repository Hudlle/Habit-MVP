import 'package:flutter/material.dart';

import 'objectbox.dart';

import 'app.dart';

late ObjectBox db;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  db = await ObjectBox.create();

  runApp(const HabitApp());
}