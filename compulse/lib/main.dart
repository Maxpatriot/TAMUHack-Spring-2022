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
  late Future<List<int>> _listFuture;

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

  Future<List<int>> updateList() async {
    return await read();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
        future: _listFuture,
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
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
          final List<int> items = snapshot.data!.toList();
          return MaterialApp(
            theme: ThemeData(
                primaryColor: Color(PRIMARY_COLOR),
                backgroundColor: Color(SECONDARY_COLOR)),
            home: Scaffold(
              appBar: AppBar(
                title: const Text("CheckUp"),
              ),
              body: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    key: Key('$index'),
                    title: Text("List $index"),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  items.add(1);
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
