import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

class LandspaceItem extends StatelessWidget {
  final String urlImage;
  final String nameItem;
  const LandspaceItem(
      {super.key, required this.urlImage, required this.nameItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: 191,
        child: Column(children: [
          CachedNetworkImage(
            imageUrl: urlImage,
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
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              nameItem,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
