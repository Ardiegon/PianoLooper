import 'package:flutter/material.dart';
import 'package:piano_looper/piano/player.dart';
import 'package:audioplayers/audioplayers.dart';


class WhitePianoTile extends StatefulWidget {
  WhitePianoTile(this.soundName, this.lib, {super.key}){
    player = AudioPlayer();
  }

  final String soundName;
  final SoundsLib lib;
  late final AudioPlayer player;

  @override
  State<WhitePianoTile> createState() => _WhitePianoTileState();

}

class _WhitePianoTileState extends State<WhitePianoTile>{
  ColorFilter _filter = const ColorFilter.mode(Colors.white, BlendMode.darken);

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
        stopSound(widget.player);
        playSound(widget.player, widget.lib, widget.soundName);
        _keyTapped();
      },
      onTapUp: (TapUpDetails details){
        stopSoundDelay(widget.player);
        _keyReleased();
      },
      onTapCancel: (){
        stopSoundDelay(widget.player);
        _keyReleased();
      },
      child: SizedBox(
        width: 100,
        height: 410,
        child: ColorFiltered(
          colorFilter: _filter,
          child:Image.asset(
            'assets/piano_white.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class BlackPianoTile extends StatefulWidget {
  BlackPianoTile(this.soundName, this.lib, {super.key}){
    player = AudioPlayer();
  }

  final String soundName;
  final SoundsLib lib;
  late final AudioPlayer player;


  @override
  State<BlackPianoTile> createState() => _BlackPianoTileState();
}

class _BlackPianoTileState extends State<BlackPianoTile>{
  ColorFilter _filter = const ColorFilter.mode(Colors.white, BlendMode.modulate);

  void _keyTapped() {
    setState(() {
      _filter = const ColorFilter.mode(Colors.black87, BlendMode.modulate);
    });
  }

  void _keyReleased() {
    setState(() {
      _filter = const ColorFilter.mode(Colors.white, BlendMode.modulate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        stopSound(widget.player);
        playSound(widget.player, widget.lib, widget.soundName);
        _keyTapped();
      },
      onTapUp: (TapUpDetails details){
        stopSoundDelay(widget.player);
        _keyReleased();
      },
      onTapCancel: (){
        stopSoundDelay(widget.player);
        _keyReleased();
      },
      child: SizedBox(
        width: 50,
        height: 250,
        child: ColorFiltered(
          colorFilter: _filter,
          child:Image.asset(
            'assets/piano_black.png',
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
      list.add(WhitePianoTile(element, lib));
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
            child: BlackPianoTile(SoundsLib.blackNamesList[i], lib),
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