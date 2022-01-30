import 'package:flutter/material.dart';
import 'fileHandler.dart';
import 'statusTile.dart';
import 'newItemPage.dart';

const PRIMARY_COLOR = 0xFF2F3B48;
const SECONDARY_COLOR = 0xFFFDF5EB;

void main(List<String> args) {
  runApp(CheckUpApp1());
}

class CheckUpApp1 extends StatelessWidget {
  const CheckUpApp1({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const CheckUpApp(),
    );
  }
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

  void addItemList(StatusTile t) async {
    List<StatusTile> s = await _listFuture;
    s.add(t);
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
                  onPressed: () {_awaitAcess(context);},
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
              onPressed: () {_awaitAcess(context);},
              tooltip: "Add Item",
              child: const Icon(Icons.add),
            ),
          ));
        });
  }

  void _awaitAcess(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddListItemRoute(),
      ),
    );
    if (result != null) {

      setState(() {
        addItemList(StatusTile(taskText: result, isDone: false, key: Key(result), timeDone: "Not done yet", videoPath: "", delete: removeItemList,));
      });
    }
  }
}


