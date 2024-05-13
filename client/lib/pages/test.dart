// ignore_for_file: use_build_context_synchronously

import 'package:anime_and_comic_entertainment/components/animes/WatchingHistoriesList.dart';
import 'package:anime_and_comic_entertainment/components/comic/TopRankingComic.dart';
import 'package:anime_and_comic_entertainment/components/donate/DonatePackageListHome.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/components/ui/DonateBannerHome.dart';
import 'package:anime_and_comic_entertainment/pages/challenge/challenge_page.dart';
import 'package:anime_and_comic_entertainment/pages/search/search_page.dart';
import 'package:anime_and_comic_entertainment/pages/search/search_result_page.dart';
import 'package:anime_and_comic_entertainment/pages/payment.dart';
import 'package:anime_and_comic_entertainment/pages/profile/bookmark_page.dart';
import 'package:anime_and_comic_entertainment/pages/profile/edit_profile_page.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/services/daily_quests_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
            child: Text("Test Search"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChallengePage();
              }));
            },
            child: Text("Test Challenge"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PaymentScreenPage();
              }));
            },
            child: Text("Test Payment"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditProfilePage();
              }));
            },
            child: Text("Test Edit Profile Page"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BookMarkPage();
              }));
            },
            child: Text("Test Bookmark Profile Page"),
          ),
          // ElevatedButton(
          //   onPressed: () async {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) {
          //       return SearchResultPage();
          //     }));
          //   },
          //   child: Text("Test Search Result"),
          // ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: SizedBox(height: 500, child: DonatePackageListHome()),
          ),
        ]),
      );
    }));
  }
}
