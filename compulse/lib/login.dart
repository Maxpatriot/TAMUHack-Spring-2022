import 'package:flutter/material.dart';


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
        appBar: AppBar(
          title: const Text('Log In'),
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
                              border: OutlineInputBorder(),
                              hintText: 'Enter your username',
                            ),
                            autocorrect: false,
                            autofocus: true,
                            validator: isNotEmpty)),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _sendUsernameBack(context, true);
                        }
                      },
                      child: const Text("Log In"),
                    ), 
                    ElevatedButton(
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