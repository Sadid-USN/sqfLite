import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import 'package:sql_db/theme/themes.dart';
import 'package:sql_db/widget/header.dart';
import 'package:sql_db/widget/task_tile.dart';
import '../controllers/home_page_controller.dart';

//! 44:17

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
    context.read<HomePageController>().getTasks();
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDay = DateTime.now();
    var changeIcon = Provider.of<HomePageController>(context).loadThemeFromBox();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            context.read<HomePageController>().switchTheme();
          },
          icon: changeIcon
              ? const Icon(Icons.nightlight_outlined)
              : const Icon(Icons.sunny),
        ),
        actions: [
          IconButton(
            onPressed: () {},
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
                selectionColor: primaryColor,
                onDateChange: (date) {
                  controller.selectedDate = date;
                },
              ),
            ),

            Expanded(
              child: Consumer<HomePageController>(
                builder: (context, value, child) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.taskList.length,
                  itemBuilder: (context, index) {
                    var task = controller.taskList[index];

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              TaskTile(
                                task: task,
                                onPressed: () {
                                  value.onShowBottomSheet(context,task);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
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
