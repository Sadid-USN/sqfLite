import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sql_db/controllers/home_page_controller.dart';
import 'package:sql_db/controllers/theme_controller.dart';
import 'package:sql_db/core/addbunner_helper.dart';
import 'package:sql_db/core/unfocus_scope.dart';
import 'package:sql_db/generated/l10n.dart';
import 'package:sql_db/widget/color_palet.dart';
import 'package:sql_db/widget/custom_field.dart';

class AddTaskPage extends StatefulWidget {
  static const ADDPAGE = '/addtaskpage';
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  BannerAdHelper bannerAdHelper = BannerAdHelper();
  @override
  void initState() {
    super.initState();

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
    var homeController = Provider.of<HomePageController>(context);
    var themeController = Provider.of<ThemeController>(context);

    var dateFormat = DateFormat('M/d/yyyy').format(homeController.selectedDate);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            themeController.playAssetAudio("lib/audio/iron_sound.mp3");
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
          child: Form(
            key: homeController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bannerAdHelper.isBannerAd
                    ? SizedBox(
                        height: bannerAdHelper.bannerAd.size.height.toDouble(),
                        width: bannerAdHelper.bannerAd.size.width.toDouble(),
                        child: AdWidget(ad: bannerAdHelper.bannerAd),
                      )
                    : const SizedBox(),
                Text(
                  S.of(context).addNewTask,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                CustomField(
                  controller: homeController.titleEditingController,
                  title: S.of(context).title,
                  hintText: S.of(context).enterTitleHere,
                ),
                CustomField(
                  isNote: true,
                  controller: homeController.noteEditingController,
                  title: S.of(context).addTask,
                  hintText: S.of(context).enterNoteHere,
                ),
                CustomField(
                  title: S.of(context).date,
                  hintText: dateFormat,
                  widget: IconButton(
                    onPressed: () {
                      homeController.getDateFormat(context);
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomField(
                      width: MediaQuery.of(context).size.width / 2.3,
                      title: S.of(context).startTime,
                      hintText: homeController.startTime,
                      widget: IconButton(
                        onPressed: () {
                          homeController.getTimeFromUser(
                              isStartTime: true, context: context);
                        },
                        icon: const Icon(Icons.access_time_rounded),
                      ),
                    ),
                    CustomField(
                      width: MediaQuery.of(context).size.width / 2.3,
                      title: S.of(context).endTime,
                      hintText: homeController.endTime,
                      widget: IconButton(
                        onPressed: () {
                          homeController.getTimeFromUser(
                              isStartTime: false, context: context);
                        },
                        icon: const Icon(Icons.access_time_rounded),
                      ),
                    ),
                  ],
                ),
                // CustomField(
                //   title: S.of(context).reminder,
                //   hintText: S.of(context).selectedremaindMinutesEarly(
                //       homeController.selectedRemaind),
                //   widget: Padding(
                //       padding: const EdgeInsets.only(right: 8),
                //       child: DropdownButton<String>(
                //         underline: const SizedBox(),
                //         icon: const Icon(Icons.keyboard_arrow_down),
                //         elevation: 4,
                //         items: homeController.reminList
                //             .map<DropdownMenuItem<String>>((int element) {
                //           return DropdownMenuItem<String>(
                //             value: element.toString(),
                //             child: Text(element.toString()),
                //           );
                //         }).toList(),
                //         onChanged: homeController.onRemaindChanged,
                //       )),
                // ),
               
                // CustomField(
                //   title: 'Повторить',
                //   hintText: homeController.selectedRepeat,
                //   widget: Padding(
                //     padding: const EdgeInsets.only(right: 8),
                //     child: DropdownButton<String>(
                //       underline: const SizedBox(),
                //       icon: const Icon(Icons.keyboard_arrow_down),
                //       elevation: 4,
                //       items: homeController.repeatList
                //           .map<DropdownMenuItem<String>>((String repeat) {
                //         return DropdownMenuItem<String>(
                //           value: repeat,
                //           child: Text(
                //             repeat,
                //           ),
                //         );
                //       }).toList(),
                //       onChanged: homeController.onRepeatChanged,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 12,
                ),
                const ColorPalet(),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    ).unfocusScope(context);
  }
}
