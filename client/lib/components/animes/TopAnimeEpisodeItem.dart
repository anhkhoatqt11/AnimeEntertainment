import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/providers/mini_player_controller_provider.dart';
import 'package:anime_and_comic_entertainment/providers/video_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

class TopAnimeEpisodeItem extends StatelessWidget {
  final String? urlImage;
  final String? nameItem;
  final String? episodeId;
  final String? animeId;
  const TopAnimeEpisodeItem(
      {super.key,
      required this.urlImage,
      required this.nameItem,
      required this.episodeId,
      required this.animeId});

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
          width: MediaQuery.of(context).size.width * 0.44,
          child: Column(children: [
            CachedNetworkImage(
              imageUrl: urlImage!,
              width: MediaQuery.of(context).size.width * 0.44,
              height: MediaQuery.of(context).size.width * 0.44 * 9 / 16,
              placeholder: (context, url) => Container(
                height: MediaQuery.of(context).size.width * 0.44 * 9 / 16,
                width: MediaQuery.of(context).size.width * 0.44,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(4)),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.44,
                    height: MediaQuery.of(context).size.width * 0.44 * 9 / 16,
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
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                nameItem!,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
