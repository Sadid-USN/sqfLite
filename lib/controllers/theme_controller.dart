import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ThemeController extends ChangeNotifier {
  late AudioPlayer audioPlayer;

  ThemeController() {
    audioPlayer = AudioPlayer();
    audioInit();
  }

  Future<void> audioInit() async {
     audioPlayer = AudioPlayer();
  }

   Future<void> playAssetAudio(String assetPath) async {
  
    await audioPlayer.setAsset(assetPath);
    audioPlayer.seek(Duration.zero);
    audioPlayer.play();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
