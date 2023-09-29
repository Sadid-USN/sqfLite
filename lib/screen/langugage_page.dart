import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sql_db/controllers/home_page_controller.dart';
import 'package:sql_db/controllers/theme_controller.dart';
import 'package:sql_db/generated/l10n.dart';

class LangugesPage extends StatelessWidget {
  const LangugesPage({Key? key}) : super(key: key);

  static String LANGPAGE = '/langugesPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        leading: IconButton(
          onPressed: () {
            context
                .read<ThemeController>()
                .playAssetAudio('lib/audio/iron_sound.mp3');
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(S.of(context).language,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontSize: 24, color: Colors.white)),
        centerTitle: true,
      ),
      body: Consumer<HomePageController>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            LangButton(
              title: "🇺🇸 English",
              onPressed: () {
                context
                    .read<ThemeController>()
                    .playAssetAudio('lib/audio/goback_sound.mp3');
                value.onLanguageChanged("en");

                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            LangButton(
              title: '🇷🇺  Русский',
              onPressed: () {
                context
                    .read<ThemeController>()
                    .playAssetAudio('lib/audio/goback_sound.mp3');
                value.onLanguageChanged("ru");
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            // LangButton(
            //   title: '🇹🇯  Тоҷики',
            //   onPressed: () {
            //     // context.setLocale(const Locale('fr'));

            //     Navigator.of(context)
            //         .pushNamedAndRemoveUntil('/', (route) => false);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class LangButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const LangButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ElevatedButton(
        onPressed:
            onPressed, // This child can be everything. I want to choose a beautiful Text Widget
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 50),
          shadowColor: Colors.grey,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          tapTargetSize: MaterialTapTargetSize.padded,
        ),
        child: Text(
          title,
          style: GoogleFonts.ptSerif(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
