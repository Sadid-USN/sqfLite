
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';
@freezed
@immutable
class Task with _$Task {
  const factory Task({
    int? id,
    String? title,
    String? note,
    int? isCompleted,
    String? date,
    String? startTime,
    String? endTime,
    int? color,
    int? remind,
    String? repeat,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
