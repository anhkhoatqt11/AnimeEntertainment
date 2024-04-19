import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_detail.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
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
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color(0xFF141414),
        child: ListView(children: [
          ElevatedButton(
              onPressed: () async {
                var result = await AnimesApi.checkUserHistoryHadSeenEpisode(
                    context,
                    "65ffea9c65ac19bed872183c",
                    "65f709463fafb1d0bdce1bb0");
                print(result);
                if (result['position'] != null) {
                  print(result['position']);
                }
              },
              child: Text("test")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailComicPage(comicId: "65ec601305c5cb2ad67cfb37"),
                  ),
                );
              },
              child: const Text("Detail comic")),
        ]),
      ),
    ));
  }
}

  // ElevatedButton(
  //             onPressed: () async {
  //               var pdata = {
  //                 "name": "User1",
  //                 "phoneNumber": "01234",
  //                 "total": "10",
  //                 "payed": "1",
  //                 "debt": "0"
  //               };
  //               await Api.addUser(pdata);
  //             },
  //             child: Text("CREATE")),
  //         ElevatedButton(
  //             onPressed: () async {
  //               // var res =
  //                   // await ComicsApi.getChapterComic("65ec601305c5cb2ad67cfb37");
  //             },
  //             child: Text("READ")),
  //         ElevatedButton(onPressed: () async {}, child: Text("UPDATE")),
  //         ElevatedButton(onPressed: () async {}, child: Text("DELETE")),
