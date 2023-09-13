import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/Theme/Color.dart';
import 'package:note_application/models/Task.dart';
import 'package:note_application/screens/add_task_screen.dart';
import 'package:note_application/screens/edit_task_screen.dart';
import 'package:note_application/widgets/Task/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var taskBox = Hive.box<Task>('taskBox');
  bool isFabVisible = true;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: ValueListenableBuilder(
            valueListenable: taskBox.listenable(),
            builder: (context, value, child) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notif) {
                  if (notif.direction == ScrollDirection.forward) {
                    setState(() {
                      isFabVisible = true;
                    });
                  }
                  if (notif.direction == ScrollDirection.reverse) {
                    setState(() {
                      isFabVisible = false;
                    });
                  }
                  return true;
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    var task = taskBox.values.toList()[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.horizontal,
                      onDismissed: (DismissDirection direction) {
                        if (direction == DismissDirection.endToStart) {
                          task.delete();
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditTaskScreen(
                                  task: task,
                                ),
                              ),
                            );
                        }
                      },
                      child: TaskWidget(task: task),
                    );
                  },
                  itemCount: taskBox.values.length,
                ),
              );
            },
          )),
      floatingActionButton: Visibility(
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
    );
  }
}
