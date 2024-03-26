import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/pages/anime/anime_page.dart';
import 'package:anime_and_comic_entertainment/pages/anime/watch_anime_page.dart';
import 'package:anime_and_comic_entertainment/providers/mini_player_controller_provider.dart';
import 'package:anime_and_comic_entertainment/providers/video_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<VideoProvider>(context, listen: false).setAnime(Animes(
              id: "asss",
              movieName: "aallla",
            ));
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
        GestureDetector(
          onTap: () {
            Provider.of<VideoProvider>(context, listen: false)
                .setAnime(Animes(id: "bsss", movieName: "aallla"));
            Provider.of<MiniPlayerControllerProvider>(context, listen: false)
                .setMiniController(PanelState.MAX);
          },
          child: Container(
            height: 100,
            width: 200,
            color: Colors.blue,
            child: const Text("Home"),
          ),
        )
      ],
    );
  }
}
