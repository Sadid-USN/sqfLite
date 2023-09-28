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

// class Task {
//   final int? id;
//   final String? title;
//   final String? note;
//   final int? isCompleted;
//   final String? date;
//   final String? startTime;
//   final String? endTime;
//   final int? color;
//   final int? remind;
//   final String? repeat;

//   const Task({
//     this.id,
//     this.title,
//     this.note,
//     this.isCompleted,
//     this.date,
//     this.startTime,
//     this.endTime,
//     this.color,
//     this.remind,
//     this.repeat,
//   });

//   Task copyWith({
//     int? id,
//     String? title,
//     String? note,
//     int? isCompleted,
//     String? date,
//     String? startTime,
//     String? endTime,
//     int? color,
//     int? remind,
//     String? repeat,
//   }) {
//     return Task(
//       id: id ?? this.id,
//       title: title ,
//       note: title ,
//       isCompleted: isCompleted ?? this.isCompleted,
//       date: date ?? this.date,
//       startTime: startTime ?? this.startTime,
//       endTime: endTime ?? this.endTime,
//       color: color ?? this.color,
//       remind: remind ?? this.remind,
//       repeat: repeat ?? this.repeat,
//     );
//   }

//  Task.fromJson(Map<String, dynamic> json)
//     : id = json['id'] as int?,
//       title = (json['title'] is int)
//           ? json['title'].toString()
//           : json['title'] as String?,
//       note = (json['note'] is int)
//           ? json['note'].toString()
//           : json['note'] as String?,
//       isCompleted = json['isCompleted'] as int?,
//       date = json['date'] as String?,
//       startTime = json['startTime'] as String?,
//       endTime = json['endTime'] as String?,
//       color = json['color'] as int?,
//       remind = json['remind'] as int?,
//       repeat = json['repeat'] as String?;


//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'title': title,
//         'note': note,
//         'isCompleted': isCompleted,
//         'date': date,
//         'startTime': startTime,
//         'endTime': endTime,
//         'color': color,
//         'remind': remind,
//         'repeat': repeat
//       };
// }



