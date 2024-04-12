import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

class ComicLandspaceItem extends StatelessWidget {
  final String? urlImage;
  final String? nameItem;
  final List<dynamic>? genres;
  final String? description;
  const ComicLandspaceItem(
      {super.key,
      required this.urlImage,
      required this.nameItem,
      required this.genres,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 6, 6),
      child: SizedBox(
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
    );
  }
}

class GenresBranch extends StatelessWidget {
  final List<dynamic> genreList;
  const GenresBranch({super.key, required this.genreList});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: List.generate(genreList.length, (index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
          child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color.fromARGB(29, 218, 94, 240)),
              child: Center(
                child: ShaderMask(
                  shaderCallback: (rect) => LinearGradient(
                    colors: Utils.gradientColors,
                    begin: Alignment.topCenter,
                  ).createShader(rect),
                  child: Text(
                    genreList[index]['genreName'],
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              )),
        );
      }),
    );
  }
}
