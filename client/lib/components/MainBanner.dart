import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

final List<String> imageList = [
  "https://vnw-img-cdn.popsww.com/api/v2/containers/file2/cms_topic/_t_p_m_i_tagline-da6dcb8f74a8-1686305754531-gCwpREbI.png?v=0&maxW=260",
  "https://vnw-img-cdn.popsww.com/api/v2/containers/file2/cms_topic/phim_moi-fdc866c73fd2-1708663384221-h3BlLVOZ.png?v=0&maxW=260",
  "https://vnw-img-cdn.popsww.com/api/v2/containers/file2/cms_topic/vertical_poster-6edb1870a631-1708400087928-NOgvY5n0.png?v=0&maxW=260",
  "https://vnw-img-cdn.popsww.com/api/v2/containers/file2/cms_topic/vertical_poster-128d9c4e3cfc-1708400799846-D1MOGy71.png?v=0&maxW=260",
];

class MainBanner extends StatefulWidget {
  const MainBanner({super.key});

  @override
  State<MainBanner> createState() => _MainBannerState();
}

class _MainBannerState extends State<MainBanner> {
  @override
  Widget build(BuildContext context) {
    return GFCarousel(
      aspectRatio: 1,
      viewportFraction: 0.9,
      enlargeMainPage: true,
      items: imageList.map(
        (url) {
          return GestureDetector(
              onTap: () => {print(url)},
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    width: 1200,
                    height: 187,
                    placeholder: (context, url) => Container(
                      height: 187,
                      width: 1200,
                      color: Colors.blue,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 1200,
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
                ),
              ));
        },
      ).toList(),
      onPageChanged: (index) {
        setState(() {
          index;
        });
      },
    );
  }
}
