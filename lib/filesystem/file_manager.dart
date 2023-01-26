import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'dart:convert';

import 'package:piano_looper/filesystem/recorder.dart';



Future<String> _localPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<io.File> _localFile(String name) async {
  final path = await _localPath();
  return io.File('$path/$name.txt');
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

