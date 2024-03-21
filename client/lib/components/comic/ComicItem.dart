import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

class ComicItem extends StatelessWidget {
  final String? urlImage;
  final String? nameItem;
  final List<dynamic>? genres;
  const ComicItem(
      {super.key,
      required this.urlImage,
      required this.nameItem,
      required this.genres});

  @override
  Widget build(BuildContext context) {
    String genreList = "";
    genres!.forEach((element) {
      genreList += (element['genreName']) + "/ ";
    });
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: 125,
        child: Column(children: [
          CachedNetworkImage(
            imageUrl: urlImage!,
            width: 125,
            height: 187,
            placeholder: (context, url) => Container(
              height: 187,
              width: 125,
              color: Colors.blue,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 125,
                  height: 187,
                  color: Colors.yellow,
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
                fontWeight: FontWeight.w700,
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
    );
  }
}
