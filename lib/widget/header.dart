import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:sql_db/controllers/theme_controller.dart';
import 'package:sql_db/generated/l10n.dart';

import 'package:sql_db/screen/add_task_page.dart';
import 'package:sql_db/widget/add_task_button.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final dateFormatNow = DateFormat.yMMMMd().format(DateTime.now());
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateFormatNow,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 5,),
              Text(
                S.of(context).today,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Consumer<ThemeController>(
            builder: (context, themeController, child) => AddTaskButton(
              title: S.of(context).addTask,
              onPressed: () {
                // Call playAudio method from ThemeController
                themeController.playAssetAudio("lib/audio/click.mp3");
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return const AddTaskPage();
                })));
              },
            ),
          ),
        ],
      ),
    );
  }
}
