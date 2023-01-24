bool isRecordingStarted = false;
bool isPlaying = false;
FlutterAudioRecorder _recorder;
Recording _recording;
Timer _t;
var recordedAudio;
RecordingStatus _currentStatus = RecordingStatus.Unset;
IconData _recordIcon = Icons.mic_none;
Duration _duration;
Duration _position;

Future _startRecording() async {
  await _recorder.start();
  var current = await _recorder.current();
  setState(() {
    _recording = current;
  });

  _t = Timer.periodic(Duration(milliseconds: 10), (Timer t) async {
    var current = await _recorder.current();
    setState(() {
      _recording = current;
      _t = t;
    });
  });
}

Future _stopRecording() async {
  var result = await _recorder.stop();
  _t.cancel();

  setState(() {
    // _recording = result;
    _recording = new Recording();
  });
  print("_recording.path : ${result.path}");
  setState(() {
    recordedAudio = result.path;
  });
  // Navigator.pushNamed(context, Screen.AudioPostingView.toString(),
  //     arguments: {"audioUrl": result.path});
}