import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class StatusTile extends StatefulWidget {
  final String taskText;
  String timeDone;
  bool isDone;
  String videoPath;
  Key key;
  VoidCallback update;

  StatusTile({required this.taskText, required this.isDone, required this.key, required this.timeDone, required this.videoPath, required this.update});

  @override
  _StatusTileState createState() => _StatusTileState();
}

class _StatusTileState extends State<StatusTile> {
  void updateTime(String s) {
    setState(() {
      widget.timeDone = s;
    });
  }

  void updateVideo(String x) {
    setState(() {
      widget.videoPath = x;
    });
  }

  void updateIsDone(bool b) {
    setState(() {
      widget.isDone = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: widget.key,
      title: Text(widget.taskText),
      controlAffinity: ListTileControlAffinity.leading,
      subtitle: Text(widget.timeDone),
      children: [
        ButtonBar(
          children: [
            TextButton(onPressed: () {}, child: Icon(Icons.delete_forever)),
            TextButton(onPressed: () {}, child: Icon(Icons.camera_alt)),
            TextButton(onPressed: () {
              DateTime d = DateTime.now();
              updateTime("Last completed on ${d.month}/${d.day}/${d.year} at ${d.hour}:${d.minute}");
              widget.update;
            }, child: Icon(Icons.check)),
          ],
          alignment: MainAxisAlignment.center,
        )
      ],
    );
  }
}