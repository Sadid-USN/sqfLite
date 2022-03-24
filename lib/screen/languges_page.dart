import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LangugesPage extends StatefulWidget {
  const LangugesPage({Key? key}) : super(key: key);

  @override
  State<LangugesPage> createState() => _LangugesPageState();
}

class _LangugesPageState extends State<LangugesPage> {
  BannerAd? _bannerAd;
  bool isAdLoaded = false;
  @override
  void dispose() {
    _bannerAd!.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-6636812855826330/9145663013',
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
          print('<<<<Banner Ad Loaded>>>');
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(error.message);
        }),
        request: const AdRequest());
    _bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText('Language'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          isAdLoaded
              ? Container(
                  height: _bannerAd!.size.height.toDouble(),
                  width: _bannerAd!.size.width.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                )
              : const SizedBox(),

          const SizedBox(
            height: 20,
          ),
          ListTile(
            title: const Text('🇺🇸 English'),
            onTap: () => LocaleNotifier.of(context)!.change('en'),
          ),
          ListTile(
            title: const Text('🇺🇦 Український'),
            onTap: () => LocaleNotifier.of(context)!.change('uk'),
          ),
          // ListTile(
          //   title: const Text('🇸🇦 العربية'),
          //   onTap: () => LocaleNotifier.of(context)!.change('ar'),
          // ),
          ListTile(
            title: const Text('🇷🇺 Русский'),
            onTap: () => LocaleNotifier.of(context)!.change('ru'),
          ),
        ],
      ),
    );
  }
}
