import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert' show utf8;

class getFileApp extends StatefulWidget {
  const getFileApp({ Key? key }) : super(key: key);

  @override
  _getFileAppState createState() => _getFileAppState();
}

class _getFileAppState extends State<getFileApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
} 

Future<XFile?> recordVideo(){
  return ImagePicker().pickVideo(source: ImageSource.camera, maxDuration: const Duration(seconds: 10));
}

Future<String> recordToDisk(String name) async {
  XFile? videoFile = await ImagePicker().pickVideo(source: ImageSource.camera, maxDuration: const Duration(seconds: 10));
  final directory = await getApplicationDocumentsDirectory();

  videoFile?.saveTo(directory.path);
  return (directory.path);
}

class ThumbnailRequest {
  final String video;
  final String thumbnailPath;
  final ImageFormat imageFormat;
  final int maxHeight;
  final int maxWidth;
  final int timeMs;
  final int quality;

  const ThumbnailRequest({
    required this.video,
    required this.thumbnailPath,
    required this.imageFormat,
    required this.maxHeight,
    required this.maxWidth,
    required this.timeMs,
    required this.quality});
}

class ThumbnailResult {
  final Image image;
  final int dataSize;
  final int height;
  final int width;
  const ThumbnailResult({required this.image, required this.dataSize, required this.height, required this.width});
}

Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
  //WidgetsFlutterBinding.ensureInitialized();
  Uint8List bytes;
  final Completer<ThumbnailResult> completer = Completer();
  // ignore: unnecessary_null_comparison
  if (r.thumbnailPath != null) {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: r.video,
        thumbnailPath: r.thumbnailPath,
        imageFormat: r.imageFormat,
        maxHeight: r.maxHeight,
        maxWidth: r.maxWidth,
        timeMs: r.timeMs,
        quality: r.quality);

    print("thumbnail file is located: $thumbnailPath");

    final file = File(thumbnailPath!);
    bytes = file.readAsBytesSync();
  } else {
    bytes = (await VideoThumbnail.thumbnailData(
        video: r.video,
        imageFormat: r.imageFormat,
        maxHeight: r.maxHeight,
        maxWidth: r.maxWidth,
        timeMs: r.timeMs,
        quality: r.quality))!;
  }

  int _imageDataSize = bytes.length;
  debugPrint("image size: $_imageDataSize");

  final _image = Image.memory(bytes);
  _image.image
      .resolve(const ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
    completer.complete(ThumbnailResult(
      image: _image,
      dataSize: _imageDataSize,
      height: info.image.height,
      width: info.image.width,
    ));
  }));
  return completer.future;
}