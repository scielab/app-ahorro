import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class SounedSing {
  late Soundpool pool;
  late int soundId;
  SoundpoolOptions soundpoolOptions = const SoundpoolOptions(streamType: StreamType.ring);

  SounedSing() {
    pool = Soundpool.fromOptions();
  }

  Future<int> loadSong() async {
    var asset = await rootBundle.load("assets/sounds/check.mp3");
    return await pool.load(asset);
  }

  Future<void> playSound() async {
    soundId = await loadSong();
    await pool.play(soundId);
  }
}

