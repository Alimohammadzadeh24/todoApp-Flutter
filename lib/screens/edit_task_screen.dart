import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/Theme/Color.dart';
import 'package:note_application/models/Task.dart';
import 'package:note_application/utilities/utility.dart';
import 'package:note_application/widgets/Task/task_type_widget.dart';
import 'package:time_pickerr/time_pickerr.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});
  final Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode titleFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();

  var controllerTitle = TextEditingController();
  var controllerSubTitle = TextEditingController();

  int _selectedItemIndex = 0;

  @override
  void initState() {
    super.initState();

    titleFocusNode.addListener(() {
      setState(() {});
    });
    descFocusNode.addListener(() {
      setState(() {});
    });

    controllerTitle.text = widget.task.title;
    controllerSubTitle.text = widget.task.subTitle;

    var selectedTaskTypeIndex = getListTaskType().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });

    _selectedItemIndex = selectedTaskTypeIndex;
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
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    String taskTitle = controllerTitle.text;
                    String taskSubTitle = controllerSubTitle.text;
                    if (taskTitle.isNotEmpty && taskSubTitle.isNotEmpty) {
                      editTask(taskTitle, taskSubTitle);
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
                      'ویرایش کردن تسک',
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

  editTask(String taskTitle, String taskSubTitle) {
    widget.task.title = taskTitle;
    widget.task.subTitle = taskSubTitle;
    widget.task.time = _time!;
    widget.task.taskType = getListTaskType()[_selectedItemIndex];
    widget.task.save();
  }
}
