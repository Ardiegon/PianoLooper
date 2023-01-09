import 'package:flutter/material.dart';
import 'package:piano_looper/piano/keybord.dart';



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
            FloatingActionButton.extended(
            onPressed: () {
              Navigator.pop(context);
            },
            label: const Text('Home'),
            ),
            Container(
                margin: const EdgeInsets.all(50.0),
                child: const PianoKeyboard()
            ),
          ],
        )
      ),
    );
  }
}
