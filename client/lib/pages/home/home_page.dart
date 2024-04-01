import 'package:anime_and_comic_entertainment/components/animes/TopRankingAnime.dart';
import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/pages/anime/anime_page.dart';
import 'package:anime_and_comic_entertainment/pages/anime/watch_anime_page.dart';
import 'package:anime_and_comic_entertainment/providers/mini_player_controller_provider.dart';
import 'package:anime_and_comic_entertainment/providers/video_provider.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/carousel/gf_items_carousel.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
          "Truyện Tranh",
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
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Provider.of<VideoProvider>(context, listen: false).setAnime(
                  Animes(
                    id: "65fbe3717e4914bdd8125052",
                  ),
                  AnimeEpisodes(id: "65ffea9c65ac19bed872183c"));
              Provider.of<MiniPlayerControllerProvider>(context, listen: false)
                  .setMiniController(PanelState.MAX);
            },
            child: Container(
              height: 100,
              width: 200,
              color: Colors.green,
              child: const Text("Home"),
            ),
          ),
        ],
      ),
    );
  }
}
