import 'package:flutter/material.dart';
import 'package:piano_looper/utils/styles.dart';
import 'package:piano_looper/screens/piano_page.dart';
import 'package:piano_looper/screens/records_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Piano Looper"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
                image: AssetImage('assets/piano.png')
            ),
            Text(
              'Piano Looper',
              style: AppTextStyles.mainTitle
            ),
            SizedBox(
              width: 250.0,
              height: 200.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.extended(
                    heroTag: "btn1",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PianoPage()),
                      );
                    },
                    label: const Text('Piano'),
                  ),
                  FloatingActionButton.extended(
                    heroTag: "btn2",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RecordsPage()),
                      );
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
