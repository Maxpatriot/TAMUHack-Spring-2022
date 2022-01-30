import 'package:flutter/material.dart';

const PRIMARY_COLOR = 0xFF2F3B48;
const SECONDARY_COLOR = 0xFFFDF5EB;
const BUTTON_GREEN = 0xFF00C475;

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
      backgroundColor: Color(PRIMARY_COLOR),
      appBar: AppBar(
        backgroundColor: Color(PRIMARY_COLOR),
        iconTheme: IconThemeData(color: Color(SECONDARY_COLOR)),
        title: const Text('Add New Task', style: TextStyle(color: Color(SECONDARY_COLOR)),),
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
                          style: TextStyle(color: Color(PRIMARY_COLOR)),
                          controller: taskTitleController,
                          decoration: const InputDecoration(
                            fillColor: Color(SECONDARY_COLOR),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(BUTTON_GREEN)),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(BUTTON_GREEN)),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(BUTTON_GREEN)),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            
                            hintText: 'Enter task description',
                          ),
                          autocorrect: false,
                          autofocus: true,
                          validator: isNotEmpty,
                        )),
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(BUTTON_GREEN))),
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