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
//       title: title ?? this.title,
//       note: note ?? this.note,
//       isCompleted: isCompleted ?? this.isCompleted,
//       date: date ?? this.date,
//       startTime: startTime ?? this.startTime,
//       endTime: endTime ?? this.endTime,
//       color: color ?? this.color,
//       remind: remind ?? this.remind,
//       repeat: repeat ?? this.repeat,
//     );
//   }

//   Task.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         title = json['title'] as String?,
//         note = json['note'] as String?,
//         isCompleted = json['isCompleted'] as int?,
//         date = json['date'] as String?,
//         startTime = json['startTime'] as String?,
//         endTime = json['endTime'] as String?,
//         color = json['color'] as int?,
//         remind = json['remind'] as int?,
//         repeat = json['repeat'] as String?;

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
