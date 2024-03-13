import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow,
        child: Column(
          children: [
            LoginOrProfileComponent(),
            ElevatedButton(
                onPressed: () async {
                  await AuthApi.register(context, '1234557890', '123');
                },
                child: Text("Sign up"))
          ],
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
            child: ElevatedButton(
                onPressed: () {
                  AuthApi.signOut(context);
                },
                child: Text('LOGOUT')),
          )
        : Container(
            child: ElevatedButton(
                onPressed: () async {
                  await AuthApi.login(context, "0123456789", "123");
                },
                child: Text('Log in')),
          );
  }
}
