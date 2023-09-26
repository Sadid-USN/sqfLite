import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sql_db/controllers/home_page_controller.dart';
import 'package:sql_db/widget/color_palet.dart';
import 'package:sql_db/widget/custom_field.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeController = Provider.of<HomePageController>(context);

    var dateFormat = DateFormat('M/d/yyyy').format(homeController.selectedDate);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: 
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Consumer<HomePageController>(
                builder: (context, value, child) =>  CustomField(
                  controller: value.titleEditingController,
                  title: "Title",
                  hintText: 'Enter title here',
                ),
              ),
              Consumer<HomePageController>(
                builder: (context, value, child) =>  CustomField(
                  controller: value.noteEditingController,
                  title: "Note",
                  hintText: 'Enter note here',
                ),
              ),
              Consumer<HomePageController>(
                builder: (context, value, child) => CustomField(
                  title: "Date",
                  hintText: dateFormat,
                  widget: IconButton(
                    onPressed: () {
                      value.getDateFormat(context);
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                    ),
                  ),
                ),
              ),
             Consumer<HomePageController>(
              builder: (context, value, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomField(
                        width: MediaQuery.of(context).size.width / 2.3,
                        title: "Start Time",
                        hintText: value.startTime,
                        widget: IconButton(
                          onPressed: () {
                            value.getTimeFromUser(
                                isStartTime: true, context: context);
                          },
                          icon: const Icon(Icons.access_time_rounded),
                        ),
                      ),
                      Consumer<HomePageController>(
                        builder: (context, value, child) => CustomField(
                          width: MediaQuery.of(context).size.width / 2.3,
                          title: "End Time",
                          hintText: value.endTime,
                          widget: IconButton(
                            onPressed: () {
                              value.getTimeFromUser(
                                  isStartTime: false, context: context);
                            },
                            icon: const Icon(Icons.access_time_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
             ),
               
              Consumer<HomePageController>(
                builder: (context, value, child) =>  CustomField(
                  title: "Reminder",
                  hintText: "${value.selectedRemaind} minuts early",
                  widget: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 4,
                        items: value.reminList
                            .map<DropdownMenuItem<String>>((int element) {
                          return DropdownMenuItem<String>(
                            value: element.toString(),
                            child: Text(element.toString()),
                          );
                        }).toList(),
                        onChanged: value.onRemaindChanged,
                      )),
                ),
              ),
                Consumer<HomePageController>(
                  builder: (context, value, child) =>  CustomField(
                  title: "Repeat",
                  hintText: value.selectedRepeat,
                  widget: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: DropdownButton<String>(
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      elevation: 4,
                      items: value.repeatList
                          .map<DropdownMenuItem<String>>((String repeat) {
                        return DropdownMenuItem<String>(
                          value: repeat,
                          child: Text(
                            repeat,
                          ),
                        );
                      }).toList(),
                      onChanged: value.onRepeatChanged,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const ColorPalet()
            ],
          ),
        ),
      ),
    );
  }
}
