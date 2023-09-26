import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';


import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sql_db/controllers/home_page_controller.dart';
import 'package:sql_db/core/notify_helper.dart';

import 'package:sql_db/screen/home_page.dart';
import 'package:sql_db/core/db_helper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationHelper().initNotification();
  DBHelper.initDB();
  await GetStorage.init();
  await Locales.init(
    [
      'en',
      'ru',
      'uk',
    ],
  );

  runApp(ChangeNotifierProvider(
    create: (context) => HomePageController(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<HomePageController>(context);
    return LocaleBuilder(
        builder: (locale) => MaterialApp(
              localizationsDelegates: Locales.delegates,
              supportedLocales: Locales.supportedLocales,
              locale: locale,
              debugShowCheckedModeBanner: false,
              title: 'Todo app',
              theme: controller.themeData,
              themeMode: controller.themeMode,
              home:  HomePage(context: context,),
            ));
  }
}
