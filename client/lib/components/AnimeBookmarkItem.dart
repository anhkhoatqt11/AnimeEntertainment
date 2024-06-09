import 'package:anime_and_comic_entertainment/components/ui/GenresBranch.dart';
import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/pages/anime/detail_anime_page.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_detail.dart';
import 'package:anime_and_comic_entertainment/providers/mini_player_controller_provider.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/video_provider.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AnimeBookmarkItem extends StatelessWidget {
  final String animeepisodeId;
  final String animeId;
  final String movieName;
  final bool isBookmarked;
  final bool isChecked;
  final String coverImage;
  final String episodeName;
  final List genreNames;
  final ValueChanged<bool?>? onChanged;

  const AnimeBookmarkItem({
    Key? key,
    required this.animeepisodeId,
    required this.animeId,
    required this.coverImage,
    required this.movieName,
    required this.episodeName,
    required this.genreNames,
    required this.isBookmarked,
    this.isChecked = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              if (onChanged != null) // Show checkbox only when editing
                Checkbox(
                  value: isChecked,
                  onChanged: onChanged,
                  checkColor: Colors.white,
                  activeColor: Utils.primaryColor,
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (onChanged == null) {
                        Provider.of<VideoProvider>(context, listen: false)
                            .setAnime(
                                Animes(
                                  id: animeId,
                                ),
                                AnimeEpisodes(
                                    id: animeepisodeId,
                                    episodeName: episodeName));
                        Provider.of<MiniPlayerControllerProvider>(context,
                                listen: false)
                            .setMiniController(PanelState.MAX);
                      }
                    },
                    child: Container(
                      color: const Color(0xFF141414),
                      height: 120,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: coverImage,
                              width: 100,
                              height: 100,
                              placeholder: (context, url) => Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    movieName,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (onChanged == null)
                                    GenresBranch(genreList: genreNames),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    episodeName,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
