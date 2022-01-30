import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'statusTile.dart';
import 'dart:convert';

void postInsert(String username, List<StatusTile> l) {
  String data = "";
  for (int i = 0; i < l.length; i++) {
    data += json.encode(l[i].str()) + "\n";
  }
  http.post(
      Uri.parse("https://checkup-cloudsql-api-6fcck7nssq-uc.a.run.app/insert"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'username': username, 'data': data}));
}

Future<List<StatusTile>> getSelect(String username, Function f) async {
  var response = await http.get(
      Uri.parse("https://checkup-cloudsql-api-6fcck7nssq-uc.a.run.app/select")
          .replace(queryParameters: <String, String>{
    "username": username
  }));
print(response.body);

  Map<String, dynamic> result = Map<String, dynamic>.from(json.decode(response.body));

  List<StatusTile> list = <StatusTile>[];
  print(result["Data"]);
  
  List<String> lines = LineSplitter.split(result["Data"]).toList();
  for (int i = 0; i < lines.length; i++) {
    Map<String, String> line = Map<String, String>.from(json.decode(lines[i]));
    list.add(StatusTile(
      taskText: line["taskText"]!,
      timeDone: line["timeDone"]!,
      isDone: line["isDone"]!.toLowerCase() == 'true',
      videoPath: line["videoPath"]!,
      key: Key(line["taskText"]!),
      delete: f,
    ));
  }
  return list;
}

void postUpdate(String username, List<StatusTile> l) {
  String data = "";
  for (int i = 0; i < l.length; i++) {
    data += json.encode(l[i].str()) + "\n";
  }
  http.post(
      Uri.parse("https://checkup-cloudsql-api-6fcck7nssq-uc.a.run.app/update"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'username': username, 'data': data}));
}
