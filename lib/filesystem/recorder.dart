class Sound{
  Sound(this.sound_id, this.time_stamp, this.duration);
  int sound_id;
  double time_stamp;
  double duration;

  Map toJson() => {
    'sound_id': sound_id,
    'time_stamp': time_stamp,
    'duration': duration,
  };
}

class Recording{
  Recording();
  List<Sound> recordingData = [];

  Map toJson() {
    Map<int, Map> jsonBuffor = {};
    for(var i=0; i < recordingData.length; i++){
      jsonBuffor.putIfAbsent(i, () => recordingData[i].toJson());
    }
    return jsonBuffor;
  }

  void add(Sound value){
    recordingData.add(value);
  }
}

Recording getSampleRecording(){
  Recording rec = Recording();
  rec.add(Sound(1, 1.0, 1.0));
  rec.add(Sound(3, 2.0, 1.0));
  rec.add(Sound(5, 3.0, 1.0));
  return rec;
}

