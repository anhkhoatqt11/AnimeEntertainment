import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

class TopAnimeEpisodeItem extends StatelessWidget {
  final String? urlImage;
  final String? nameItem;
  const TopAnimeEpisodeItem(
      {super.key, required this.urlImage, required this.nameItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //forward episdoe page
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
