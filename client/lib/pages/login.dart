import 'dart:convert';

import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              var result = await AuthApi.login(context, "0123456789", "123");
              setState(() {
                textting = "hehe";
              });
            },
            child: Text('Sign in'))
      ]),
    ));
  }
}

class LoginOrProfileComponent extends StatefulWidget {
  const LoginOrProfileComponent({super.key});

  @override
  State<LoginOrProfileComponent> createState() =>
      _LoginOrProfileComponentState();
}

class _LoginOrProfileComponentState extends State<LoginOrProfileComponent> {
  @override
  Widget build(BuildContext context) {
    return Provider.of<UserProvider>(context)
                .user
                .authentication['sessionToken'] !=
            ""
        ? Container(
            child: Text("Logout"),
          )
        : Container(
            child: ElevatedButton(
                onPressed: () async {
                  await AuthApi.login(context, "antonio@gmail.com", "123");
                },
                child: Text('Log in')),
          );
  }
}
