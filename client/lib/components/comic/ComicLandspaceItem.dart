import 'package:anime_and_comic_entertainment/components/ui/GenresBranch.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_detail.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

class ComicLandspaceItem extends StatelessWidget {
  final String? urlImage;
  final String? nameItem;
  final List<dynamic>? genres;
  final String? description;
  final String? comicId;
  const ComicLandspaceItem(
      {super.key,
      required this.urlImage,
      required this.nameItem,
      required this.genres,
      required this.description,
      required this.comicId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 6, 6),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailComicPage(comicId: comicId!),
            ),
          );
        },
        child: Container(
          color: const Color(0xFF141414),
          height: 187,
          child: Row(children: [
            CachedNetworkImage(
              imageUrl: urlImage!,
              width: 125,
              height: 187,
              placeholder: (context, url) => Container(
                height: 187,
                width: 125,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(4)),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 125,
                    height: 187,
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
              width: 10,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
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
                  const SizedBox(
                    height: 10,
                  ),
                  GenresBranch(genreList: genres!),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    description!,
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
    );
  }
}
