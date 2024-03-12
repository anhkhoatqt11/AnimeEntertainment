import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Text('profile'),
            ElevatedButton(
                onPressed: () {
                  AuthApi.signOut(context);
                },
                child: Text('LOGOUT'))
          ],
        ));
  }
}
