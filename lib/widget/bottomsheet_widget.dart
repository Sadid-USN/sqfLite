import 'package:flutter/material.dart';
import 'package:sql_db/models/task_model.dart';
import 'package:sql_db/theme/themes.dart';
import 'package:sql_db/widget/bottom_sheet_button.dart';

class BottomSheetWidget extends StatelessWidget {
  final BuildContext context;
  final Task task;
  final bool loadThemeFromBox;
  final void Function() onTaskCompletedPressed;
  final void Function() onDeletePressed;
  final void Function() onClosePressed;

  const BottomSheetWidget({super.key, 
    required this.context,
    required this.task,
    required this.loadThemeFromBox,
    required this.onTaskCompletedPressed,
    required this.onDeletePressed,
    required this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
    
      padding: const EdgeInsets.only(top: 4.0),
      height: task.isCompleted == 1 ? size.height * 0.30 : size.height * 0.32,
      width: size.width,
      color: loadThemeFromBox ?  primaryColor: secondaryColor ,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: 4.0,
              width: size.width / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: loadThemeFromBox ? Colors.grey.shade200 : Colors.grey.shade300,
              ),
            ),
            task.isCompleted == 1 ? const SizedBox(height: 40) : const SizedBox(height: 16),
      
            BottomSheetButton(
              isTaskCompleted: task.isCompleted == 1 ? true : false,
              color: Colors.indigo,
              title: "End task",
              onPressed: onTaskCompletedPressed,
            ),
            BottomSheetButton(
              color: Colors.red,
              title: "Delete task",
              onPressed: onDeletePressed,
            ),
            const SizedBox(height: 10),
            BottomSheetButton(
              borderColor: Colors.white,
              color: Colors.blueGrey.shade400,
              title: "Close",
              onPressed: onClosePressed,
            ),
            
          ],
        ),
      ),
    );
  }
}




