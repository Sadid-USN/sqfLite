import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LangugesPage extends StatefulWidget {
  const LangugesPage({Key? key}) : super(key: key);

  @override
  State<LangugesPage> createState() => _LangugesPageState();
}

class _LangugesPageState extends State<LangugesPage> {
  // @override
  // void initState() {
  //   Locales.init(['en', 'ru']);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText('Language'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('🇺🇸 English'),
            onTap: () => LocaleNotifier.of(context)!.change('en'),
          ),
          ListTile(
            title: const Text('🇺🇦 Український'),
            onTap: () => LocaleNotifier.of(context)!.change('uk'),
          ),
          ListTile(
            title: const Text('🇸🇦 العربية'),
            onTap: () => LocaleNotifier.of(context)!.change('ar'),
          ),
          ListTile(
            title: const Text('🇷🇺 Руский'),
            onTap: () => LocaleNotifier.of(context)!.change('ru'),
          ),
          // ListTile(
          //   title: const Text('🇹🇯 Тоҷикӣ'),
          //   onTap: () => LocaleNotifier.of(context)!.change('tg'),
          // ),
        ],
      ),
    );
  }
}
