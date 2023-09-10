import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/Theme/Color.dart';
import 'package:note_application/models/Task.dart';
import 'package:note_application/screens/add_task_screen.dart';
import 'package:note_application/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var taskBox = Hive.box<Task>('taskBox');
  bool isFabVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: ValueListenableBuilder(
            valueListenable: taskBox.listenable(),
            builder: (context, value, child) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  var task = taskBox.values.toList()[index];
                  return getTaskWidget(task: task);
                },
                itemCount: taskBox.values.length,
              );
            },
          )),
      floatingActionButton: NotificationListener<UserScrollNotification>(
        onNotification: (notif) {
          setState(() {
            if (notif.direction == ScrollDirection.forward) {
              isFabVisible = true;
            }
            if (notif.direction == ScrollDirection.reverse) {
              isFabVisible = false;
            }
          });

          return true;
        },
        child: Visibility(
          visible: isFabVisible,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskScreen()),
              );
            },
            backgroundColor: greenColor,
            child: Image.asset('assets/images/icon_add.png'),
          ),
        ),
      ),
    );
  }
}
