import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sql_db/controllers/home_page_controller.dart';
import 'package:sql_db/generated/l10n.dart';
import 'package:sql_db/theme/themes.dart';
import 'package:sql_db/widget/add_task_button.dart';

class ColorPalet extends StatelessWidget {
  const ColorPalet({super.key});
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
            Text(
              S.of(context).color,
              style: textTheme.titleSmall!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            Wrap(
              children: List<Widget>.generate(3, (int index) {
                return GestureDetector(
                  onTap: () {
                    context.read<HomePageController>().selectedColor = index;
                  },
                  child: Consumer<HomePageController>(
                    builder: (context, value, child) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          context.read<HomePageController>().onColorTap(index);
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
            title: S.of(context).createTask,
            onPressed: () async {
           
         

              controller.validation(context);
       
          

              // controller.getTasks();

             
            },
          ),
        ),
      ],
    );
  }
}
