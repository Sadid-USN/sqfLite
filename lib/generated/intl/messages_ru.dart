// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(selectedRemaind) =>
      "${selectedRemaind} минут до уведомления";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewTask":
            MessageLookupByLibrary.simpleMessage("Добавить новую задачу"),
        "addTask": MessageLookupByLibrary.simpleMessage("Задача"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "color": MessageLookupByLibrary.simpleMessage("Цвет"),
        "createTask": MessageLookupByLibrary.simpleMessage("Создать задачу"),
        "daily": MessageLookupByLibrary.simpleMessage("Ежедневно"),
        "date": MessageLookupByLibrary.simpleMessage("Дата"),
        "deleteTask": MessageLookupByLibrary.simpleMessage("Delete task"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "endTask": MessageLookupByLibrary.simpleMessage("End task"),
        "endTime": MessageLookupByLibrary.simpleMessage("Конец"),
        "enterNoteHere":
            MessageLookupByLibrary.simpleMessage("Введите заметку здесь"),
        "enterTitleHere":
            MessageLookupByLibrary.simpleMessage("Введите название здесь"),
        "language": MessageLookupByLibrary.simpleMessage("Языки"),
        "monthly": MessageLookupByLibrary.simpleMessage("Ежемесячно"),
        "none": MessageLookupByLibrary.simpleMessage("Никогда"),
        "reminder": MessageLookupByLibrary.simpleMessage("Напоминание"),
        "repeat": MessageLookupByLibrary.simpleMessage("Повторить"),
        "selectedremaindMinutesEarly": m0,
        "startTime": MessageLookupByLibrary.simpleMessage("Начало"),
        "task": MessageLookupByLibrary.simpleMessage("Task"),
        "title": MessageLookupByLibrary.simpleMessage("Название"),
        "today": MessageLookupByLibrary.simpleMessage("Сегодня"),
        "uddateTask": MessageLookupByLibrary.simpleMessage("Uddate Task"),
        "weekly": MessageLookupByLibrary.simpleMessage("Еженедельно"),
        "youLeftTheFieldsEmpty": MessageLookupByLibrary.simpleMessage(
            "Вы не заполнили поле Название и поле Задача.")
      };
}
