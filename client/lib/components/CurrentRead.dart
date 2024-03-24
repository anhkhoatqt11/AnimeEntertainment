import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class CurrentRead extends StatelessWidget {
  final String urlImage;
  final String nameItem;
  const CurrentRead(
      {super.key, required this.urlImage, required this.nameItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: 125,
        child: Column(children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              CachedNetworkImage(
                imageUrl: urlImage,
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
              Opacity(
                opacity: 0.6,
                child: Container(
                  width: 125,
                  height: 187,
                  color: Colors.black,
                ),
              ),
              FaIcon(
                FontAwesomeIcons.readme,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Expanded(
                  child: Align(
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
              )),
              Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
                size: 18,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
