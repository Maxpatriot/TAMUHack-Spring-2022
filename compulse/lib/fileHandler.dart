import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

Future<List<Map<String, String>>> read() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/reminder_tile.txt');
  if (await file.exists()) {
    List<Map<String, String>> list = <Map<String, String>>[];
    file.readAsLines().then((lines) =>
      lines.forEach((l) => list.add(Map<String, String>.from(json.decode(l))))
    );
    print(list);
    return list;
  }
  return <Map<String, String>>[];
}

write(List<Map<String, String>> l) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/reminder_tile.txt');
  String s = "";
  for (int i = 0; i < l.length; i++) {
    s += json.encode(l[i]) + "\n";
  }
  await file.writeAsString(s);
}