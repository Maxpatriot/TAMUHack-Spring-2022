import 'package:flutter/material.dart';

const PRIMARY_COLOR = 0xFF2F3B48;
const SECONDARY_COLOR = 0xFFFDF5EB;
const BUTTON_GREEN = 0xFF00C475;

class LoginRoute extends StatelessWidget {
  LoginRoute({Key? key}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _sendUsernameBack(BuildContext context, bool isLogin) {
    Navigator.pop(context, [usernameController.text, isLogin]);
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
          title: const Text('Log In', style: TextStyle(color: Color(SECONDARY_COLOR)),),
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
                            controller: usernameController,
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
                              hintText: 'Enter your username',
                            ),
                            autocorrect: false,
                            autofocus: true,
                            validator: isNotEmpty)),
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(BUTTON_GREEN))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _sendUsernameBack(context, true);
                        }
                      },
                      child: const Text("Log In"),
                    ), 
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(BUTTON_GREEN))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _sendUsernameBack(context, false);
                        }
                      },
                      child: const Text("Sign Up"),
                    )
                  ])),
        ));
  }
}