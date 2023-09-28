// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sql_db/core/db_helper.dart';
import 'package:sql_db/theme/themes.dart';
import 'package:sql_db/widget/bottomsheet_widget.dart';

import '../models/task_model.dart';

class HomePageController extends ChangeNotifier {
  final _box = GetStorage();
  final _key = "isDarkMode";

  List<Task> taskList = [];

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController noteEditingController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a').format(DateTime.now());
  int selectedRemaind = 5;
  List<int> reminList = [5, 10, 15, 20];
  String selectedRepeat = 'None';
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int selectedColor = 0;

  void validation(BuildContext context) {
    if (titleEditingController.text.isNotEmpty &&
        noteEditingController.text.isNotEmpty) {
      _addTaskTodb();

      titleEditingController.clear();
      noteEditingController.clear();
    } else if (titleEditingController.text.isEmpty ||
        titleEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(
          content: Column(
            children: [Text("The title and note fields are required")],
          ),
        ),
      );
    }
  }

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  _addTaskTodb() async {
    int value = await addTask(
        task: Task(
            title: titleEditingController.text,
            note: noteEditingController.text,
            isCompleted: 0,
            date: DateFormat.yMd().format(selectedDate),
            startTime: startTime,
            endTime: endTime,
            color: selectedColor,
            remind: selectedRemaind,
            repeat: selectedRepeat));
  }

  final bool _isReady = false;
  get isReady => _isReady;
  void onReady() {
    if (isReady == true) {
      getTasks();
      notifyListeners();
    }
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
    getTasks();
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
    notifyListeners();
  }

  getDateFormat(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2016),
      lastDate: DateTime(2030),
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

    String formatTime = pickedTime.format(context);
    if (pickedTime == null) {
      print('Time canceled');
    } else if (isStartTime == true) {
      startTime = formatTime;
      notifyListeners();
    } else if (isStartTime == false) {
      endTime = formatTime;
      notifyListeners();
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
    showBottomSheet(
 
        enableDrag: true,
        context: context,
        builder: (context) {
          return 
          
          
          BottomSheetWidget(
            loadThemeFromBox: loadThemeFromBox(),
            context: context,
            task: task,
            onTaskCompletedPressed: () {
              markTaskComleted(task.id!);
              Navigator.of(context).pop();
            },
            onDeletePressed: () {
              delete(task);
              Navigator.of(context).pop();
            },
            onClosePressed: () {
              Navigator.of(context).pop();
            },
          );
        });

    notifyListeners();
  }


}
