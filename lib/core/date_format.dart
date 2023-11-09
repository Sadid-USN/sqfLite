import 'package:intl/intl.dart';

int timeFormatParser(String timeString, int index) {
  DateTime dateTime = DateFormat('h:mm a').parse(timeString);
  String formattedTime = DateFormat('h:mm a').format(dateTime);
  List<String> timeParts = formattedTime.split(':');

  return int.parse(timeParts[index == 0 ? 0 : 1].split(' ')[0]);
}
