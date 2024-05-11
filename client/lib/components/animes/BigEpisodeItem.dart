import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/providers/mini_player_controller_provider.dart';
import 'package:anime_and_comic_entertainment/providers/video_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

class BigEpisodeItem extends StatelessWidget {
  final String? urlImage;
  final String? nameItem;
  final String? episodeName;
  final String? animeId;
  final String? episodeId;
  const BigEpisodeItem(
      {super.key,
      required this.urlImage,
      required this.nameItem,
      required this.episodeName,
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
            AnimeEpisodes(id: episodeId, episodeName: episodeName));
        Provider.of<MiniPlayerControllerProvider>(context, listen: false)
            .setMiniController(PanelState.MAX);
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(children: [
            CachedNetworkImage(
              imageUrl: urlImage!,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.9 * 9 / 16,
              placeholder: (context, url) => Container(
                height: MediaQuery.of(context).size.width * 0.9 * 9 / 16,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(4)),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.9 * 9 / 16,
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
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                nameItem!,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                episodeName!,
                maxLines: 2,
                style: const TextStyle(
                  height: 1.5,
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
