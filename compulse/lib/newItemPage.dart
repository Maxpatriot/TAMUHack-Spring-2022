import 'package:flutter/material.dart';

class AddListItemRoute extends StatelessWidget {
  AddListItemRoute({Key? key}) : super(key: key);

  final TextEditingController taskTitleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _sendDataBack(BuildContext context) {
    Navigator.pop(context, taskTitleController.text);
  }

  String? isNotEmpty(value) {
    if (value.isEmpty) {
      return 'Please enter a value';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      body: Center(
          child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 300.0,
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: taskTitleController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter task description',
                          ),
                          autocorrect: false,
                          autofocus: true,
                          validator: isNotEmpty,
                        )),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _sendDataBack(context);
                        }
                      },
                      child: const Text("Add Task"),
                    )
                  ]))),
    );
  }
}