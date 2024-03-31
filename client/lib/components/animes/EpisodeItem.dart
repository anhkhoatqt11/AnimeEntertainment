import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

class EpisodeItem extends StatelessWidget {
  final String? urlImage;
  final String? nameItem;
  final int? views;
  const EpisodeItem(
      {super.key,
      required this.urlImage,
      required this.nameItem,
      required this.views});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              color: Colors.blue,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 191,
                  height: 108,
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
    );
  }
}
