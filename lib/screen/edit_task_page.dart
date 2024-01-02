import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sql_db/controllers/home_page_controller.dart';
import 'package:sql_db/controllers/theme_controller.dart';
import 'package:sql_db/core/addbunner_helper.dart';
import 'package:sql_db/core/unfocus_scope.dart';
import 'package:sql_db/generated/l10n.dart';
import 'package:sql_db/models/task_model.dart';
import 'package:sql_db/widget/color_palet.dart';
import 'package:sql_db/widget/custom_field.dart';

class EditTaskPage extends StatefulWidget {
  static const EDITPAGE = '/editTaskPage';

  final Task? task;
  const EditTaskPage({
    Key? key,
    this.task,
  }) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
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
    if (widget.task != null) {
      homeController.titleEditingController.text = widget.task!.title ?? '';
      homeController.noteEditingController.text = widget.task!.note ?? '';
      // Assign other properties of the task to corresponding controllers or variables
    }
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
            key: homeController.editPageformKey,
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
                  
                  S.of(context).uddateTask,
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
                  title: S.of(context).task,
                  hintText: S.of(context).enterNoteHere,
                ),
                
              
                const SizedBox(
                  height: 12,
                ),
                ColorPalet(
                  task: widget.task!,
                ),
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
