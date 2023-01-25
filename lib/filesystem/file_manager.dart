import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;



Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<io.File> get _localFile async {
  final path = await _localPath;
  return io.File('$path/Message.txt');
}

Future<io.File> writeBytes(List<int> data) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsBytes(data);
}

Future<List<int>> readBytes() async {
  try {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsBytes();
    return contents;

  } catch (e) {
    // If encountering an error, return list of 0
    return [0];
  }
}

Future<io.File> fs_write(String message) async {
  final file = await _localFile;

  return file.writeAsString(message);
}

Future<String> fs_read() async {
  try {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();

    return contents;
  } catch (e) {
    // If encountering an error, return 0
    return "";
  }
}

