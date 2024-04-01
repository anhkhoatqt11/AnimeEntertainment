import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:flutter/material.dart';

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
                var res = await AnimesApi.getAnimeDetailInEpisodePageById(
                    context, "65fbe3717e4914bdd8125052");
                // print(res[0].episodeName);
              },
              child: const Text("Text"))
        ]),
      ),
    );
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
