import 'package:flutter/material.dart';

abstract class AccessRoute extends StatelessWidget {
  AccessRoute({Key? key}) : super(key: key);
  final TextEditingController usernameController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _sendUsernameBack(BuildContext context) {
    Navigator.pop(context, usernameController.text);
  }

  String? isNotEmpty(value) {
    if (value.isEmpty) {
      return 'Please enter a value';
    }
    return null;
  }
}

class SignupRoute extends AccessRoute {
  SignupRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                          validator: isNotEmpty,
                        )),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _sendUsernameBack(context);
                        }
                      },
                      child: const Text("Sign Up"),
                    )
                  ]))),
    );
  }
}

class LoginRoute extends AccessRoute {
  LoginRoute({Key? key}) : super(key: key);

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
                          _sendUsernameBack(context);
                        }
                      },
                      child: const Text("Log In"),
                    )
                  ])),
        ));
  }
}
