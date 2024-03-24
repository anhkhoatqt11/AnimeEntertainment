import 'package:anime_and_comic_entertainment/model/banner.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ComicBanner extends StatefulWidget {
  const ComicBanner({super.key});

  @override
  State<ComicBanner> createState() => _ComicBannerState();
}

class _ComicBannerState extends State<ComicBanner> {
  List<BannerItem> listBanner = [];
  Future<List<BannerItem>> getComicBanner() async {
    var result = await ComicsApi.getComicBanners(context);
    return result;
  }

  @override
  void initState() {
    super.initState();

    getComicBanner().then((value) => value.forEach((element) {
          setState(() {
            listBanner.add(BannerItem(
                bannerImage: element.bannerImage, urlId: element.urlId));
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return (listBanner.isEmpty
        ? AspectRatio(
            aspectRatio: 16 / 9,
            child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.blue,
                )))
        : GFCarousel(
            viewportFraction: 0.9,
            hasPagination: true,
            autoPlay: true,
            pagerSize: 0.8,
            autoPlayInterval: const Duration(seconds: 2),
            autoPlayAnimationDuration: const Duration(milliseconds: 400),
            passiveIndicator: const Color.fromARGB(186, 255, 255, 255),
            activeIndicator: Utils.primaryColor,
            items: listBanner.map(
              (listItem) {
                return GestureDetector(
                    onTap: () => {print(listItem)},
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        child: CachedNetworkImage(
                          imageUrl: listItem.bannerImage!,
                          width: 1300,
                          placeholder: (context, url) => Container(
                            width: 1300,
                            color: Colors.blue,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: 1300,
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                            );
                          },
                        ),
                      ),
                    ));
              },
            ).toList(),
          ));
  }
}
