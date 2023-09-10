import 'package:hive/hive.dart';

part 'Task.g.dart';

@HiveType(typeId: 1)
class Task {
  Task({required this.title , required this.subTitle});

  @HiveField(0)
  String title;
  
  @HiveField(1)
  String subTitle;
}
