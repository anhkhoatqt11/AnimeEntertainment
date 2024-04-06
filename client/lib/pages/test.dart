import 'package:anime_and_comic_entertainment/components/animes/WatchingHistoriesList.dart';
import 'package:anime_and_comic_entertainment/components/comic/TopRankingComic.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
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
    return Scaffold(body: Consumer(builder: (context, watch, _) {
      final user = Provider.of<UserProvider>(context).user;
      return Container(
        width: double.infinity,
        color: const Color(0xFF141414),
        child: Column(children: [
          ElevatedButton(
              onPressed: () async {
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
              child: Text('login')),
          user.id != ""
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        "Bạn đang xem",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 160,
                      child: WatchingHistoriesList(
                        userId: user.id,
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ]),
      );
    }));
  }
}
