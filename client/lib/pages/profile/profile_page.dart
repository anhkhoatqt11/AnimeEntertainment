import 'package:anime_and_comic_entertainment/pages/auth/login.dart';
import 'package:anime_and_comic_entertainment/providers/video_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF141414),
        appBar: GFAppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF141414),
          title: const Text(
            "Profile",
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
          ),
        ),
        body: Container(
            color: Colors.yellow,
            child: Column(
              children: [
                LoginOrProfileComponent(),
                ElevatedButton(
                    onPressed: () async {
                      await AuthApi.register(context, '1234557890', '123');
                    },
                    child: Text("Sign up")),
                ElevatedButton(onPressed: () {}, child: Text("forward")),
                ElevatedButton(onPressed: () {}, child: Text("print"))
              ],
            )));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: Text('Log in')),
          );
  }
}
