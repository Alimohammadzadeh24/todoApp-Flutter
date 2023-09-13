import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/Theme/Color.dart';
import 'package:note_application/models/Task.dart';
import 'package:note_application/screens/home_screen.dart';
import 'package:note_application/widgets/Task/task_type.dart';
import 'package:note_application/widgets/Task/task_type_enum.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  await Hive.openBox<Task>('taskBox');
  runApp(NoteApplication());
}

class NoteApplication extends StatelessWidget {
  const NoteApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: greenColor,
        fontFamily: 'Shabnam',
      ),
      home: HomeScreen(),
    );
  }
}
