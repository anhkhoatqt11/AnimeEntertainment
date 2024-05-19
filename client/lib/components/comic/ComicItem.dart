import 'package:anime_and_comic_entertainment/pages/comic/comic_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

class ComicItem extends StatelessWidget {
  final String? comicId;
  final String? urlImage;
  final String? nameItem;
  final List<dynamic>? genres;
  const ComicItem(
      {super.key,
      required this.comicId,
      required this.urlImage,
      required this.nameItem,
      required this.genres});

  @override
  Widget build(BuildContext context) {
    String genreList = "";
    genres!.forEach((element) {
      genreList += (element['genreName']) + "/ ";
    });
    if (genres!.length == 0) {
      genreList += "/ ";
    }
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailComicPage(comicId: this.comicId!),
            ),
          );
        },
        child: Container(
          width: 118,
          child: Column(children: [
            CachedNetworkImage(
              imageUrl: urlImage!,
              width: 118,
              height: 180,
              placeholder: (context, url) => Container(
                height: 180,
                width: 118,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(4)),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 118,
                    height: 180,
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
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                genreList.substring(0, genreList.length - 2),
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
