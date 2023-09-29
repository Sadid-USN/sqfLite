import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sql_db/controllers/home_page_controller.dart';
import 'package:sql_db/controllers/theme_controller.dart';
import 'package:sql_db/core/notify_helper.dart';
import 'package:sql_db/generated/l10n.dart';
import 'package:sql_db/languge_box.dart';
import 'package:sql_db/routes/routes.dart';

import 'package:sql_db/screen/home_page.dart';
import 'package:sql_db/core/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  tz.initializeTimeZones();
  DBHelper.initDB();
  await NotificationHelper().initNotification();
  await GetStorage.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HomePageController()),
      ChangeNotifierProvider(create: (context) => ThemeController()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  Locale getLocaleCode() {
    final storedCode = languageBox.read('code');
    if (storedCode != null) {
      return Locale(storedCode);
    } else {
      return WidgetsBinding.instance.platformDispatcher.locale;
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<HomePageController>(context);
    return MaterialApp(
      routes: routes,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale("ru", "RU"),
      debugShowCheckedModeBanner: false,
      title: 'Todo app',
      theme: controller.themeData,
      themeMode: controller.themeMode,
      home: HomePage(
        context: context,
      ),
    );
  }
}
