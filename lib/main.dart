import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sql_db/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(
    [
      'en',
      'ru',
      'uk',
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: locale,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme:
              GoogleFonts.ptSerifCaptionTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.green,
        ),
        home: const HomePage(),
      ),
    );
  }
}
