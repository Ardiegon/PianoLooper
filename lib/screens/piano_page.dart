import 'package:flutter/material.dart';
import 'package:piano_looper/piano/keyboard.dart';
import 'package:piano_looper/filesystem/file_manager.dart';
import 'package:tuple/tuple.dart';
import 'package:piano_looper/filesystem/recorder.dart';
import 'dart:convert';


class PianoPage extends StatefulWidget {
  PianoPage({super.key});

  @override
  State<PianoPage> createState() => _PianoPageState();
}

class _PianoPageState extends State<PianoPage> {
   bool isPlayingRecord = false;
   bool isRecording = false;
   Recording recording = Recording();
   Stopwatch watch = Stopwatch();
   MaterialColor playButtonColor = Colors.green;
   MaterialColor recordButtonColor = Colors.green;

   void playRecord(Recording record) async{
     isPlayingRecord = true;
     RecordPlayer recPlayer = RecordPlayer();
     recPlayer.play(record);
   }

   void record(){
     setState(() {
       isRecording = true;
       recordButtonColor = Colors.deepOrange;
       recording = Recording();
       watch.reset();
       watch.start();
     });
   }

   void stopRecording(){
     setState(() {
       isRecording = false;
       recordButtonColor = Colors.green;
       watch.stop();
     });
   }

   void changePlayButtonColor(MaterialColor color){
     setState(() {
       playButtonColor = color;
     });;
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Piano"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
            onPressed: () {
              Navigator.pop(context);
            },
            label: const Text('Home'),
          ),
          Container(
            height: 50,
          ),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            FloatingActionButton.extended(
              onPressed: () {
                if(!isRecording){
                  record();
                }
                else{
                  stopRecording();
                  print(recording.toJson());
                  fsWriteRecording(recording, name: "rec");
                }

              },
              label: const Text('Record'),
            ),
            FloatingActionButton.extended(
              backgroundColor: playButtonColor,
              onPressed: () {
                if(!isPlayingRecord) {
                  print("Play");
                  changePlayButtonColor(Colors.deepOrange);
                      () async {
                    Map json = await fsReadRecording(name: "rec");
                    Recording record = Recording.fromJson(json);
                    playRecord(record);
                    await Future.delayed(Duration(milliseconds: record
                        .duration));
                    changePlayButtonColor(Colors.green);
                    isPlayingRecord = false;
                  }();
                }
              },
              label: const Text('Play'),
            ),
            FloatingActionButton.extended(
              onPressed: () {
              },
              label: const Text('Save'),
            ),
          ]),
            Container(
                margin: const EdgeInsets.all(50.0),
                child: PianoKeyboard(isRecording, recording, watch)
            ),
          ],
        )
      ),
    );
  }
}
