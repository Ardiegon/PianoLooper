// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:piano_looper/piano/player.dart';
import 'package:audioplayers/audioplayers.dart';


class PianoTile extends StatefulWidget {
  PianoTile(this.soundName, this.lib, color, {super.key}){
    player = AudioPlayer();
    helperPlayer = AudioPlayer();
    if(color == 'black'){
      width = 50.0;
      height = 250.0;
      assetsImagePath = 'assets/piano_black.png';
    }
    else if(color == 'white'){
      width = 100.0;
      height = 410.0;
      assetsImagePath = 'assets/piano_white.png';
    }
  }
  final String soundName;
  final SoundsLib lib;
  late final double width;
  late final double height;
  late final String assetsImagePath;
  late final AudioPlayer player, helperPlayer;

  @override
  State<PianoTile> createState() => _PianoTileState();

}

class _PianoTileState extends State<PianoTile>{
  ColorFilter _filter = const ColorFilter.mode(Colors.white, BlendMode.darken);
  bool _helperNeeded = false;


  void _keyTapped() {
    setState(() {
      _filter = const ColorFilter.mode(Colors.black45, BlendMode.darken);
    });
  }

  void _keyReleased() {
    setState(() {
      _filter = const ColorFilter.mode(Colors.white, BlendMode.darken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        if(!_helperNeeded){
          playSound(widget.player, widget.lib, widget.soundName);
          _helperNeeded = true;
        }
        else{
          playSound(widget.helperPlayer, widget.lib, widget.soundName);
          _helperNeeded = false;
        }
        _keyTapped();
      },
      onTapUp: (TapUpDetails details){
        if(_helperNeeded){
          stopSound(widget.helperPlayer);
          stopSoundDelay(widget.player);
        }
        else{
          stopSound(widget.player);
          stopSoundDelay(widget.helperPlayer);
        }
        _keyReleased();
      },
      onTapCancel: (){
        if(_helperNeeded){
          stopSound(widget.helperPlayer);
          stopSoundDelay(widget.player);
        }
        else{
          stopSound(widget.player);
          stopSoundDelay(widget.helperPlayer);
        }
        _keyReleased();
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: ColorFiltered(
          colorFilter: _filter,
          child:Image.asset(
            widget.assetsImagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}


class PianoKeyboard extends StatelessWidget{
  PianoKeyboard({super.key});
  final SoundsLib lib = SoundsLib();

  List<Widget> gatherWhiteTiles(){
    List<Widget> list = [];
    for (var element in SoundsLib.whiteNamesList) {
      list.add(PianoTile(element, lib, 'white'));
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
            child: PianoTile(SoundsLib.blackNamesList[i], lib, 'black'),
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