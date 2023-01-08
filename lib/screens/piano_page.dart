import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piano_looper/screens/home_page.dart';


class PianoPage extends StatefulWidget {
  const PianoPage({super.key});

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
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context);
          },
          label: const Text('Home'),
        ),
      ),
    );
  }
}
