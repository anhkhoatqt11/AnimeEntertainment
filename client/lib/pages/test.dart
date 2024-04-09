import 'package:anime_and_comic_entertainment/components/animes/WatchingHistoriesList.dart';
import 'package:anime_and_comic_entertainment/components/comic/TopRankingComic.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/components/ui/DonateBannerHome.dart';
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
              onPressed: () async {
                AuthApi.login(context, '+84979683590', 'Dangthaison@123');
              },
              child: Text('login')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DonateBannerHome(
              urlAsset: 'assets/images/donate1.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DonateBannerHome(
              urlAsset: 'assets/images/donate2.png',
            ),
          ),
          GradientButton(
              content: "content",
              action: () {},
              height: 60,
              width: 100,
              disabled: false)
        ]),
      );
    }));
  }
}
