import 'package:anime_and_comic_entertainment/components/CurrentReadingUser.dart';
import 'package:anime_and_comic_entertainment/components/animes/AnimeBanner.dart';
import 'package:anime_and_comic_entertainment/components/animes/NewEpisodeList.dart';
import 'package:anime_and_comic_entertainment/components/animes/WatchingHistoriesList.dart';
import 'package:anime_and_comic_entertainment/components/comic/ComicAlbum.dart';
import 'package:anime_and_comic_entertainment/components/comic/ComicBanner.dart';
import 'package:anime_and_comic_entertainment/components/comic/NewChapterList.dart';
import 'package:anime_and_comic_entertainment/components/home/HomeAlbum.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF141414),
        appBar: GFAppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF141414),
          title: const Text(
            "Trang chủ",
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
        body: ListView(
          children: [
            const AnimeBanner(),
            Consumer(builder: (context, watch, _) {
              final user = Provider.of<UserProvider>(context).user;
              return user.authentication['sessionToken'] != ""
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
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
                  : const SizedBox.shrink();
            }),
            const SizedBox(
              height: 10,
            ),
            const Padding(
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
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.9 * 9 / 16 + 86,
                  child: const NewEpisodeList()),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "Chương mới, xem ngay!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: SizedBox(height: 256, child: NewChapterList()),
            ),
            const ComicBanner(),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
              child: Text(
                "Đọc tiếp",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: SizedBox(
                height: 228,
                child: CurrentReadingUser(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: HomeAlbumComponent(),
            ),
          ],
        ));
  }
}


// GestureDetector(
//             onTap: () {
//               Provider.of<VideoProvider>(context, listen: false).setAnime(
//                   Animes(
//                     id: "65fbe3717e4914bdd8125052",
//                   ),
//                   AnimeEpisodes(id: "65ffea9c65ac19bed872183c"));
//               Provider.of<MiniPlayerControllerProvider>(context, listen: false)
//                   .setMiniController(PanelState.MAX);
//             },
//             child: Container(
//               height: 100,
//               width: 200,
//               color: Colors.green,
//               child: const Text("Home"),
//             ),