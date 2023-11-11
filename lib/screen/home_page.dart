
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sql_db/controllers/theme_controller.dart';
import 'package:sql_db/core/addbunner_helper.dart';

import 'package:sql_db/models/task_model.dart';
import 'package:sql_db/screen/add_task_page.dart';

import 'package:sql_db/widget/header.dart';
import 'package:sql_db/widget/task_tile.dart';
import '../controllers/home_page_controller.dart';

class HomePage extends StatefulWidget {
  static const HOME = '/home';
  final BuildContext context;
  const HomePage({
    super.key,
    required this.context,
  });

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BannerAdHelper bannerAdHelper = BannerAdHelper();

  @override
  void initState() {
    super.initState();

    context.read<HomePageController>().getTasks();
    bannerAdHelper.initializeAdMob(
      onAdLoaded: (ad) {
        setState(() {
          bannerAdHelper.isBannerAd = true;
        });
      },
    );
  }

  @override
  void dispose() {
    bannerAdHelper.bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var homeController = Provider.of<HomePageController>(context, listen: true);
    return Scaffold(
      floatingActionButton: Consumer<ThemeController>(
        builder: (context, themeController, child) => FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            themeController.playAssetAudio("lib/audio/click.mp3");
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return const AddTaskPage();
            })));
          },
        ),
        // child: FloatingActionButton(
        //   child: const Icon(Icons.add),
        //   onPressed: () {},
        // ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            homeController.switchTheme();
            homeController.themeController
                .playAssetAudio('lib/audio/iron_sound.mp3');
          },
          icon: homeController.loadThemeFromBox()
              ? const Icon(Icons.nightlight_outlined)
              : const Icon(Icons.sunny),
        ),
        actions: const [
          // Padding(
          //   padding: const EdgeInsets.only(right: 3),
          //   child: IconButton(
          //     onPressed: () {
          //       homeController.themeController
          //           .playAssetAudio('lib/audio/click.mp3');
          //       Navigator.pushNamed(context, LangugesPage.LANGPAGE);
          //     },
          //     icon: Image.asset(
          //       "assets/images/lang.png",
          //       height: 25,
          //     ),
          //   ),
          // ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          bannerAdHelper.isBannerAd
              ? SizedBox(
                  height: bannerAdHelper.bannerAd.size.height.toDouble(),
                  width: bannerAdHelper.bannerAd.size.width.toDouble(),
                  child: bannerAdHelper.buildAdWidget(),
                )
              : const SizedBox(),
           const SizedBox(height: 16,),
          const Header(),
          const SizedBox(
            height: 20,
          ),
          // ignore: sized_box_for_whitespace
          // Consumer<HomePageController>(
          //   builder: (context, controller, child) => Container(
          //     margin: const EdgeInsets.only(top: 16),
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     height: 100,
          //     width: MediaQuery.sizeOf(context).width,
          //     child: DatePicker(
          //       DateTime.now(),
          //       locale: "ru",
          //       initialSelectedDate: DateTime.now(),
          //       monthTextStyle: Theme.of(context).textTheme.titleSmall!,
          //       dateTextStyle: Theme.of(context).textTheme.titleMedium!,
          //       dayTextStyle: Theme.of(context).textTheme.titleSmall!,
          //       selectionColor: homeController.loadThemeFromBox()
          //           ? primaryColor
          //           : lightPrimaryColor,
          //      onDateChange: controller.onDateChange,
          //     ),
          //   ),
          // ),

          Expanded(
            child: Consumer<HomePageController>(
              builder: (context, value, child) => ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 2,
                ),
                shrinkWrap: true,
                itemCount: value.taskList.length,
                itemBuilder: (context, index) {
                  Task task = value.taskList[index];

                  if (value.taskList.isNotEmpty) {
                    // NotificationHelper().scheduleNotification(
                    //   hour: timeFormatParser(task.startTime!, 0),
                    //   minutes: timeFormatParser(task.startTime!, 1),
                    //   task: task,
                    // );

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
                      DateFormat.yMd("en").format(value.selectedDate)) {
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
                    //               textStyle:
                    //                   const TextStyle(color: Colors.black, fontSize: 20),
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
