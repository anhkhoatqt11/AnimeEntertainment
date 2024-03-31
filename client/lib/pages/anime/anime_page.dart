import 'package:anime_and_comic_entertainment/components/HotSeries.dart';
import 'package:anime_and_comic_entertainment/components/MainBanner.dart';
import 'package:anime_and_comic_entertainment/components/animes/AnimeAlbum.dart';
import 'package:anime_and_comic_entertainment/components/animes/AnimeBanner.dart';
import 'package:anime_and_comic_entertainment/components/animes/NewEpisodeList.dart';
import 'package:anime_and_comic_entertainment/components/animes/TopRankingAnime.dart';
import 'package:anime_and_comic_entertainment/components/comic/ComicItem.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:shimmer/shimmer.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key});

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GFAppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF141414),
          title: const Text(
            "Anime",
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            GFIconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              onPressed: () {},
              type: GFButtonType.transparent,
            ),
          ],
        ),
        backgroundColor: Color(0xFF141414),
        body: ListView(
          children: [
            AnimeBanner(),
            // SizedBox(
            //   height: 10,
            // ),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            //   child: Text(
            //     "Đọc tiếp",
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 20,
            //         fontWeight: FontWeight.w600),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            //   child: SizedBox(
            //     height: 228,
            //     child: CurrentReadingUser(),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "Tập mới, xem ngay!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.9 * 9 / 16 + 86,
                  child: NewEpisodeList()),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: AnimeAlbumComponent(),
            ),
          ],
        ));
  }
}
