import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/models/Task.dart';
import 'package:note_application/screens/add_task_screen.dart';
// import 'package:note_application/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('Task');
  runApp(NoteApplication());
}

class NoteApplication extends StatelessWidget {
  const NoteApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Shabnam'),
      home: AddTaskScreen(),
    );
  }
}
