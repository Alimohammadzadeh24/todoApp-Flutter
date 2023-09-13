import 'package:note_application/widgets/Task/task_type.dart';
import 'package:note_application/widgets/Task/task_type_enum.dart';

List<TaskType> getListTaskType() {
  var TaskTypeList = [
    TaskType(
      image: 'assets/images/work_meeting.png',
      title: 'میتینگ',
      taskTypeEnum: TaskTypeEnum.dating,
    ),
    TaskType(
      image: 'assets/images/meditate.png',
      title: 'تمرکز',
      taskTypeEnum: TaskTypeEnum.focus,
    ),
    TaskType(
      image: 'assets/images/hard_working.png',
      title: 'کار',
      taskTypeEnum: TaskTypeEnum.working,
    ),
  ];
  return TaskTypeList;
}
