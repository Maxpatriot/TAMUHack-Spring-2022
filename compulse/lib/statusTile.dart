import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'getVideo.dart';
import 'videoScreen.dart';

class StatusTile extends StatefulWidget {
  final String taskText;
  String timeDone;
  bool isDone;
  String videoPath;
  Key key;
  Function delete;

  StatusTile(
      {required this.taskText,
      required this.isDone,
      required this.key,
      required this.timeDone,
      required this.videoPath,
      required this.delete});

  void remove() {
    delete(this);
  }

  @override
  _StatusTileState createState() => _StatusTileState();

  Map<String, String> str() {
    return <String, String>{
      "taskText": taskText,
      "timeDone": timeDone,
      "isDone": isDone.toString(),
      "videoPath": videoPath
    };
  }
}

class _StatusTileState extends State<StatusTile> {
  var displayVideo = false;

  void setVideo(bool b) {
    setState(() {
      displayVideo = b;
    });
  }

  void updateTime(String s) {
    setState(() {
      widget.timeDone = s;
    });
  }

  void updateVideo(String x) async {
    String s = await recordToDisk(x);
    setState(() {
      widget.videoPath = s;
    });
    debugPrint(widget.videoPath);
  }

  void updateIsDone(bool b) {
    setState(() {
      widget.isDone = b;
    });
  }

  List<Widget> expand() {
    if (displayVideo == true && widget.videoPath != "") {
      return [Column(children: [ButtonBar(
        children: [
          TextButton(
            onPressed: () {
              widget.remove();
            },
            child: Icon(Icons.delete_forever)),
          TextButton(
            onPressed: () {
              setVideo(!displayVideo);
            },
            child: Icon(Icons.camera_alt)),
            TextButton(
              onPressed: () {
                setVideo(false);
                widget.videoPath = "";
                DateTime d = DateTime.now();
                updateTime("Last completed on ${d.month}/${d.day}/${d.year} at ${d.hour}:${d.minute}");
              },
              child: Icon(Icons.check)),
        ],
      alignment: MainAxisAlignment.center,
      ),
      VideoPlayerScreen(widget.videoPath),
      ],
      )
    ];
    } else {
      return [ButtonBar(
          children: [
            TextButton(
                onPressed: () {
                  widget.remove();
                },
                child: Icon(Icons.delete_forever)),
            TextButton(
                onPressed: () {
                  if (widget.videoPath == "") {
                    updateVideo(widget.taskText);
                  } else {
                    setVideo(!displayVideo);
                  }
                  
                },
                child: Icon(Icons.camera_alt)),
            TextButton(
                onPressed: () {
                  setVideo(false);
                  widget.videoPath = "";
                  DateTime d = DateTime.now();
                  updateTime(
                      "Last completed on ${d.month}/${d.day}/${d.year} at ${d.hour}:${d.minute}");
                },
                child: Icon(Icons.check)),
          ],
          alignment: MainAxisAlignment.center,
        )];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: widget.key,
      title: Text(widget.taskText),
      controlAffinity: ListTileControlAffinity.leading,
      subtitle: Text(widget.timeDone),
      children: expand(),
    );
}
}

