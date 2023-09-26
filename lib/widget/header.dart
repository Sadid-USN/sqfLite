import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              Text(
                "Today",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          AddTaskButton(
            title: "Add Task",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return const AddTaskPage();
              })));
            },
          ),
        ],
      ),
    );
  }
}
