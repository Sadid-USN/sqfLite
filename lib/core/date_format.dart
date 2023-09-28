import 'package:intl/intl.dart';


int dateFormatParser(String startDay, int index) {
  DateTime date = DateFormat.jm().parse(startDay.toString());
  var myTime = DateFormat("HH:mm").format(date);
  return int.parse(myTime.toString().split(":")[index]);
}

