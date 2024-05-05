import 'package:anime_and_comic_entertainment/components/animes/WatchingHistoriesList.dart';
import 'package:anime_and_comic_entertainment/components/comic/TopRankingComic.dart';
import 'package:anime_and_comic_entertainment/components/donate/DonatePackageListHome.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/components/ui/DonateBannerHome.dart';
import 'package:anime_and_comic_entertainment/pages/home/search_page.dart';
import 'package:anime_and_comic_entertainment/pages/home/search_result_page.dart';
import 'package:anime_and_comic_entertainment/pages/payment.dart';
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PaymentScreen();
                }));
              },
              child: Text("Test payment")),
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
                return SearchResultPage();
              }));
            },
            child: Text("Test Search Result"),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: SizedBox(height: 500, child: DonatePackageListHome()),
          ),
        ]),
      );
    }));
  }
}
