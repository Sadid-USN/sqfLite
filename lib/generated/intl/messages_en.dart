// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(selectedRemaind) => "${selectedRemaind} minutes early";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewTask": MessageLookupByLibrary.simpleMessage("Add a new task"),
        "addTask": MessageLookupByLibrary.simpleMessage("Add Task"),
        "color": MessageLookupByLibrary.simpleMessage("Color"),
        "createTask": MessageLookupByLibrary.simpleMessage("Create Task"),
        "daily": MessageLookupByLibrary.simpleMessage("Daily"),
        "date": MessageLookupByLibrary.simpleMessage("Date"),
        "endTime": MessageLookupByLibrary.simpleMessage("End Time"),
        "enterNoteHere":
            MessageLookupByLibrary.simpleMessage("Enter note here"),
        "enterTitleHere":
            MessageLookupByLibrary.simpleMessage("Enter title here"),
        "language": MessageLookupByLibrary.simpleMessage("Languages"),
        "monthly": MessageLookupByLibrary.simpleMessage("Monthly"),
        "none": MessageLookupByLibrary.simpleMessage("None"),
        "note": MessageLookupByLibrary.simpleMessage("Note"),
        "reminder": MessageLookupByLibrary.simpleMessage("Reminder"),
        "repeat": MessageLookupByLibrary.simpleMessage("Repeat"),
        "selectedremaindMinutesEarly": m0,
        "startTime": MessageLookupByLibrary.simpleMessage("Start Time"),
        "title": MessageLookupByLibrary.simpleMessage("Title"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "weekly": MessageLookupByLibrary.simpleMessage("Weekly"),
        "youLeftTheFieldsEmpty": MessageLookupByLibrary.simpleMessage(
            "You left the \'Title\' and \'Note\' fields empty.")
      };
}
