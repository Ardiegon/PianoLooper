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

   TextEditingController _textFieldController = TextEditingController();
   String saveName = "";

   Future<void> _saveRecordingDialog(BuildContext context) async {
     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Save record as'),
             content: TextField(
               onChanged: (value) {
                 setState(() {
                   saveName = value;
                 });
               },
               controller: _textFieldController,
               decoration: InputDecoration(hintText: "record name"),
             ),
             actions: <Widget>[
               FloatingActionButton(
                 backgroundColor: Colors.deepOrange,
                 child: Text('Cancel'),
                 onPressed: () {
                   setState(() {
                     Navigator.pop(context);
                   });
                 },
               ),
               FloatingActionButton(
                 child: Text('Save'),
                 onPressed: () {
                   setState(() {
                     fsWriteRecording(recording, name: "saved_" + saveName);
                     Navigator.pop(context);
                   });
                 },
               ),
             ],
           );
         });
   }

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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
              backgroundColor: recordButtonColor,
              onPressed: () {
                if(!isRecording){
                  print("Recording");
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
              onPressed: () {
                _saveRecordingDialog(context);
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
