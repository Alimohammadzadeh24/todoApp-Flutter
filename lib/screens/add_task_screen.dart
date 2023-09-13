import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/Theme/Color.dart';
import 'package:note_application/models/Task.dart';
import 'package:note_application/utilities/utility.dart';
import 'package:note_application/widgets/Task/task_type.dart';
import 'package:note_application/widgets/Task/task_type_widget.dart';
import 'package:time_pickerr/time_pickerr.dart';

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

  DateTime? _time;

  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomHourPicker(
                    elevation: 0,
                    title: 'زمان تسک را انتخاب کنید',
                    titleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: greenColor,
                    ),
                    positiveButtonText: 'انتخاب زمان',
                    positiveButtonStyle: TextStyle(
                      color: greenColor,
                      fontSize: 14,
                    ),
                    negativeButtonText: '',
                    onPositivePressed: (context, time) {
                      _time = time;
                    },
                  ),
                ),
                Container(
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: getListTaskType().length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedItemIndex = index;
                            });
                          },
                          child: getTaskTypeListItem(
                            index: index,
                            selectedItemIndex: _selectedItemIndex,
                            taskType: getListTaskType()[index],
                          ),
                        );
                      }),
                ),
                SizedBox(height: 16),
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
    var task = Task(
      title: taskTitle,
      subTitle: taskSubTitle,
      time: _time!,
      taskType: getListTaskType()[_selectedItemIndex],
    );
    box.add(task);
  }
}

