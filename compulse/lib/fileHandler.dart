import 'package:compulse/statusTile.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'statusTile.dart';

Future<List<StatusTile>> read(Function f) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/reminderTiles.txt');
  List<StatusTile> list = <StatusTile>[];
  if (await file.exists()) {
    List<String> lines = await file.readAsLines();
    for (int i = 0; i < lines.length; i++) {
      Map<String, String> line = Map<String, String>.from(json.decode(lines[i]));
      list.add(StatusTile(taskText: line["taskText"]!, timeDone: line["timeDone"]!, isDone: line["isDone"]!.toLowerCase() == 'true', videoPath: line["videoPath"]!, key: Key(line["taskText"]!), delete: f,));
    }
    return list;
  } else {
    return <StatusTile>[];
  }
    
  
}

write(List<StatusTile> l) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/reminderTiles.txt');
  String s = "";
  for (int i = 0; i < l.length; i++) {
    s += json.encode(l[i].str()) + "\n";
  }
  await file.writeAsString(s);
}