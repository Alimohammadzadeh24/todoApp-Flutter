import 'package:hive_flutter/hive_flutter.dart';

part 'task_type_enum.g.dart';

@HiveType(typeId: 3)
enum TaskTypeEnum {
  @HiveField(0)
  working,

  @HiveField(1)
  dating,

  @HiveField(2)
  focus,
}
