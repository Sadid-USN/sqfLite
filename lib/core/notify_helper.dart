import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:sql_db/models/task_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_timezone;

void selectNotification(NotificationResponse details) {
  if (details.payload != null) {
    print("Notification payload ${details.payload}");
  } else {
    print("Notification done");
  }
  print("Go to the page");
}

class NotificationHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    _configureLocalTimeZone();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {

          },
      onDidReceiveBackgroundNotificationResponse: selectNotification,
    );
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return flutterLocalNotificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification(
      {required int hour, required int minutes, required Task task}) async {
    return flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!.toInt(),
      task.title,
      task.note,
      _convertTime(hour, minutes),
      // tz.TZDateTime.now(tz.local).add(  Duration(minutes: minutes)),
      await notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      // payload: "${task.title}|${task.title}"
    );
  }

  tz.TZDateTime _convertTime(int hour, int minuts) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minuts,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(hours: 1));
    }
    return scheduleDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz_timezone.initializeTimeZones();
    final timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

//   Future scheduleNotification({
//   int id = 0,
//   String? title,
//   String? body,
//   String? payload,
// }) async {
//   final now = DateTime.now();
//   final scheduledTime = now.add(const Duration(seconds: 5));

//   var notificationTime = tz.TZDateTime.from(
//     scheduledTime,
//     tz.local,
//   );

//   return notificationsPlugin.zonedSchedule(
//     id,
//     title,
//     body,
//     notificationTime,
//     await notificationDetails(),
//     androidScheduleMode: AndroidScheduleMode.exact,
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//   );
// }
}
