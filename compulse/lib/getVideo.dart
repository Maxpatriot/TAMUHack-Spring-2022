import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<XFile?> recordVideo(){
  return ImagePicker().pickVideo(source: ImageSource.camera, maxDuration: const Duration(seconds: 10));
}

Future<String> recordToDisk(String name) async {
  XFile? videoFile = await ImagePicker().pickVideo(source: ImageSource.camera, maxDuration: const Duration(seconds: 10));
  final directory = await getApplicationDocumentsDirectory();

  videoFile?.saveTo(directory.path + "/$name.max");
  return (directory.path + "/$name.max");
}