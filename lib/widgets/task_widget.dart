import 'package:flutter/material.dart';
import 'package:note_application/Theme/Color.dart';
import 'package:note_application/models/Task.dart';

class getTaskWidget extends StatefulWidget {
  getTaskWidget({super.key, required this.task});
  Task task;

  @override
  State<getTaskWidget> createState() => _getTaskWidgetState();
}

class _getTaskWidgetState extends State<getTaskWidget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                          value: widget.task.isDone,
                          onChanged: (selected) {
                            isBoxChecked = selected!;
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.task.title,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(widget.task.subTitle),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 83,
                          height: 28,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: greenColor),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '10:00',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: Image.asset(
                                      'assets/images/icon_time.png'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          width: 83,
                          height: 28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: lightGreenColor,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'ویرایش',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: greenColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Image.asset('assets/images/icon_edit.png'),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(width: 20),
              Image.asset('assets/images/workout.png'),
            ],
          ),
        ),
      ),
    );
  }
}
