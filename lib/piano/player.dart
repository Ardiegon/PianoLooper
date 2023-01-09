import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

const int additionalOffsetCut = 15000;

playSound(String soundName) async {
  AudioPlayer player = AudioPlayer();
  return await player.play(BytesSource(SoundsLib().soundBytes[soundName]!));
}

class SoundsLib{
  SoundsLib._create();

  static late final SoundsLib _singleton;

  factory SoundsLib() {
    return _singleton;
  }

  static Future<SoundsLib> initialize() async {

    // Call the private constructor
    var component = SoundsLib._create();

    for (var i = 0; i < 24; i++) {
      ByteData bytes = await rootBundle.load("assets/audio/key${i+1}.mp3");
      component.soundBytes.putIfAbsent((whiteNamesList + blackNamesList)[i], () => bytes.buffer.asUint8List(bytes.offsetInBytes+additionalOffsetCut, bytes.lengthInBytes-additionalOffsetCut));
    }

    // Return the fully initialized object
    _singleton = component;
    initialized = true;
    return component;

  }

  static const List<String> whiteNamesList = ['0c', '0d', '0e', '0f', '0g', '0a', '0h', '1c', '1d', '1e', '1f', '1g', '1a', '1h'];

  static const List<String> blackNamesList = ['0cs', '0ds', '0fs', '0gs', '0as','1cs', '1ds', '1fs', '1gs', '1as'];

  late final Map<String, Uint8List> soundBytes = Map();
  static bool initialized = false;
}