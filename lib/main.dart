import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:piano_looper/screens/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    return MaterialApp(
      title: 'Piano Looper',
      theme: ThemeData(
        primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyHomePage(),
    );
  }
}
