import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key, required this.title});

  final String title;

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Here will be recordings',
            ),
          ],
        ),
      ),
    );
  }
}
