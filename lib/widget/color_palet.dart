import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sql_db/controllers/home_page_controller.dart';
import 'package:sql_db/generated/l10n.dart';
import 'package:sql_db/models/task_model.dart';
import 'package:sql_db/screen/home_page.dart';
import 'package:sql_db/theme/themes.dart';
import 'package:sql_db/widget/add_task_button.dart';

class ColorPalet extends StatelessWidget {
  final Task? task;

  const ColorPalet({
    super.key,
    this.task,
  });
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<HomePageController>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           task != null
                ? const SizedBox(): Text(
              S.of(context).color,
              style: textTheme.titleSmall!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            task != null
                ? const SizedBox()
                : Wrap(
                    children: List<Widget>.generate(3, (int index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<HomePageController>().selectedColor =
                              index;
                        },
                        child: Consumer<HomePageController>(
                          builder: (context, value, child) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<HomePageController>()
                                    .onColorTap(index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: index == 0
                                      ? lightPrimaryColor
                                      : index == 1
                                          ? Colors.purple
                                          : Colors.blueGrey.shade500,
                                  child: controller.selectedColor == index
                                      ? const Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 16.0,
                                        )
                                      : const SizedBox(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: AddTaskButton(
            showIcon: false,
            title: task != null ? "Update Task" : S.of(context).createTask,
            onPressed: () {
              if (task != null) {
                Task updatedTask = task!.copyWith(
                  title: controller.titleEditingController.text,
                  note: controller.noteEditingController.text,
                );

                controller.onTaskEdit(updatedTask);
                Navigator.of(context).pop();
              } else {
                controller.validation(context);
                
              }
            },
          ),
        ),
      ],
    );
  }
}
