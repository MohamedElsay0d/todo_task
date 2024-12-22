import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'views/goal_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('goalsBox');
  runApp(const GoalMateApp());
}

class GoalMateApp extends StatelessWidget {
  const GoalMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoalMate',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: GoalListPage(),
    );
  }
}
