import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {
  final String fileName;
  final String format;
  FileManager({required this.fileName, this.format = "json"});

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

 

  Future<File> get localFile async {
    final path = await _localPath;
    return File('$path/$fileName.$format');
  }

  Future<String> readData() async {
    final file = await localFile;

    // Read the file
    final contents = file.readAsString();

    return contents;
  }

  Future<File> writedata(String data) async {
    final file = await localFile;

    // Write the file
    return file.writeAsString(data);
  }

   Future<File> writedataExternal(String data) async {
    final file = await localFile;

    // Write the file
    return file.writeAsString(data);
  }
}
