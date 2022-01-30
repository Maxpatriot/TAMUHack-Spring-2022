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
  late Future<List<StatusTile>> _listFuture;

  void removeItemList(StatusTile t) async {
    List<StatusTile> s = await _listFuture;
    s.remove(t);
    write(s);
    refreshList();
  }

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

  Future<List<StatusTile>> updateList() async {
    return await read(removeItemList);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StatusTile>>(
        future: _listFuture,
        builder:
            (BuildContext context, AsyncSnapshot<List<StatusTile>> snapshot) {
          if (snapshot.hasData) {
            final List<StatusTile> items = snapshot.data!.toList();
            return MaterialApp(
              theme: ThemeData(
                  primaryColor: Color(PRIMARY_COLOR),
                  backgroundColor: Color(SECONDARY_COLOR)),
              home: Scaffold(
                appBar: AppBar(
                  title: const Text("Check-Up"),
                ),
                body: ReorderableListView(
                    children: items,
                    onReorder: (int oldIndex, int newIndex) {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final StatusTile item = items.removeAt(oldIndex);
                      items.insert(newIndex, item);
                      write(items);
                    }),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    items.add(StatusTile(
                      isDone: false,
                      key: Key("Lock Car $i"),
                      taskText: "Lock Car $i",
                      videoPath: "",
                      timeDone: "You have not done this yet",
                      delete: removeItemList,
                    ));
                    i++;
                    write(items);
                    refreshList();
                  },
                  tooltip: "Add Item",
                  child: const Icon(Icons.add),
                ),
              ),
            );
          }
          return MaterialApp(
              home: Scaffold(
            appBar: AppBar(
              title: Text("Check-Up"),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => {},
              tooltip: "Add Item",
              child: const Icon(Icons.add),
            ),
          ));
        });
  }
}
