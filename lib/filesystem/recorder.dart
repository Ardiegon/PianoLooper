import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:piano_looper/piano/player.dart';

class Sound{
  Sound(this.sound_id, this.time_stamp, this.duration);
  String sound_id;
  int time_stamp;
  int duration;

  Map toJson() => {
    'sound_id': sound_id,
    'time_stamp': time_stamp,
    'duration': duration,
  };
}

class SoundCreator{
  SoundCreator();
  String _sound_id = "";
  int _time_stamp = 0;
  int _duration = 0;
  bool isIdSet = false;
  bool isTimeSet = false;
  bool isDurationSet = false;
  final int additionalDelay = 230;

  void reset(){
    _sound_id = "";
    _time_stamp = 0;
    _duration = 0;
    isIdSet = false;
    isTimeSet = false;
    isDurationSet = false;
  }

  void set soundId(String v){
    _sound_id = v;
    isIdSet = true;
  }
  void set timeStamp(int v){
    _time_stamp = v;
    isTimeSet = true;
  }
  void set duration(int v){
    _duration = v - _time_stamp + additionalDelay;
    isDurationSet = true;
  }

  Sound build(){
    if(isIdSet && isTimeSet && isDurationSet){
      return Sound(_sound_id, _time_stamp, _duration);
    }
    else{
      throw Exception("SoundBuilder had values uninitialized");
    }

  }
}


class Recording{
  Recording();
  List<Sound> recordingData = [];
  int len = 0;

  static Recording fromJson(Map source){
    Recording rec = Recording();

    for(var v in source.values){
      rec.add(Sound(v["sound_id"], v["time_stamp"], v["duration"]));
    }
    return rec;
  }

  Map toJson() {
    Map<String, Map> jsonBuffor = {};
    for(var i=0; i < recordingData.length; i++){
      jsonBuffor.putIfAbsent('$i', () => recordingData[i].toJson());
    }
    return jsonBuffor;
  }

  void add(Sound value){
    recordingData.add(value);
    len++;
  }

  int get duration{
    return recordingData.last.time_stamp + recordingData.last.duration;
  }
}

Recording getSampleRecording(){
  Recording rec = Recording();
  rec.add(Sound('1c', 400, 2000));
  rec.add(Sound('1e', 800, 2000));
  rec.add(Sound('1f', 1200, 2000));
  rec.add(Sound('1g', 1600, 6000));
  rec.add(Sound('0c', 1600, 4000));
  rec.add(Sound('0e', 1600, 4000));
  rec.add(Sound('0g', 1600, 4000));

  return rec;
}


class RecordPlayer{
  RecordPlayer({numPlayers = 10}){
    final SoundsLib lib = SoundsLib();
    _numPlayers = numPlayers;
    soundPlayers = List.generate(numPlayers, (int index) => SoundPlayer(index, this, lib));
    readyPlayers = [];
    for(var v in soundPlayers){
      readyPlayers.add(v);
    }
  }
  late final int _numPlayers;
  int currPlayerId = 0;
  late final List<SoundPlayer> soundPlayers;
  late List<SoundPlayer> readyPlayers;
  final stopwatch = Stopwatch();

  bool arePlayersReady(){
    return readyPlayers.isNotEmpty;
  }

  SoundPlayer getReadyPlayer(){
    SoundPlayer player =  readyPlayers[currPlayerId];
    currPlayerId = (currPlayerId+1) % (readyPlayers.length-1);
    return player;
  }

  void play(Recording source, {sameTimeLen = 10, waitBetween = 30}) async{
    List<Sound> currentSounds = [];
    if(source.len < sameTimeLen){
      sameTimeLen = source.len;
    }
    int recordingPointer = sameTimeLen;
    for(var i = 0; i < sameTimeLen; i++){
      currentSounds.add(source.recordingData[i]);
    }

    stopwatch.start();
    while(currentSounds.isNotEmpty || (readyPlayers.length != _numPlayers && currentSounds.isEmpty)){
      int elapsed = stopwatch.elapsedMilliseconds;
      for(int i = 0; i<currentSounds.length; i++){
        if(currentSounds[i].time_stamp<elapsed && arePlayersReady()){
          getReadyPlayer().play(currentSounds[i]);
          currentSounds.removeAt(i);
          if(recordingPointer < source.len) {
            currentSounds.add(source.recordingData[recordingPointer]);
            recordingPointer++;
          }
        }
      }
      await Future.delayed( Duration(milliseconds: waitBetween));
    }
    print("Recording Player Finished");
  }
}


class SoundPlayer{
  SoundPlayer( int index, RecordPlayer rp, SoundsLib lib){
    playerIndex = index;
    audioPlayer = AudioPlayer();
    recordPlayer = rp;
    soundLib = lib;
  }
  late final playerIndex;
  late final RecordPlayer recordPlayer;
  late final AudioPlayer audioPlayer;
  late final SoundsLib soundLib;

  void play(Sound sound) async {
    recordPlayer.readyPlayers.remove(this);
    playSound(audioPlayer, soundLib, sound.sound_id);
    await stopSoundDelay(audioPlayer, delay: sound.duration);
    recordPlayer.readyPlayers.add(this);
  }
}
