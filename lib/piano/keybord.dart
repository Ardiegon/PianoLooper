import 'package:flutter/material.dart';
import 'package:piano_looper/piano/player.dart';


class PianoTile extends StatelessWidget {
  const PianoTile(this.soundName, {super.key});
  final String soundName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        playSound(soundName);
      },
      child: SizedBox(
        width: 100,
        height: 400,
        child: Image.asset('assets/piano_white.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PianoKeybord extends StatelessWidget{
  const PianoKeybord({super.key});

  @override

  List<Widget> gatherTiles(){
    List<Widget> list = [];
    for (var element in SoundsLib.whiteNamesList) {
      list.add(PianoTile(element));
    }
    return list;
  }

  Widget build(BuildContext context) {
    return Row(
        children: gatherTiles()
    );
  }
}