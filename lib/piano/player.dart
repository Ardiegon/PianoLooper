import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:audioplayers/audioplayers.dart';

const int additionalOffsetCut = 20000;

playSound(AudioPlayer player, SoundsLib lib,  String soundName) async {
  return await player.play(BytesSource(lib.soundBytes[soundName]!));
}

stopSoundDelay(AudioPlayer player, {int delay = 230}) async {
  await Future.delayed( Duration(milliseconds: delay));
  await player.stop();
}

stopSound(AudioPlayer player) async {
  await player.stop();
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
      component.soundBytes.putIfAbsent((allSoundsOrdered)[i], () => bytes.buffer.asUint8List(bytes.offsetInBytes+additionalOffsetCut, bytes.lengthInBytes-additionalOffsetCut));
    }

    // Return the fully initialized object
    _singleton = component;
    initialized = true;
    return component;

  }

  static const List<String> allSoundsOrdered = ['0c', '0cs', '0d', '0ds', '0e', '0f',
    '0fs', '0g', '0gs', '0a', '0as', '0h',
    '1c', '1cs', '1d', '1ds', '1e', '1f',
    '1fs', '1g', '1gs', '1a', '1as', '1h'];

  static const List<String> whiteNamesList = ['0c', '0d', '0e', '0f', '0g', '0a', '0h', '1c', '1d', '1e', '1f', '1g', '1a', '1h'];

  static const List<String> blackNamesList = ['0cs', '0ds', '0fs', '0gs', '0as','1cs', '1ds', '1fs', '1gs', '1as'];

  static  Map<String, int> mapSoundsToNumbers = Map.fromIterables(allSoundsOrdered, List<int>.generate(24, (i) => i + 1));

  late final Map<String, Uint8List> soundBytes = Map();
  static bool initialized = false;
}