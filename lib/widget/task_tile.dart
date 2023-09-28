import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sql_db/models/task_model.dart';
import 'package:sql_db/theme/themes.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final void Function()? onPressed;

  const TaskTile({
    super.key,
    required this.task,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          //foregroundColor: Colors.transparent,
          padding: const EdgeInsets.all(16),
          backgroundColor: _getBGClr(task.color ?? 0),
          shape: RoundedRectangleBorder(
            //side: const BorderSide(),
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title ?? "",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${task.startTime} - ${task.endTime}",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[100],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    task.note ?? "",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[100],
                      ),
                    ),
                  ),
                ],
              ),
            ),
             Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    width: 0.5,
                    color: Colors.grey[200]!.withOpacity(0.7),
                  ),
            RotatedBox(
                quarterTurns: 3,
                child: DefaultTextStyle(
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  child: task.isCompleted == 1 ?
                  
                  AnimatedTextKit(
                      pause: const Duration(seconds: 2),
                      repeatForever: task.isCompleted == 1 ? true : false,
                      animatedTexts: [
                        TyperAnimatedText("COMPLETED",
                        speed: const Duration(milliseconds: 100)
                           ),
                      ]): const Text("TODO"),
                )

                // Text(
                //   task.isCompleted == 1 ? "COMPLETED" : "TODO",
                //   style: GoogleFonts.lato(
                //     textStyle: const TextStyle(
                //       fontSize: 10,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                ),
          ],
        ),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return lightPrimaryColor;
      case 1:
        return Colors.pink;
      case 2:
        return Colors.orange;
      default:
        return lightPrimaryColor;
    }
  }
}
