import 'dart:ui';

import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'dart:convert';

import 'package:piano_looper/filesystem/recorder.dart';

import 'package:flutter/material.dart';



Future<String> _localPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<List<io.FileSystemEntity>> listAllFiles() async {
  String path = await _localPath();
  List<io.FileSystemEntity> files = io.Directory("$path").listSync();
  return files;
}

Future<io.File> _localFile(String name) async {
  final path = await _localPath();
  return io.File('$path/$name');
}

Future<void> deleteFile(String name) async {
    final file = await _localFile(name);
    await file.delete();
}

Future<io.File> fsWriteBytes(List<int> data, {String name = "bytes"}) async {
  final file = await _localFile(name);

  // Write the file
  return file.writeAsBytes(data);
}

Future<List<int>> fsReadBytes({String name = "bytes"}) async {
  try {
    final file = await _localFile(name);

    // Read the file
    final contents = await file.readAsBytes();
    return contents;

  } catch (e) {
    // If encountering an error, return list of 0
    return [0];
  }
}

Future<io.File> fsWriteRecording(Recording message, {String name = "recording"}) async {
  const JsonEncoder encoder = JsonEncoder();
  String encoded = encoder.convert(message.toJson());
  return fsWriteString(encoded, name: name);
}

Future<Map> fsReadRecording({String name = "recording"}) async {
  String source = await fsReadString(name: name);
  print(source);
  return jsonDecode(source);
}

Future<io.File> fsWriteString(String message, {String name = "messages"}) async {
  final file = await _localFile(name);
  return file.writeAsString(message);
}

Future<String> fsReadString({String name = "messages"}) async {
  try {
    final file = await _localFile(name);

    // Read the file
    final contents = await file.readAsString();

    return contents;
  } catch (e) {
    // If encountering an error, return 0
    return "";
  }
}

Future<List<Widget>> createFileButtons() async{
  List paths = await listAllFiles();
  List<Widget> output = [];

  for(var p in paths){
    String lastPart = p.toString().split("/").last.replaceAll("'", "");
    if(lastPart.contains("saved_")){
      output.add(FileButton(lastPart.replaceAll("saved_", "")));
      print(p.toString());
    }
  }

  return output;
}

class FileButton extends StatefulWidget{
  FileButton(this.name, {super.key});
  late final String name;



  @override
  State<FileButton> createState() => _FileButtonState();
}

class _FileButtonState extends State<FileButton>{

  Future<void> _fileManagerDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(widget.name),
            actions: <Widget>[
              Container(
                width: 70.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    child: const Text('Play',style: TextStyle(fontSize: 10),),
                    onPressed: () {
                      () async {
                        Map json = await fsReadRecording(name: widget.name);
                        Recording record = Recording.fromJson(json);
                        RecordPlayer recPlayer = RecordPlayer();
                        recPlayer.play(record);
                        await Future.delayed(Duration(milliseconds: record
                            .duration));
                        } ();
                        setState(() {
                          Navigator.pop(context);
                        });
                    }
                  ),
                ),
              ),
              Container(
                width: 70.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    child: const Text('Delete',style: TextStyle(fontSize: 10),),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ),Container(
                width: 70.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    child: const Text('Activate',style: TextStyle(fontSize: 10),),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {_fileManagerDialog(context)},
        child: Card(
            child: ListTile(
              title: Text(widget.name)
            )
        ),
    );
  }
  }
