import 'package:flutter/material.dart';
import 'fileHandler.dart';

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
  late List<int> _items = <int>[];

  _addItem(int i) {
    setState(() {
      _items.add(i);
      print(_items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Color(PRIMARY_COLOR),
            backgroundColor: Color(SECONDARY_COLOR)),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("CheckUp"),
          ),
          body: FutureBuilder<dynamic>(
              future: read(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  _items = snapshot.data!.toList();
                  return ReorderableListView(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    children: <Widget>[
                      for (int index = 0; index < _items.length; index++)
                        ExpansionTile(
                          key: Key('$index'),
                          title: Text('Item ${_items[index]}'),
                        ),
                    ],
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final int item = _items.removeAt(oldIndex);
                        _items.insert(newIndex, item);
                      });
                      write(_items);
                    },
                  );
                } else {
                  return ReorderableListView(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    children: <Widget>[
                      for (int index = 0; index < _items.length; index++)
                        ListTile(
                          key: Key('$index'),
                          title: Text('Item ${_items[index]}'),
                        ),
                    ],
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final int item = _items.removeAt(oldIndex);
                        _items.insert(newIndex, item);
                      });
                      write(_items);
                    },
                  );
                }
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: _addItem(1),
            tooltip: "Add Item",
            child: const Icon(Icons.add),
          ),
        ));
  }
}
