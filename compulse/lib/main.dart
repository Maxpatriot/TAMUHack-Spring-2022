import 'package:flutter/material.dart';
import 'fileHandler.dart';
import 'statusTile.dart';

const PRIMARY_COLOR = 0xFF2F3B48;
const SECONDARY_COLOR = 0xFFFDF5EB;

void main(List<String> args) {
  runApp(CheckUpApp());
}

class CheckUpApp extends StatefulWidget {
  const CheckUpApp({Key? key}) : super(key: key);

  @override
  _CheckUpAppState createState() => _CheckUpAppState();
}

class _CheckUpAppState extends State<CheckUpApp> {
  int i = 0;
  late Future<List<Map<String, String>>> _listFuture;

  void refreshList() {
    setState(() {
      _listFuture = updateList();
    });
  }

  @override
  void initState() {
    super.initState();
    _listFuture = updateList();
  }

  Future<List<Map<String, String>>> updateList() async {
    return await read();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
        future: _listFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
                home: Scaffold(
                  appBar: AppBar(
                    title: Text("CheckUp"),
                  ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => {},
                tooltip: "Add Item",
                child: const Icon(Icons.add),
              ),
            ));
          }
          final List<Map<String, String>> items = snapshot.data!.toList();
          return MaterialApp(
            theme: ThemeData(
                primaryColor: Color(PRIMARY_COLOR),
                backgroundColor: Color(SECONDARY_COLOR)),
            home: Scaffold(
              appBar: AppBar(
                title: const Text("CheckUp"),
              ),
              body: ReorderableListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  //return ListTile(key: Key(items[index]["taskText"]!), title: Text(items[index]["taskText"]!),);
                  return StatusTile(key: Key(items[index]["taskText"]!), taskText: items[index]["taskText"]!, isDone: items[index]["isDone"]!.toLowerCase() == 'true', timeDone: items[index]["timeDone"]!, videoPath: items[index]["video"]!, update: refreshList,);

                },
                onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final Map<String, String> item = items.removeAt(oldIndex);
                    items.insert(newIndex, item);
                    write(items);
                }
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  items.add({"taskText": "Lock Car $i", "timeDone": "You have not done this", "isDone": "false", "video": ""});
                  i++;
                  write(items);
                  refreshList();
                },
                tooltip: "Add Item",
                child: const Icon(Icons.add),
              ),
            ),
          );
        });
  }
}
