import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/providers/mini_player_controller_provider.dart';
import 'package:anime_and_comic_entertainment/providers/video_provider.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CurrentView extends StatelessWidget {
  final String urlImage;
  final String nameItem;
  final double percentage;
  final String animeId;
  final String episodeId;
  const CurrentView(
      {super.key,
      required this.urlImage,
      required this.nameItem,
      required this.percentage,
      required this.animeId,
      required this.episodeId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<VideoProvider>(context, listen: false).setAnime(
            Animes(
              id: animeId,
            ),
            AnimeEpisodes(id: episodeId));
        Provider.of<MiniPlayerControllerProvider>(context, listen: false)
            .setMiniController(PanelState.MAX);
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          width: 191,
          child: Column(children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                CachedNetworkImage(
                  imageUrl: urlImage,
                  width: 191,
                  height: 108,
                  placeholder: (context, url) => Container(
                    height: 108,
                    width: 191,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4)),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 191,
                        height: 108,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill)),
                    );
                  },
                ),
                Opacity(
                  opacity: 0.8,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(360)),
                  ),
                ),
                Positioned(
                  right: 84,
                  top: 42,
                  child: ShaderMask(
                      shaderCallback: (rect) => LinearGradient(
                            colors: Utils.gradientColors,
                            begin: Alignment.centerLeft,
                          ).createShader(rect),
                      child: const FaIcon(FontAwesomeIcons.play,
                          color: Colors.white, size: 26)),
                ),
                // define percentage here----------------------------------------------------------------------------------------//
                Positioned(
                    bottom: 0,
                    left: -10,
                    child: GFProgressBar(
                        width: 191,
                        percentage: percentage,
                        backgroundColor: Colors.black26,
                        progressBarColor: Utils.primaryColor))
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                nameItem,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
