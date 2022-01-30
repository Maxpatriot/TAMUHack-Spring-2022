import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'getVideo.dart';
import 'videoScreen.dart';

const PRIMARY_COLOR = 0xFF2F3B48;
const SECONDARY_COLOR = 0xFFFDF5EB;
const BUTTON_GREEN = 0xFF00C475;

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
            style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Color(BUTTON_GREEN))),
            onPressed: () {
              widget.remove();
            },
            child: Icon(Icons.delete_forever)),
          TextButton(
            style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Color(BUTTON_GREEN))),
            onPressed: () {
              setVideo(!displayVideo);
            },
            child: widget.videoPath == "" ? Icon(Icons.camera_alt) : Icon(Icons.play_arrow)),
            TextButton(
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Color(BUTTON_GREEN))),
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
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Color(BUTTON_GREEN))),
                onPressed: () {
                  widget.remove();
                },
                child: Icon(Icons.delete_forever)),
            TextButton(
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Color(BUTTON_GREEN))),
                onPressed: () {
                  if (widget.videoPath == "") {
                    updateVideo(widget.taskText);
                  } else {
                    setVideo(!displayVideo);
                  }
                  
                },
                child: widget.videoPath == "" ? Icon(Icons.camera_alt) : Icon(Icons.play_arrow)),
            TextButton(
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Color(BUTTON_GREEN))),
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
      iconColor: Color(SECONDARY_COLOR),
      collapsedIconColor: Color(SECONDARY_COLOR),
      backgroundColor: Color(PRIMARY_COLOR),
      collapsedBackgroundColor: Color(PRIMARY_COLOR),
      key: widget.key,
      title: Text(widget.taskText, style: TextStyle(color: Color(SECONDARY_COLOR)),),
      subtitle: Text(widget.timeDone, style: TextStyle(color: Color(SECONDARY_COLOR)),),
      children: expand(),
    );
}
}

