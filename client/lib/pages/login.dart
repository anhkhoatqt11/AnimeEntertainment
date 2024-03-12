import 'dart:convert';

import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var textting = "hello";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 500,
      height: 500,
      color: Colors.blue,
      child: Column(children: [
        ElevatedButton(
            onPressed: () async {
              await AuthApi.getLogin(context);
            },
            child: Text(textting)),
        ElevatedButton(
            onPressed: () async {
              var result =
                  await AuthApi.login(context, "antonio@gmail.com", "123");
              setState(() {
                textting = "hehe";
              });
            },
            child: Text('Sign in'))
      ]),
    ));
  }
}
