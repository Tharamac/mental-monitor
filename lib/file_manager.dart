import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {
  final String fileName;
  FileManager({required this.fileName});

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName.json');
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = file.readAsStringSync();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<File> writedata(String data) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('data');
  }
}
