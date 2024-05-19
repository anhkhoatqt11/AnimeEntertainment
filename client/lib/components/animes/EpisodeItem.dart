import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/providers/mini_player_controller_provider.dart';
import 'package:anime_and_comic_entertainment/providers/video_provider.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

class EpisodeItem extends StatelessWidget {
  final String? urlImage;
  final String? nameItem;
  final int? views;
  final String? animeId;
  final String? episodeId;
  const EpisodeItem(
      {super.key,
      required this.urlImage,
      required this.nameItem,
      required this.views,
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
            AnimeEpisodes(id: episodeId, episodeName: nameItem));
        Provider.of<MiniPlayerControllerProvider>(context, listen: false)
            .setMiniController(PanelState.MAX);
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          width: 191,
          child: Column(children: [
            CachedNetworkImage(
              imageUrl: urlImage!,
              width: 191,
              height: 108,
              placeholder: (context, url) => Container(
                height: 108,
                width: 191,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(4)),
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
            const SizedBox(
              height: 6,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                nameItem!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                "Lượt xem: ${Utils.formatNumberWithDots(views!)}",
                maxLines: 2,
                style: const TextStyle(
                  height: 1.2,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
