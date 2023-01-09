import 'package:flutter/material.dart';
import 'package:piano_looper/piano/player.dart';


class WhitePianoTile extends StatelessWidget {
  const WhitePianoTile(this.soundName, {super.key});
  final String soundName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        playSound(soundName);
      },
      child: SizedBox(
        width: 100,
        height: 410,
        child: Image.asset('assets/piano_white.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class BlackPianoTile extends StatelessWidget {
  const BlackPianoTile(this.soundName, {super.key});
  final String soundName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        playSound(soundName);
      },
      child: SizedBox(
        width: 50,
        height: 250,
        child: Image.asset('assets/piano_black.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PianoKeyboard extends StatelessWidget{
  const PianoKeyboard({super.key});

  List<Widget> gatherWhiteTiles(){
    List<Widget> list = [];
    for (var element in SoundsLib.whiteNamesList) {
      list.add(WhitePianoTile(element));
    }
    return list;
  }
  List<Widget> gatherBlackTiles(){
    List<Widget> list = [];
    var spaceBetween = 25.0;
    for (var i = 0; i < SoundsLib.blackNamesList.length; i++) {
      var additionalLeftMargin = spaceBetween;
      if(i==0){
        additionalLeftMargin = 3*spaceBetween;
      }
      else if([2,5,7].contains(i)){
        additionalLeftMargin = 5*spaceBetween;
      }
      list.add(
          Container(
            margin: EdgeInsets.only(left: additionalLeftMargin, right: spaceBetween),
            child: BlackPianoTile(SoundsLib.blackNamesList[i]),
          )

      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: gatherWhiteTiles()
        ),
        Row(
          children: gatherBlackTiles(),
        ),
      ],
    );
  }
}