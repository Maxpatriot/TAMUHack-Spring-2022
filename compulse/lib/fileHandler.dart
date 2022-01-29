import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<List<int>> read() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/reminder_info.txt');
  List<int> listItems = await file.readAsBytes();
  return listItems;
}

write(List<int> l) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/reminder_info.txt');
  await file.writeAsBytes(l);
}