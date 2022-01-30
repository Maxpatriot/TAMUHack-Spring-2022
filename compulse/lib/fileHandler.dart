import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future read() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/reminder_info.txt');
  if (await file.exists()) {
    List<int> listItems = await file.readAsBytes();
    return listItems;
  }
  return <int>[];
}

write(List<int> l) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/reminder_info.txt');
  await file.writeAsBytes(l);
}