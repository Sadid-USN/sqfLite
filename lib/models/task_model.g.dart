// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      id: json['id'] as int?,
      title:  (json['title'] is int)
           ? json['title'].toString():(json['title'] as String),
      note: (json['note'] is int)
          ? json['note'].toString() : (json['note'] as String),
      isCompleted: json['isCompleted'] as int?,
      date: json['date'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      color: json['color'] as int?,
      remind: json['remind'] as int?,
      repeat: json['repeat'] as String?,
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'note': instance.note,
      'isCompleted': instance.isCompleted,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'color': instance.color,
      'remind': instance.remind,
      'repeat': instance.repeat,
    };
