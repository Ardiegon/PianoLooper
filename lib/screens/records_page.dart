import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piano_looper/screens/home_page.dart';


class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Records"),
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

