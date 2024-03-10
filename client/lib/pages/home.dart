import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/services/user_api.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.black87,
        child: Column(children: [
          ElevatedButton(
              onPressed: () async {
                var pdata = {
                  "name": "User1",
                  "phoneNumber": "01234",
                  "total": "10",
                  "payed": "1",
                  "debt": "0"
                };
                await Api.addUser(pdata);
              },
              child: Text("CREATE")),
          ElevatedButton(
              onPressed: () async {
                var res =
                    await ComicsApi.getChapterComic("65ec601305c5cb2ad67cfb37");
                print('result');
                print(res);
              },
              child: Text("READ")),
          ElevatedButton(onPressed: () async {}, child: Text("UPDATE")),
          ElevatedButton(onPressed: () async {}, child: Text("DELETE")),
        ]),
      ),
    );
  }
}
