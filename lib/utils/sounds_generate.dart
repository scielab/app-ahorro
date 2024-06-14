import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class GenericSoundPlayer<T> {
  final Soundpool _soundPool = Soundpool.fromOptions(
    //options: SoundPoolConfig(poolCapacity: SoundPoolConfig.MAX_POOLS),
  );
  final Map<T, int> _soundPoolMap = {};

  Future<void> loadSound(T key, String assetPath) async {
    final int soundId = await _soundPool.load(await rootBundle.load(assetPath));
    _soundPoolMap[key] = soundId;
  }

  Future<void> playSound(T key) async {
    if (_soundPoolMap.containsKey(key)) {
      final int soundId = _soundPoolMap[key]!;
      await _soundPool.play(soundId);
    } else {
      throw Exception('El sonido para la clave $key no está cargado');
    }
  }

  Future<void> pauseSound(T key) async {
    if (_soundPoolMap.containsKey(key)) {
      final int soundId = _soundPoolMap[key]!;
      await _soundPool.pause(soundId);
    } else {
      throw Exception('El sonido para la clave $key no está cargado');
    }
  }

  Future<void> stopSound(T key) async {
    if (_soundPoolMap.containsKey(key)) {
      final int soundId = _soundPoolMap[key]!;
      await _soundPool.stop(soundId);
    } else {
      throw Exception('El sonido para la clave $key no está cargado');
    }
  }

  Future<void> dispose() async {
    _soundPool.dispose();
    _soundPoolMap.clear();
  }
}