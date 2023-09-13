import 'package:flutter/material.dart';
import 'package:note_application/Theme/Color.dart';
import 'package:note_application/widgets/Task/task_type.dart';

class getTaskTypeListItem extends StatelessWidget {
  getTaskTypeListItem({
    super.key,
    required this.taskType,
    required this.index,
    required this.selectedItemIndex,
  });

  final TaskType taskType;

  final int index;
  final int selectedItemIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      decoration: BoxDecoration(
        color: (selectedItemIndex == index) ? greenColor : Colors.transparent,
        border: Border.all(
          width: (selectedItemIndex == index) ? 3 : 1,
          color: (selectedItemIndex == index)
              ? greenColor
              : blackColor.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(taskType.image),
          SizedBox(height: 8),
          Text(
            taskType.title,
            style: TextStyle(
              color: (selectedItemIndex == index) ? Colors.white : blackColor,
            ),
          )
        ],
      ),
    );
  }
}
