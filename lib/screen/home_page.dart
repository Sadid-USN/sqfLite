import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sql_db/core/date_format.dart';
import 'package:sql_db/core/notify_helper.dart';
import 'package:sql_db/models/task_model.dart';

import 'package:sql_db/theme/themes.dart';
import 'package:sql_db/widget/header.dart';
import 'package:sql_db/widget/task_tile.dart';
import '../controllers/home_page_controller.dart';

//! 1:36

class HomePage extends StatefulWidget {
  final BuildContext context;
  const HomePage({
    super.key,
    required this.context,
  });

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    setState(() {
      context.read<HomePageController>().getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomePageController>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            context.read<HomePageController>().switchTheme();
            //NotificationHelper().scheduleNotification();
          },
          icon: provider.loadThemeFromBox()
              ? const Icon(Icons.nightlight_outlined)
              : const Icon(Icons.sunny),
        ),
        actions: [
          IconButton(
            onPressed: () {
              NotificationHelper().showNotification(
                  title: provider.taskList[0].title,
                  body: provider.taskList[0].note,
                  // payLoad: provider.taskList[0].note
                  
                  );
              // NotificationHelper().scheduleNotification(
              //     hour: int.parse("11:00".split(":")[0]),
              //     minutes: int.parse(
              //       "11:00".split(":")[1],
              //     ),
              //     task: provider.taskList[0]
              // );
            },
            icon: const Icon(
              Icons.person,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Consumer<HomePageController>(
        builder: (context, controller, child) => Column(
          children: [
            const Header(),
            // ignore: sized_box_for_whitespace
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 100,
              width: MediaQuery.sizeOf(context).width,
              child: DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                monthTextStyle: Theme.of(context).textTheme.titleSmall!,
                dateTextStyle: Theme.of(context).textTheme.titleMedium!,
                dayTextStyle: Theme.of(context).textTheme.titleSmall!,
                selectionColor: provider.loadThemeFromBox()
                    ? primaryColor
                    : lightPrimaryColor,
                onDateChange: controller.onDateChange,
              ),
            ),

            Expanded(
              child: Consumer<HomePageController>(
                builder: (context, value, child) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.taskList.length,
                  itemBuilder: (context, index) {
                    Task task = controller.taskList[index];

                    if (task.repeat == "Daily") {
                      // DateTime date = DateFormat.jm().parse(task.startTime.toString());
                      // var myTime  =  DateFormat("HH:mm").format(date);
                      // int.parse(myTime.toString().split(":")[0]);
                     // dateFormatParser(task.startTime ?? "null", 0),
                      // print(task.startTime);
                      NotificationHelper().scheduleNotification(
                        hour:  dateFormatParser(task.startTime!, 0),
                        minutes:   dateFormatParser(task.startTime!, 1),
                        task: task,
                      );

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Row(
                              children: [
                                TaskTile(
                                  task: task,
                                  onPressed: () {
                                    value.onShowBottomSheet(context, task);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (task.date ==
                        DateFormat.yMd().format(value.selectedDate)) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Row(
                              children: [
                                TaskTile(
                                  task: task,
                                  onPressed: () {
                                    value.onShowBottomSheet(context, task);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();

                      // Center(
                      //   child: DefaultTextStyle(
                      //     style: GoogleFonts.lato(
                      //       textStyle: const TextStyle(
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.blueGrey,
                      //       ),
                      //     ),
                      //     child: AnimatedTextKit(
                      //         pause: const Duration(seconds: 2),
                      //         repeatForever: true,
                      //         animatedTexts: [
                      //           TyperAnimatedText("You have no tasks yet",
                      //               speed: const Duration(milliseconds: 100)),
                      //         ]),
                      //   ),
                      // );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   SQLdb sqlDB = SQLdb();
//   bool isLoading = false;
//   List todos = [];

//   Future read() async {
//     List<Map> response = await sqlDB.readData("SELECT * FROM todos");
//     todos.addAll(response);
//     isLoading = true;
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   int selectedIndex = 0;
//   final _tabs = [
//     const AllTodoPage(),
//     const CompletedTodo(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//    var controller = Provider.of<HomePageController>(context);
//     return WillPopScope(
//       onWillPop: () async {
//         SystemNavigator.pop();
//         return false;
//       },
//       child: Scaffold(
//         drawer: Drawer(

//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ListTile(
//                     title: const Text('Theme mode'),
//                     leading:  const Icon(
//                           Icons.nightlight_outlined,
//                           size: 25,
//                         ),

//                     onTap: () {
//                       controller.switchBrightness();
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         appBar: AppBar(
//           automaticallyImplyLeading: true,
//           backgroundColor: Theme.of(context).primaryColor,
//           actions: [
//             IconButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return const LangugesPage();
//                     },
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.language),
//             ),
//           ],
//           title: const LocaleText(
//             'todo',
//             style: TextStyle(fontWeight: FontWeight.w600),
//           ),
//           centerTitle: true,
//         ),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Theme.of(context).primaryColor,
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) {
//                   return const AddTodo();
//                 },
//               ),
//             );
//           },
//           child: const Icon(Icons.add, color: Colors.white,),
//         ),
//         bottomNavigationBar: BottomNavigationBar(

//           unselectedItemColor: Colors.white.withOpacity(0.7),
//           selectedItemColor: Colors.white,
//           currentIndex: selectedIndex,
//           onTap: (index) => setState(() {
//             selectedIndex = index;
//           }),
//           items: [
//             BottomNavigationBarItem(
//               icon: const Icon(
//                 Icons.task_outlined,
//                 size: 30,
//               ),
//               label: Locales.string(context, 'labeltask'),
//             ),
//             BottomNavigationBarItem(
//               icon: const Icon(
//                 Icons.check_circle_outline,
//                 size: 30,
//               ),
//               label: Locales.string(context, 'completed'),
//             ),
//           ],
//         ),
//         body: isLoading
//             ? Center(
//                 child: JumpingText(
//                 'Sabr...',
//                 style: const TextStyle(fontSize: 16),
//               ))
//             : _tabs[selectedIndex],
//       ),
//     );
//   }
// }