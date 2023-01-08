import 'package:flutter/material.dart';

class AppTextStyles{
    static final mainTitle = TextStyle(fontSize: 30,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = Colors.green[700]!,);
}