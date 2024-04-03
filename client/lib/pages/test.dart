import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.blue,
        child: Column(children: [
          ElevatedButton(
              onPressed: () async {
                var userId =
                    Provider.of<UserProvider>(context, listen: false).user.id;
                print(userId == "" ? "not" : "oke");
                if (userId == "") return;
                // var userId =
                //     Provider.of<UserProvider>(context, listen: false).user.id;
                // if (userId == "") {
                //   print("chua dang nhap");
                //   return;
                // }
                // ;
                // var result = await AnimesApi.checkUserHasLikeOrSaveEpisode(
                //     context, "65ffea9c65ac19bed872183c", userId);
                // print(result);
                // AnimesApi.checkUserHasLikeOrSaveEpisode(context,
                //     "65ffea9c65ac19bed872183c", "65ec67ad05c5cb2ad67cfb3f");
              },
              child: Text("test")),
          ElevatedButton(
              onPressed: () async {
                AuthApi.login(context, '+84979683590', 'Dangthaison@123');
              },
              child: Text('login'))
        ]),
      ),
    );
  }
}
