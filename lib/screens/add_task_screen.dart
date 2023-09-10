import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/Theme/Color.dart';
import 'package:note_application/models/Task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  FocusNode titleFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();

  var controllerTitle = TextEditingController();
  var controllerSubTitle = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleFocusNode.addListener(() {
      setState(() {});
    });
    descFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    titleFocusNode.dispose();
    descFocusNode.dispose();

    super.dispose();
  }

  var box = Hive.box<Task>('taskBox');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 48),
            child: Column(
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTitle,
                    focusNode: titleFocusNode,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        borderSide: BorderSide(color: greyColor, width: 3),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        borderSide: BorderSide(color: greenColor, width: 3),
                      ),
                      labelText: ' عنوان تسک ',
                      labelStyle: TextStyle(
                        color: titleFocusNode.hasFocus ? greenColor : greyColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    focusNode: descFocusNode,
                    controller: controllerSubTitle,
                    maxLines: 2,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        borderSide: BorderSide(color: greyColor, width: 3),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        borderSide: BorderSide(color: greenColor, width: 3),
                      ),
                      labelText: ' توضیحات تسک ',
                      labelStyle: TextStyle(
                        color: descFocusNode.hasFocus ? greenColor : greyColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    String taskTitle = controllerTitle.text;
                    String taskSubTitle = controllerSubTitle.text;
                    if (taskTitle.isNotEmpty && taskSubTitle.isNotEmpty) {
                      addTask(taskTitle, taskSubTitle);
                      Navigator.pop(context);
                    } else {
                      return;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'اضافه کردن تسک',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addTask(String taskTitle, String taskSubTitle) {
    var task = Task(title: taskTitle, subTitle: taskSubTitle);
    box.add(task);
  }
}
