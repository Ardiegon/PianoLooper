import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
                image: AssetImage('assets/piano.png')
            ),
            Text(
              'Main Menu',
              style: TextStyle(fontSize: 30,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = Colors.green[700]!,),
            ),
            SizedBox(
              width: 250.0,
              height: 200.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {

                    },
                    label: const Text('Piano'),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {

                    },
                    label: const Text('Recordings'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
