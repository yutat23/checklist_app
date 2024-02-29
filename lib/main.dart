import 'package:flutter/material.dart';
import 'package:checklist_app/screens/checklist_screen.dart';
import 'package:checklist_app/screens/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checklist App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChecklistScreen(),
      routes: {
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
