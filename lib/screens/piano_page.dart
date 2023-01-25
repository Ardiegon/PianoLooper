import 'package:flutter/material.dart';
import 'package:piano_looper/piano/keyboard.dart';
import 'package:piano_looper/filesystem/file_manager.dart';
import 'package:tuple/tuple.dart';
import 'package:piano_looper/filesystem/recorder.dart';
import 'dart:convert';


List<Tuple3<int, double, double>> structure = [const Tuple3(1,2.0,2.0), const Tuple3(13,4.0,1.0)];

class PianoPage extends StatefulWidget {
  PianoPage({super.key});

  @override
  State<PianoPage> createState() => _PianoPageState();
}

class _PianoPageState extends State<PianoPage> {

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
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.extended(
              onPressed: () {
                print("Record");
                Recording record = getSampleRecording();
                print(record.toJson());
                const JsonEncoder encoder = JsonEncoder();
                String encoded = encoder.convert(record.toJson());
                print(encoded);

                fsWriteRecording(record, name: "rec");
                fsWriteString("Hello");
              },
              label: const Text('Record'),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                print("Play");
                () async {
                  String message = await fsReadString();
                  Map json = await fsReadRecording(name: "rec");
                  Recording record = Recording.fromJson(json);
                  print(record.toJson());
                  print(message);
                } ();
              },
              label: const Text('Play'),
            ),
          ]),
            FloatingActionButton.extended(
            onPressed: () {
              Navigator.pop(context);
            },
            label: const Text('Home'),
            ),
            Container(
                margin: const EdgeInsets.all(50.0),
                child: PianoKeyboard()
            ),
          ],
        )
      ),
    );
  }
}
