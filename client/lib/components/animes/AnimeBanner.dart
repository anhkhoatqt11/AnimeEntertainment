import 'package:anime_and_comic_entertainment/model/banner.dart';
import 'package:anime_and_comic_entertainment/pages/anime/detail_anime_page.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class AnimeBanner extends StatefulWidget {
  const AnimeBanner({super.key});

  @override
  State<AnimeBanner> createState() => _AnimeBannerState();
}

class _AnimeBannerState extends State<AnimeBanner> {
  List<BannerItem> listBanner = [];
  Future<List<BannerItem>> getAnimeBanner() async {
    var result = await AnimesApi.getAnimeBanner(context);
    return result;
  }

  @override
  void initState() {
    super.initState();

    getAnimeBanner().then((value) => value.forEach((element) {
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4)),
                  ),
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
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailAnimePage(animeId: listItem.urlId)),
                          )
                        },
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
