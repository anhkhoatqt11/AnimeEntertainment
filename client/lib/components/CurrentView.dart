import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CurrentView extends StatelessWidget {
  final String urlImage;
  final String nameItem;
  const CurrentView(
      {super.key, required this.urlImage, required this.nameItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: 191,
        child: Column(children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
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
              Opacity(
                opacity: 0.8,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(360)),
                ),
              ),
              Positioned(
                right: 82,
                child: ShaderMask(
                    shaderCallback: (rect) => LinearGradient(
                          colors: Utils.gradientColors,
                          begin: Alignment.topCenter,
                        ).createShader(rect),
                    child: FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
              // define percentage here----------------------------------------------------------------------------------------//
              Positioned(
                  bottom: 0,
                  left: -10,
                  child: GFProgressBar(
                      width: 191,
                      percentage: 0.5,
                      backgroundColor: Colors.black26,
                      progressBarColor: Utils.primaryColor))
            ],
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
