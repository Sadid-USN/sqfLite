// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sql_db/controllers/theme_controller.dart';
import 'package:sql_db/core/db_helper.dart';
import 'package:sql_db/core/validator.dart';
import 'package:sql_db/generated/l10n.dart';
import 'package:sql_db/languge_box.dart';
import 'package:sql_db/screen/add_task_page.dart';
import 'package:sql_db/screen/edit_task_page.dart';
import 'package:sql_db/theme/themes.dart';
import 'package:sql_db/widget/bottomsheet_widget.dart';

import '../models/task_model.dart';

class HomePageController extends ChangeNotifier {
  final _box = GetStorage();
  final _key = "isDarkMode";

  List<Task> taskList = [];

  ThemeController themeController = ThemeController();

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController noteEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> editPageformKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('h:mm a').format(DateTime.now());
  String endTime = DateFormat('h:mm a').format(DateTime.now());

  int selectedRemaind = 5;
  List<int> reminList = [5, 10, 15, 20];
  String selectedRepeat = 'Никогда';
  List<String> repeatList = [
    "Никогда",
    // "Ежедневно",
    // "Еженедельно",
    // "Ежемесячно",
  ];

  int selectedColor = 0;

  String get selectedDayToyMd {
    return DateFormat.yMd().format(selectedDate);
  }

  void onLanguageChanged(String lang) {
    languageBox.write('code', lang);
    notifyListeners();
  }

  void validation(BuildContext context) {
    if (titleEditingController.text.isNotEmpty &&
        noteEditingController.text.isNotEmpty) {
      _addTaskTodb();
      getTasks();
      themeController.playAssetAudio('lib/audio/click.mp3');

      titleEditingController.clear();
      noteEditingController.clear();
      Navigator.of(context).pop();
    } else {
      themeController.playAssetAudio('lib/audio/empty_filed.mp3');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: error,
          content: Column(
            children: [
              Text(
                "Вы не заполнили обязательные поля",
              )
            ],
          ),
        ),
      );
    }
  }

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  _addTaskTodb() async {
    await addTask(
        task: Task(
            title: titleEditingController.text,
            note: noteEditingController.text,
            isCompleted: 0,
            date: selectedDayToyMd,
            startTime: startTime,
            endTime: endTime,
            color: selectedColor,
            remind: selectedRemaind,
            repeat: selectedRepeat));
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.clear();
    taskList.addAll(tasks.map((data) => Task.fromJson(data)).toList());

    notifyListeners();
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTasks();
  }

  void markTaskComleted(int id) async {
    await DBHelper.update(id);
    themeController.playAssetAudio("lib/audio/complete.mp3");
    getTasks();
    notifyListeners();
  }

  Future<void> onTaskEdit(Task task) async {
    themeController.playAssetAudio('lib/audio/edit_task.mp3');
    await DBHelper.updateTask(
        task); // Update the task using DBHelper's updateTask method
    getTasks(); // Refresh the task list
    notifyListeners();
  }

  bool isDarkMode = false;
  bool loadThemeFromBox() => _box.read(_key) ?? false;

  _saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);

  ThemeMode get themeMode =>
      loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    isDarkMode = loadThemeFromBox();
    _saveTheme(!isDarkMode);
    notifyListeners();
  }

  ThemeData get themeData {
    bool isDarkMode = loadThemeFromBox();
    return isDarkMode ? Themes.dark : Themes.light;
  }

  void onDateChange(DateTime date) {
    selectedDate = date;
    themeController.playAssetAudio("lib/audio/calendar_tap.mp3");
    notifyListeners();
  }

  getDateFormat(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2005),
      lastDate: DateTime(2060),
    );

    if (pickerDate != null) {
      selectedDate = pickerDate;
    } else {
      print("something went wrong");
    }
    notifyListeners();
  }

  getTimeFromUser(
      {required bool isStartTime, required BuildContext context}) async {
    var pickedTime = await _showTimePicker(context);
    if (context.mounted) {
      String formatTime = pickedTime.format(context);
      if (pickedTime == null) {
      } else if (isStartTime == true) {
        startTime = formatTime;
        notifyListeners();
      } else if (isStartTime == false) {
        endTime = formatTime;
        notifyListeners();
      }
    }

    notifyListeners();
  }

  _showTimePicker(BuildContext context) {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(startTime.split(":")[0]),
        minute: int.parse(startTime.split(":")[1].split(" ")[0]),
      ),
      // : TimeOfDay(
      //     hour: int.parse(startTime.split(":")[0]),
      //     minute: int.parse(startTime.split(":")[1].split(" ")[0]),
      //   ),

      // .split(" ")[0]
      // builder: (context, child) {
      //   return MediaQuery(
      //       data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
      //       child: child!);
      // },
    );
  }

  void onRemaindChanged(String? newvalue) {
    selectedRemaind = int.parse(newvalue!);
    notifyListeners();
  }

  void onRepeatChanged(String? newvalue) {
    selectedRepeat = newvalue!;
    notifyListeners();
  }

  void onColorTap(int index) {
    selectedColor = index;
    notifyListeners();
  }

  void onShowBottomSheet(BuildContext context, Task task) {
    themeController.playAssetAudio('lib/audio/open.mp3');
    showBottomSheet(
        enableDrag: true,
        context: context,
        builder: (context) {
          return BottomSheetWidget(
            loadThemeFromBox: loadThemeFromBox(),
            context: context,
            task: task,
            onTaskCompletedPressed: () {
              markTaskComleted(task.id!);
              Navigator.of(context).pop();
            },
            onDeletePressed: () {
              delete(task);
              themeController.playAssetAudio("lib/audio/delete_task.mp3");
              Navigator.of(context).pop();
            },
            onClosePressed: () {
              themeController.playAssetAudio('lib/audio/open.mp3');
              Navigator.of(context).pop();
            },
            onTaskEdit: () {
              onTaskEdit(task);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskPage(
                    task: task,
                  ),
                ),
              );
            },
          );
        });

    notifyListeners();
  }


}
